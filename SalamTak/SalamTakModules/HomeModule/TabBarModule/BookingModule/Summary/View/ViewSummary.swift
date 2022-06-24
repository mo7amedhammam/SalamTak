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
                ScrollView{
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
                }
                .background(Color("CLVBG"))
            }.disabled(CreateAppointment.isDone)
            
            VStack{
                AppBarView(Title: "Summary".localized(language))
                    .navigationBarBackButtonHidden(true)
                Spacer()
            }
            .edgesIgnoringSafeArea(.top)

            PopUpView(IsPresented: .constant(true), content: {
                ConfirmButton( Doctor: Doctor).environmentObject(CreateAppointment)
                
            })
    
            // showing loading indicator
            ActivityIndicatorView(isPresented: $CreateAppointment.isLoading)
            
            //                    .overlay(content: {
            ImageViewerRemote(imageURL: $previewImageurl , viewerShown: $ispreviewImage, disableCache: true, closeButtonTopRight: true)
            //                    })
            
            
            //      go to clinic info
            NavigationLink(destination:TabBarView(selectedTab:"TabBar_schedual"),isActive: $GotoSchedual) {
            }
            
            //      go to clinic info
            NavigationLink(destination:WelcomeScreenView(),isActive: $goToLogin) {
            }
            
        }
        //            .navigationBarHidden(ispreviewImage)
        .navigationViewStyle(StackNavigationViewStyle())
        .background(Color.red)
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
                ConfirmationPopUp(BookiDate: $BookiDate, BookiTime: $BookiTime, GotoSchedual: $GotoSchedual).environmentObject(CreateAppointment)
                Spacer()
            }
            .shadow(color: .black.opacity(0.3), radius: 12)
            .padding()
        }
        .navigationBarHidden(ispreviewImage)

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
    }
}

struct ViewSummary_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ViewSummary(Doctor: Doc.init(), ExType: .constant(5),BookingscedualId :.constant(645454545),BookiDate :.constant(Date()),BookiTime :.constant("18:33"))
        }.navigationBarHidden(true)
    }
}



