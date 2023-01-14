//
//  ViewSummary.swift
//  SalamTech
//
//  Created by Mohamed Hammam on 17/04/2022.
//


import SwiftUI
import Kingfisher
import ImageViewerRemote
//import XCTest

struct ViewSummary:View{
    var language = LocalizationService.shared.language
    @StateObject var CreateAppointment = VMCreateAppointment()
    @EnvironmentObject var environments : EnvironmentsVM

    var Doctor:Doc
    @Binding var ExType :Int
    @Binding var BookingscedualId :Int
    @Binding var BookiDate :Date
    @Binding var BookiTime :String
    
    @State var GotoSchedual = false
   
    @State var ispreviewImage = false
    @State var previewImageurl = ""
    @State var goToLogin = false

    var body: some View{
        ZStack{
            VStack {
                AppBarView(Title: "Summary".localized(language),backColor: .clear,withbackButton: !ispreviewImage)
                    .frame(height:50)
                    .padding(.top,-20)

                ScrollView{
//                    Spacer().frame(height:20)
                    ZStack {
                        VStack(alignment:.leading){
                            ViewTopSection(Doctor: Doctor, ispreviewImage: $ispreviewImage, previewImageurl: $previewImageurl)
                            
                            Image("Line")
                                .resizable()
                                .renderingMode(.original)
                                .tint(.black)
                                .frame( height: 2)
                                .foregroundColor(.black)
                            
                            //MARK: ----- Booking Details --------
                            BookingDetails(Doctor: Doctor, ExType: $ExType, BookiDate: $BookiDate, BookiTime: $BookiTime)
                            
                            //MARK: ----- Patient Details ------
                            PatientDetails()
                            
                            //MARK: ----- Booking Price ------
                            HStack{
                                Text("Total_Fee".localized(language))
                                Spacer()
                                ZStack {
                                    Text("\(String(Doctor.FeesFrom ?? 0.0)) "+"EGP".localized(language))
                                        .fontWeight(.semibold)
                                        .font(.title3)
                                }
                                .padding(10)
                                .foregroundColor(Color("darkGreen"))
                                .background(Color("darkGreen").opacity(0.3))
                                .cornerRadius(12)
                                .border( .regularMaterial ,width: 1.1)
                            }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                                .padding(.top, 0)
                                .padding(.horizontal, 20)
                            Spacer()
                        }
                        .background(Color.white)
                        .cornerRadius(9)
                        .shadow(color: .black.opacity(0.1), radius: 9)
                    }
                    .padding(.horizontal,15)
                    .padding(.top,10)
                }
                .padding(.bottom,130)
//                .background(Color("CLVBG"))
            }.disabled(CreateAppointment.isDone)
            
//            VStack{
//                AppBarView(Title: "Summary".localized(language))
//                    .frame(height:70)
//                    .padding(.top,-20)
//
//                    .navigationBarBackButtonHidden(true)
//                Spacer()
//            }
//            .edgesIgnoringSafeArea(.top)

            PopUpView(IsPresented: .constant(true), content: {
                ConfirmButton( Doctor: Doctor)
                    .environmentObject(CreateAppointment)
//                    .environmentObject(environments)
            })
    
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
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                if self.CreateAppointment.isDone == false && !ispreviewImage{
                    BackButtonView()
                }
            }
        }
        
        .popup(isPresented: $CreateAppointment.isDone){
            BottomPopupView{
                ConfirmationPopUp(BookiDate: $BookiDate, BookiTime: $BookiTime, GotoSchedual: $GotoSchedual)
                    .environmentObject(CreateAppointment)
                    .environmentObject(environments)
                Spacer()
            }
            .shadow(color: .black.opacity(0.3), radius: 12)
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
            ViewSummary(Doctor: Doc.init(), ExType: .constant(5),BookingscedualId :.constant(645454545),BookiDate :.constant(Date()),BookiTime :.constant("18:33"))
                .environmentObject(EnvironmentsVM())
        }.navigationBarHidden(true)
    }
}



