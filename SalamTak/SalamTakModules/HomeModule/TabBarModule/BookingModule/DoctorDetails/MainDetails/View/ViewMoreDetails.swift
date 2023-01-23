//
//  ViewMoreDetails.swift
//  SalamTak
//
//  Created by wecancity on 22/01/2023.
//

import SwiftUI
import ImageViewerRemote

struct ViewMoreDetails:View{
    @EnvironmentObject var DocDetails : ViewModelDocDetails
    @StateObject var DocClinics = ViewModelDocClinics()

    @EnvironmentObject var environments : EnvironmentsVM
    @Environment(\.presentationMode) var presentationMode

    var Doctor:Doc

    @State var showQuickLogin = false
    @State var GotoBooking = false
    @State var GotoReviews = false
    @State var GotoAddReview = false
    var language = LocalizationService.shared.language
    @Binding var ExType :Int
    //Calendar
    @State var ShowCalendar = false
    @State var BookingClinicId = 0
    @State var BookingFees:Int = 0

    @State var presentLogin = false
    @State var presentReservation = false
    @State var ispreviewImage=false
    @State var previewImageurl=""
    
    var body: some View{
        ZStack {
            VStack(spacing:0){
                Image("logo")
                    .resizable()
                    .frame(width:220, height: 150)
                    .aspectRatio( contentMode: .fit)
                
                Text("Booking_".localized(language))
                    .foregroundColor(.salamtackWelcome)
                    .font(.system(size: 30))
                    .bold()
                    .padding(.top,-30)

                ScrollView {
                    ViewDocMainInfo(Doctor: Doctor, operation: .Details, ispreviewImage: $ispreviewImage, previewImageurl: $previewImageurl)
                         
                    ViewAboutDoctor(DoctorAbout: DocDetails.publishedModelSearchDoc?.DoctorInfo ?? "")
                    
                    ViewDoctorClinics(Doctor: Doctor,gotoBooking: $GotoBooking,BookingClinicId: $BookingClinicId)
                        .environmentObject(DocClinics)
                    
                    ViewDocReviews( Doctor: Doctor, GotoReviews: $GotoReviews, GotoAddReview: $GotoAddReview)
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width-20)
                .background(.clear)
                
                Spacer()
                HStack{
                    Button(action: {
                        // add review
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        HStack {
                            Text("Back_".localized(language))
                                .fontWeight(.semibold)
                                .font(.title2)
                        }
                        .frame(minWidth: 0, maxWidth: 150)
                            .padding()
                            .foregroundColor(.salamtackBlue)
                            .cornerRadius(12)
                    })
                        .AddBlueBorder()
                }
                .padding(.horizontal)
            }
            .blur(radius: ShowCalendar||showQuickLogin ? 9:0)
            .disabled(ShowCalendar)
            if showQuickLogin == true{
                quickLoginSheet(IsPresented: $showQuickLogin, QuickLogin: $presentLogin,QuickReservation: $presentReservation  , width: UIScreen.main.bounds.width)
            }
            
            if ShowCalendar == true{
                ZStack{
                    calendarPopUp(selectedDate: $DocDetails.SchedualDate, isPresented: $ShowCalendar)
                }
            }
            
            // go to summary
            NavigationLink(destination:
                            ViewBooking(Doctor: Doctor, ExType: $ExType, BookingClinicId: BookingClinicId)
                            .environmentObject(environments)
                            .environmentObject(DocDetails)
                            .navigationBarHidden(true),isActive: $GotoBooking) {
            }
            
            // go to Reviews
            NavigationLink(destination:ReviewsView( DoctorId: Doctor.id ?? 0),isActive: $GotoReviews) {
            }
            
            // go to addReview
            NavigationLink(destination:ViewAddReview( Doctor: Doctor, schedule: AppointmentInfo.init()),isActive: $GotoAddReview) {
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onReceive(navController.popToRoot, perform: {newval in
            GotoBooking = newval
            GotoReviews = newval
            GotoAddReview = newval
        })
        .edgesIgnoringSafeArea(.top)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                if !showQuickLogin && !ispreviewImage{
                    BackButtonView()
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear(perform: {
            DocClinics.DoctorId = Doctor.id ?? 0
            DocClinics.FetchDoctorClinics()
        })

        .overlay(content: {
            ImageViewerRemote(imageURL: $previewImageurl , viewerShown: $ispreviewImage, disableCache: true, closeButtonTopRight: true)
        })
        .navigationViewStyle(StackNavigationViewStyle())
        .background(
            newBackImage(backgroundcolor: .white, imageName:.image2)
        )
    }
}

struct ViewMoreDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ViewMoreDetails(Doctor: Doc.init(), ExType: .constant(2))
                .environmentObject(ViewModelDocDetails())
                .environmentObject(EnvironmentsVM())
        }.navigationBarHidden(true)
    }
}















