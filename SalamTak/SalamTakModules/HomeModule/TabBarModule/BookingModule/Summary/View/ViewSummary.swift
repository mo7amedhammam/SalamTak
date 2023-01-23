//
//  ViewSummary.swift
//  SalamTech
//
//  Created by Mohamed Hammam on 17/04/2022.
//


import SwiftUI
//import Kingfisher
import ImageViewerRemote
//import XCTest

struct ViewSummary:View{
    var language = LocalizationService.shared.language
    @StateObject var CreateAppointment = VMCreateAppointment()
    @EnvironmentObject var environments : EnvironmentsVM

    var Doctor:Doc
//    var ClinicId:Int

    @Binding var ExType :Int
    @Binding var BookingscedualId :Int
    @Binding var BookiDate :Date
    @Binding var BookiTime :String
    @Binding var BookingFees :Int

    @State var GotoSchedual = false
   
    @State var ispreviewImage = false
    @State var previewImageurl = ""
    @State var goToLogin = false

    var body: some View{
        ZStack{
            
            VStack {
                
                ZStack {
                    AppBarView(Title: "".localized(language),backColor: .clear,withbackButton: !ispreviewImage)
                        .frame(height:50)

                    Image("logo")
                        .resizable()
                        .frame(width:220, height: 150)
                    .aspectRatio( contentMode: .fit)
                }
                Text("Summary_".localized(language))
                    .foregroundColor(.salamtackWelcome)
                    .font(.system(size: 30))
                    .bold()
                    .padding(.top,-30)


                ScrollView{
//                    Spacer().frame(height:20)
                        VStack(alignment:.leading){
                            ViewTopSection(Doctor: Doctor, ispreviewImage: $ispreviewImage, previewImageurl: $previewImageurl)
                            
//                            Image("Line")
//                                .resizable()
//                                .renderingMode(.original)
//                                .tint(.black)
//                                .frame( height: 2)
//                                .foregroundColor(.black)
                            
                            //MARK: ----- Booking Details --------
                            BookingDetails(Doctor: Doctor, ExType: $ExType, BookiDate: $BookiDate, BookiTime: $BookiTime)
                            
                            //MARK: ----- Patient Details ------
                            PatientDetails()
                            

//                            .padding(.top, 0)
//                            .padding(.horizontal, 20)
//                            Spacer()
                        }
                        .cornerRadius(9)
                        //MARK: ----- Booking Price ------
                        VStack{
                            HStack {
                                Text("Total_Fee".localized(language))
                                    .foregroundColor(.white)
                                    .font(.system(size: 20))
                                    .bold()
                            }
                            .padding(.horizontal,20)
                            .padding(.vertical ,8)
                            .background(Color.salamtackWelcome)
                            .cornerRadius(20)
//                                Spacer()
//                                ZStack {
                                Text("\(String(BookingFees ?? 0)) "+"EGP".localized(language))
                                .foregroundColor(.salamtackBlue)
                                .font(.system(size: 25))
                                .fontWeight(.bold)

//                                }
//                                .padding(10)
//                                .foregroundColor(Color("darkGreen"))
//                                .background(Color("darkGreen").opacity(0.3))
//                                .cornerRadius(12)
//                                .border( .regularMaterial ,width: 1.1)
                        }
                    .padding(.horizontal,15)
                    .padding(.top,10)
                    
                    Button(action: {
                        CreateAppointment.CreatePatientAppointment()
                    }, label: {
                        Text("Finish_".localized(language))
                            .padding(.vertical,10)
                            .padding(.horizontal,30)
                            .font(.headline)
                            .foregroundColor(.salamtackBlue)
                    })
                        .buttonStyle(.plain)
                        .AddBlueBorder(linewidth:1.2)
                }
//                .padding(.bottom,130)
            }.disabled(CreateAppointment.isDone)
                .edgesIgnoringSafeArea(.top)

//                .toolbar {
//                    ToolbarItem(placement: .navigationBarLeading) {
//                        if self.CreateAppointment.isDone == false && !ispreviewImage{
//                            BackButtonView()
//                        }
//                    }
//                }
//            VStack{
//                AppBarView(Title: "Summary".localized(language))
//                    .frame(height:70)
//                    .padding(.top,-20)
//
//                    .navigationBarBackButtonHidden(true)
//                Spacer()
//            }
//            .edgesIgnoringSafeArea(.top)

//            PopUpView(IsPresented: .constant(true), content: {
//                ConfirmButton( Doctor: Doctor)
//                    .environmentObject(CreateAppointment)
////                    .environmentObject(environments)
//            })
    
            // showing loading indicator
            ActivityIndicatorView(isPresented: $CreateAppointment.isLoading)
            
            ImageViewerRemote(imageURL: $previewImageurl , viewerShown: $ispreviewImage, disableCache: true, closeButtonTopRight: true)
            
            //      go to clinic info
//            NavigationLink(destination:
//                            ServicesView()
////                            TabBarView(selectedTab:"TabBar_schedual").navigationBarHidden(true)
//                           ,isActive: $GotoSchedual) {
//            }
            
            //      go to clinic info
            NavigationLink(destination:WelcomeScreenView().navigationBarHidden(true),isActive: $goToLogin) {
            }
        }
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: {
            CreateAppointment.DoctorId = Doctor.id ?? 0
            CreateAppointment.DoctorWorkingDayTimeId = BookingscedualId
            CreateAppointment.AppointmentDate = "\(ChangeFormate(NewFormat: "yyyy-MM-dd").string(from: BookiDate))T\(BookiTime)"
            CreateAppointment.Fees = Doctor.FeesFrom  ?? 00
        })

        
        .popup(isPresented: $CreateAppointment.isDone){
            BottomPopupView{
                ConfirmationPopUp(BookiDate: $BookiDate, BookiTime: $BookiTime, GotoSchedual: $GotoSchedual)
                    .frame(width: UIScreen.main.bounds.width - 40, height: 400, alignment: .center)

                    .environmentObject(CreateAppointment)
                    .environmentObject(environments)
                Spacer()
            }
            .shadow(color: .black.opacity(0.7), radius: 3)
            .padding()
        }
//        .navigationBarHidden(ispreviewImage)

        // Alert with message
        .alert(isPresented: $CreateAppointment.isAlert, content: {
            Alert(title: Text(CreateAppointment.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                if CreateAppointment.activeAlert == .unauthorized{
                    self.goToLogin = true
                }else{
                    CreateAppointment.isAlert = false
                }
            }))
        })
        
        .background(
            newBackImage(backgroundcolor: .white, imageName:.image2)
        )

    }
}

struct ViewSummary_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ViewSummary(Doctor: Doc.init(), ExType: .constant(5),BookingscedualId :.constant(645454545),BookiDate :.constant(Date()),BookiTime :.constant("18:33"), BookingFees: .constant(0))
                .environmentObject(EnvironmentsVM())
        }.navigationBarHidden(true)
    }
}



