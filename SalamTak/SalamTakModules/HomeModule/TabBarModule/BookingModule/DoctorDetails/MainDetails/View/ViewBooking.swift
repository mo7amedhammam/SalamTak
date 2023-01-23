//
//  ViewDocDetails.swift
//  SalamTech
//
//  Created by Mohamed Hammam on 11/04/2022.
//

import SwiftUI
import Combine
import ImageViewerRemote

var selectedDate = Date()
var totalSquares = [Date]()

struct ViewBooking:View{
    @EnvironmentObject var DocDetails : ViewModelDocDetails
    @EnvironmentObject var environments : EnvironmentsVM
    @Environment(\.presentationMode) var presentationMode

    var Doctor:Doc
    @State var showQuickLogin = false
    @State var GotoSummary = false
    @State var GotoReviews = false
    @State var GotoAddReview = false
    var language = LocalizationService.shared.language
    @Binding var ExType :Int
    //Calendar
    @State var ShowCalendar = false
    @State var selectedSchedualId = 0
    @State var selectedTime = ""
    @State var BookingClinicId : Int
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
                    ViewDocMainInfo(Doctor: Doctor, operation: .Booking, ispreviewImage: $ispreviewImage, previewImageurl: $previewImageurl)
                    ViewDateAndTime(ShowCalendar: $ShowCalendar, selectedSchedualId: $selectedSchedualId , selectedTime:$selectedTime,DoctorId:.constant(Doctor.id ?? 0), ClinicId: $BookingClinicId,ExTypeId:$ExType, BookingFees:$BookingFees)
                        .environmentObject(DocDetails)
//                    ViewDocReviews( Doctor: Doctor, GotoReviews: $GotoReviews, GotoAddReview: $GotoAddReview)
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width-20)
                .background(.clear)
//                .padding(.top,-105)
                Spacer()
                HStack{

                    Button(action: {
                        // add review
                        self.presentationMode.wrappedValue.dismiss()

                    }, label: {
                        HStack {
                            Text("Cancel_".localized(language))
                                .fontWeight(.semibold)
                                .font(.title3)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.salamtackBlue)
                            .cornerRadius(12)
                    })
                        .AddBlueBorder()

                    Button(action: {
                        // add review
                        if Helper.userExist(){
                            // check if token is available
                            GotoSummary = true
                        }else{
                            showQuickLogin =  true
                        }
                    }, label: {
                        HStack {
                            Text("Book".localized(language))
                                .fontWeight(.semibold)
                                .font(.title3)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(selectedTime == "" ? .salamtackBlue.opacity(0.5):.salamtackBlue)
//                            .background(selectedTime == "" ?  Color("blueColor").opacity(0.2): Color("blueColor"))
                            .cornerRadius(12)
//                            .padding(.horizontal, 20)
                    })
                        .AddBlueBorder(linecolor:(selectedTime == "" ? .salamtackBlue.opacity(0.5):.salamtackBlue))
                        .disabled(selectedTime == "")
                }
                .padding(.horizontal)
//                .background(.clear
//                )
//                .shadow(color: .gray, radius: 9)
            }
            .blur(radius: ShowCalendar||showQuickLogin ? 9:0)
            .disabled(ShowCalendar)
//            .background(Color("CLVBG"))
            if showQuickLogin == true{
                quickLoginSheet(IsPresented: $showQuickLogin, QuickLogin: $presentLogin,QuickReservation: $presentReservation  , width: UIScreen.main.bounds.width)
            }
            
            if ShowCalendar == true{
                ZStack{
                    calendarPopUp(selectedDate: $DocDetails.SchedualDate, isPresented: $ShowCalendar)
                }
            }
            
            // go to summary
            NavigationLink(destination:ViewSummary(Doctor: Doctor, ExType: $ExType, BookingscedualId: $selectedSchedualId, BookiDate: $DocDetails.SchedualDate, BookiTime: $selectedTime, BookingFees: $BookingFees)
                            .environmentObject(environments)
                            .navigationBarHidden(true),isActive: $GotoSummary) {
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
            GotoSummary = newval
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
//        .navigationBarHidden(showQuickLogin||ShowCalendar||ispreviewImage)
        .navigationBarHidden(true)
//        .navigationBarBackButtonHidden(true)
        .onAppear(perform: {
            setWeekView()
        })
        .overlay(content: {
            ImageViewerRemote(imageURL: $previewImageurl , viewerShown: $ispreviewImage, disableCache: true, closeButtonTopRight: true)
        })
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: $presentLogin,
               onDismiss:{
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                if Helper.userExist(){
                    GotoSummary = true
                }
            })
        }
        ){
            ViewLogin( ispresented: .constant(false))
        }
        .sheet(isPresented: $presentReservation,
               onDismiss:{
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                if Helper.userExist(){
                    GotoSummary = true
                }
            })
        }
        ){
            ViewSignUp(ispresented: .constant(false))
        }
        .background(
            newBackImage(backgroundcolor: .white, imageName:.image2)
        )
    }
}

struct ViewDocDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ViewBooking(Doctor: Doc.init(), ExType: .constant(2), BookingClinicId: 0)
                .environmentObject(EnvironmentsVM())
                .environmentObject(ViewModelDocDetails())
        }.navigationBarHidden(true)
    }
}

func setWeekView(){
    //        totalSquares.removeAll()
    
    var current = CalendarHelper().sundayForDate(date: selectedDate)
    let nextSunday = CalendarHelper().addDays(date: current, days: 7)
    
    while (current < nextSunday)
    {
        totalSquares.append(current)
        current = CalendarHelper().addDays(date: current, days: 1)
    }
}














