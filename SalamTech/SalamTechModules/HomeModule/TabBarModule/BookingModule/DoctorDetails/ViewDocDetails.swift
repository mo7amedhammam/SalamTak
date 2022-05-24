//
//  ViewDocDetails.swift
//  SalamTech
//
//  Created by wecancity on 11/04/2022.
//

import SwiftUI
import Combine
import ImageViewerRemote

var selectedDate = Date()
var totalSquares = [Date]()

struct ViewDocDetails:View{
    var Doctor:Doc
   @State var showQuickLogin = false
//    @StateObject var DocDetails = ViewModelDocDetails()
    @State var GotoSummary = false
    @State var GotoReviews = false
    @State var GotoAddReview = false
    var language = LocalizationService.shared.language

    @Binding var ExType :Int
    
    //Calendar
    @State var ShowCalendar = false
    @State var selectedDate = Date()
    
    
    @State var selectedSchedualId = 0
    @State var selectedTime = ""

    @State var LoginOrReservation = 0
    @State var presentLogin = false
    @State var presentReservation = false
    
    @State var ispreviewImage=false
    @State var previewImageurl=""
    
    var body: some View{
            ZStack {
                    VStack{
                        Image("Rectangle")
                            .resizable()
                            .frame(width:UIScreen.main.bounds.width, height: 200)

                        ScrollView {
                            ViewDocMainInfo(Doctor: Doctor, ispreviewImage: $ispreviewImage, previewImageurl: $previewImageurl)
                            ViewDateAndTime(ShowCalendar: $ShowCalendar, selectedDate: $selectedDate, selectedSchedualId: $selectedSchedualId , selectedTime:$selectedTime,DoctorId:.constant(Doctor.id ?? 0), ClinicId: .constant(Doctor.ClinicId ?? 0), ExTypeId:$ExType)
                            ViewDocReviews( Doctor: Doctor, GotoReviews: $GotoReviews, GotoAddReview: $GotoAddReview)

                            Spacer()
                        }
                        .frame(width: UIScreen.main.bounds.width-20)
                        .background(.clear)
                        .padding(.top,-105)

                        Spacer()

                        ZStack{
                        Button(action: {
                            // add review
                            if Helper.userExist(){
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
                            .foregroundColor(.white)
                            .background(selectedTime == "" ?  Color("blueColor").opacity(0.2): Color("blueColor"))
                            .cornerRadius(12)
                            .padding(.horizontal, 20)
                        })
                                .disabled(selectedTime == "")
                            
                        }
                        .background(.clear
                        
                        )
                            .shadow(color: .gray, radius: 9)
                      
                        
                    }
                    .blur(radius: ShowCalendar||showQuickLogin ? 9:0)
                    .disabled(ShowCalendar)
                    .background(Color("CLVBG"))
                            if showQuickLogin == true{
                                quickLoginSheet(IsPresented: $showQuickLogin, QuickLogin: $presentLogin,QuickReservation: $presentReservation  , width: UIScreen.main.bounds.width)
                            }

                            if ShowCalendar == true{
                            ZStack{
                                calendarPopUp(selectedDate: $selectedDate, isPresented: $ShowCalendar)
                            }
                            }
                          
                         
                        }
                .edgesIgnoringSafeArea(.top)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        if !showQuickLogin && !ispreviewImage{
                            BackButtonView()
                        }
                    }
                }
                .navigationBarHidden(showQuickLogin||ShowCalendar||ispreviewImage)
                .navigationBarBackButtonHidden(true)
                .onAppear(perform: {
                    setWeekView()
            })
                .overlay(content: {
                    ImageViewerRemote(imageURL: $previewImageurl , viewerShown: $ispreviewImage, disableCache: true, closeButtonTopRight: true)
                })
          
        
        
       
        
        
     // go to summary
        NavigationLink(destination:ViewSummary(Doctor: Doctor, ExType: $ExType, BookingscedualId: $selectedSchedualId, BookiDate: $selectedDate, BookiTime: $selectedTime),isActive: $GotoSummary) {
             }

        // go to Reviews
        NavigationLink(destination:ReviewsView( DoctorId: Doctor.id ?? 0),isActive: $GotoReviews) {
                }
        
        // go to addReview
        NavigationLink(destination:ViewAddReview( Doctor: Doctor, schedule: AppointmentInfo.init()),isActive: $GotoAddReview) {
                }

        .sheet(isPresented: $presentLogin,
                         onDismiss:{
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                if Helper.userExist(){
                GotoSummary = true
                }
            })
        }
        ){
            ViewLogin( ispresented: .constant(false), QuickLogin: $presentLogin)
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
            ViewSignUp(ispresented: .constant(false), quickSignup: $presentReservation)
        }
        
        
    }
   
}

struct ViewDocDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ViewDocDetails(Doctor: Doc.init(), ExType: .constant(2))
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


struct ViewDocMainInfo: View {
    var Doctor:Doc
    @Binding var ispreviewImage:Bool
    @Binding var previewImageurl:String
    var language = LocalizationService.shared.language

    var body: some View {
        VStack {
            ZStack{
                ZStack {
                    
                } //Z
                .frame(width:UIScreen.main.bounds.width-30, height: 140)
                .background(.white)
                
                .cornerRadius(9)
                .offset( y: 20)
                
                VStack( spacing:0){
                    
                    VStack( ) {
                        Spacer().frame(height:0)
                        HStack(alignment:.bottom){
                            
                            AsyncImage(url: URL(string:   URLs.BaseUrl + "\(Doctor.Image ?? "")" )) { image in

                                image.resizable()

                            } placeholder: {
                                Image("logo")
                                    .resizable()
                            }
                                .scaledToFill()
                                .frame(width:60)
                                .background(Color.gray)
                                .cornerRadius(9)
                                .onTapGesture(perform: {
                                    ispreviewImage = true
                                    previewImageurl = URLs.BaseUrl + "\(Doctor.Image ?? "")"
                                })
                            
                            Text("Dr/ ".localized(language))
                                .foregroundColor(.black.opacity(0.7))
                                .font(Font.SalamtechFonts.Bold18)
                            
                            Text(Doctor.DoctorName ?? "")
                                .font(Font.SalamtechFonts.Bold18)
                            
                            Spacer()
                        }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                    }
                    .padding()
                    
                    VStack(alignment:.leading, spacing:0){
                        
                        
                        HStack{
                            Text(Doctor.SeniortyLevelName ?? "")
                                .foregroundColor(.gray.opacity(0.7))
                                .font(Font.SalamtechFonts.Reg14)
                        }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                        
                        HStack{
                            StarsView(rating: Float( Doctor.Rate ?? 0))

                            
                            
                            Text("( \(Doctor.NumVisites ?? 0) "+"Patientsـ)".localized(language))
                                .foregroundColor(.black.opacity(0.7))
                                .font(Font.SalamtechFonts.Reg14)
                        }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

                        HStack{
                            Image("doc1")
                            Text(Doctor.SpecialistName ?? "" )
                                .foregroundColor(Color("darkGreen"))
                                .font(Font.SalamtechFonts.Reg14)
                            Text(" Specialized_in ".localized(language))
                                .foregroundColor(.secondary)
                                .font(Font.SalamtechFonts.Reg14)
                            Text(Doctor.SubSpecialistName?.joined(separator: ", ") ?? "" )
                                .foregroundColor(Color("darkGreen"))
                                .font(Font.SalamtechFonts.Reg14)
                            
                            
                            Spacer()
                        }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

                        
                        Spacer()
                        
                    }.padding(.leading)
                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                    
                }//V
                .frame(height: 160)
                .background(Color.clear)
                
            }//Z
            .frame(width: UIScreen.main.bounds.width-20, height: 180)
            .background(.clear)
            .cornerRadius(9)
        .shadow(color: .black.opacity(0.1), radius: 9)
            
            
            
            
            
            ZStack {
                HStack(){
                    Image("FilterFees")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(.leading)
                    VStack{
                        Text("Fees:".localized(language))
                        .foregroundColor(Color("darkGreen"))
                        .font(Font.SalamtechFonts.Reg14)
                        Text( String( Doctor.FeesFrom ?? 0.0))
                        .foregroundColor(.secondary)
                        .font(Font.SalamtechFonts.Reg14)
                    
                    }.padding(.trailing)
                    Spacer()
Divider()
                    
                    Image("doc4")
                        .resizable()
                        .frame(width: 20, height: 20)
                    VStack{
                        Text("Waiting_Time:".localized(language))
                        .foregroundColor(Color("darkGreen"))
                        .font(Font.SalamtechFonts.Reg14)
                        Text("\(Doctor.WaitingTime ?? 0) " + "Minutes".localized(language))
                        .foregroundColor(.secondary)
                        .font(Font.SalamtechFonts.Reg14)
                    
                    }.padding(.trailing)
                }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

                .background(Color.white)
            }
            .frame(width: UIScreen.main.bounds.width-30, height:55)
                .cornerRadius(9)
            .shadow(color: .black.opacity(0.1), radius: 9)
        
        ZStack{
            HStack{
                Image("doc2")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(.leading)
                VStack{
                    Text("\(Doctor.ClinicName ?? ""): ")
                        .foregroundColor(Color("darkGreen"))
                        .font(Font.SalamtechFonts.Reg14)
                    Text("\(Doctor.ClinicAddress ?? "")")
                        .foregroundColor(.secondary)
                        .font(Font.SalamtechFonts.Reg14)
                    //                Spacer()
                }.padding(.leading)
                    .padding()
                Spacer()
                
            }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
            .background(Color.white)
        }
        .frame(width: UIScreen.main.bounds.width-30, height:55)
        .cornerRadius(9)
        .shadow(color: .black.opacity(0.1), radius: 9)
        }
    }
}

struct ViewDateAndTime: View {
    var language = LocalizationService.shared.language

    @State var TappedDate = Date()
    @State var timeexpanded = false
    @StateObject var DocDetails = ViewModelDocDetails()

    var weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
//    :["اثنين", "ثلاث", "اربع", "Fri", "خميس"]
    var vGridLayout = [ GridItem(.adaptive(minimum: 90), spacing: 30) ]
    
    @State var seldatenum = ""
    @State var openSlots = false
    @Binding var ShowCalendar : Bool
    @Binding var selectedDate : Date
    @Binding var selectedSchedualId :Int
    @Binding var selectedTime :String

    @Binding var DoctorId :Int
    @Binding var ClinicId :Int
    @Binding var ExTypeId :Int
    

    init(ShowCalendar: Binding<Bool>, selectedDate: Binding<Date>,selectedSchedualId: Binding<Int>,selectedTime: Binding<String>,DoctorId: Binding<Int>,ClinicId: Binding<Int>,ExTypeId: Binding<Int>){
        self._ShowCalendar = ShowCalendar
        self._selectedDate = selectedDate
        self._selectedSchedualId = selectedSchedualId
        self._selectedTime = selectedTime
        self._DoctorId = DoctorId
        self._ClinicId = ClinicId
        self._ExTypeId = ExTypeId

        setWeekView()
    }
    var body: some View {
        VStack{
            Text("Choose_date_&_time".localized(language))
                .frame(width: UIScreen.main.bounds.width-20, height: 35, alignment:.bottomLeading)
                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//            ZStack {
//                FSCalendarView(SelectedDate: $TappedDate)
//                    .frame( minHeight: 150)
//            }

            //MARK: ---- Days of Week --------
            ZStack{
                VStack{

//MARK: Selected date & show calednar
                    Button(action: {
                        // open Calendar
                        ShowCalendar = true
                    }, label: {
                        HStack{
                            Image("Appointments")
                                .resizable()
                                .frame(width: 20, height: 20)

                                .padding(.bottom,3)
                                .padding(.leading)
                            Text("\(seldatenum) \(CalendarHelper().monthString(date: selectedDate))  \(CalendarHelper().yearString(date: selectedDate) )")
                                .foregroundColor(Color("darkGreen"))
                                .font(Font.SalamtechFonts.Reg18)

                            Image( systemName: "chevron.forward")
                                .foregroundColor(Color("darkGreen"))
                                .padding(.bottom,3)

                            Spacer()

                        }
//                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                        .frame(height:15)
                    })
                        .padding()

                    Divider().padding(.top,-10)

//MARK: --- Current Week ------
                    HStack(spacing:0){
                        ForEach(0..<weekdays.count, id:\.self){ day in
                            let date = totalSquares[day]

                            Button(action: {
                                // select date
                                TappedDate = date
                                openSlots = true
                                seldatenum =                             String(CalendarHelper().dayOfMonth(date: date))
                            }, label: {
                                    
                                VStack{

                                    Text(String(CalendarHelper().dayOfMonth(date: date)))
                                    Text(weekdays[day])
                                    if TappedDate == date{
                                        Text(".")
                                            .font(.system(size: 40) )
                                            .padding(.top, -40)
                                    }
                                }                                            .frame(width:(UIScreen.main.bounds.width-40)/7)




                            }).foregroundColor(Color("blueColor"))
                                .background( TappedDate == date ? Color("darkGreen").opacity(0.19):.clear)
                                .cornerRadius(8)
                                .padding(.bottom, 10)
                          

                        }
                    }
//                    .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

                    .frame(height: 60)
                }
                .background(Color.white)

            }
            .frame(width: UIScreen.main.bounds.width-30)
            .cornerRadius(9)
            .shadow(color: .black.opacity(0.1), radius: 9)
            
            

            
         //---------------------------------
            
            //MARK: ---- periods of slot --------
            if openSlots && (DocDetails.publishedModelSearchDoc?.DoctorScheduals?.count ?? 0) > 0 {
                VStack{
                    ForEach(DocDetails.publishedModelSearchDoc?.DoctorScheduals ?? [], id:\.id ){ sched in
                        
                Button(action: {
                    selectedSchedualId = sched.id ?? 0
                    timeexpanded.toggle()
                }, label: {

                    HStack{
                        
                        HStack{
                            Text(ConvertStringDate(inp: sched.TimeFrom ?? "", FormatFrom: "HH:mm:ss", FormatTo: "hh:mm a") )
                                .foregroundColor(Color("darkGreen"))
                                .font(Font.SalamtechFonts.Reg16)
                            
                            Text("to".localized(language))
                                .foregroundColor(.gray)
                                .font(Font.SalamtechFonts.Reg16)
                            
                            Text(ConvertStringDate(inp: sched.TimeTo ?? "", FormatFrom: "HH:mm:ss", FormatTo: "hh:mm a") )
                                .foregroundColor(Color("darkGreen"))
                                .font(Font.SalamtechFonts.Reg16)
                            
                        }
                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

                        .background(Image("Rectangle2")
                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                                    )
                        Spacer()
                        
                        Text("Fees:".localized(language))
                            .foregroundColor(.gray)
                            .font(Font.SalamtechFonts.Reg16)
                        
                        Text("\(sched.Fees ?? 0)" + "EGP".localized(language))
                            .foregroundColor(Color("darkGreen"))
                            .font(Font.SalamtechFonts.Reg16)
                        
                        Image( systemName: timeexpanded ?  "chevron.up":"chevron.down")
                            .foregroundColor(Color("blueColor"))
                            .padding(.bottom,3)
                        
                        
                    }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

                    .frame(height:50)
                    .padding(.horizontal)
       
                    .background(Color.white)

                })
                            .frame(width: UIScreen.main.bounds.width-30)
                            .cornerRadius(9)
                            .shadow(color: .black.opacity(0.1), radius: 9)
                
                if timeexpanded == true{
                        slotView(slots: sched.DoctorSchedualSlots ?? [], selectedTime: $selectedTime )
                }
                        
                    }
                }
            }
            
            ViewAboutDoctor(Docinfo: DocDetails.publishedModelSearchDoc?.DoctorInfo ?? "")
            
            //-----------------------------------------
            
            
        }

            .onAppear(perform: {
                DocDetails.DoctorId = DoctorId
                DocDetails.ClinicId = ClinicId
                DocDetails.MedicalExaminationTypeId = ExTypeId
                
                DocDetails.FetchDoctorDetails()
            })
            .onChange(of:self.TappedDate ){newdate in
                DocDetails.publishedModelSearchDoc?.DoctorScheduals?.removeAll()
                DocDetails.SchedualDate = newdate
                DocDetails.FetchDoctorDetails()
            }
            .onChange(of: self.selectedDate){newdate in
                self.TappedDate = newdate
                seldatenum = String(CalendarHelper().dayOfMonth(date: newdate))
            }
            .onChange(of: self.selectedTime){ newTime in
                self.selectedTime = newTime
                print("\(Filterdatef.string(from: TappedDate))T\(newTime)")
            }
        
        
        // Alert with no internet connection
            .alert(isPresented: $DocDetails.isNetworkError, content: {
                Alert(title: Text("Check_Your_Internet_Connection".localized(language)), message: nil, dismissButton: .cancel())
        })

    }
}

struct ViewAboutDoctor: View {
    var language = LocalizationService.shared.language

    var Docinfo : String
    var body: some View {
        VStack{
            
            Text("About_doctor".localized(language))
                .frame(width: UIScreen.main.bounds.width-20, height: 35, alignment:.bottomLeading)
                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
            
            ZStack{
                
                Text(Docinfo)
                    .frame(width: UIScreen.main.bounds.width-30)
                    .foregroundColor(.gray)
                    .font(Font.SalamtechFonts.Reg14)
                    .padding()
                    .background(Color.white)

                
            }
            .frame(width: UIScreen.main.bounds.width-30)
            .cornerRadius(9)
            .shadow(color: .black.opacity(0.1), radius: 9)
        }
    }
}

struct ViewDocReviews: View {
//    @StateObject var DocDetails : ViewModelDocDetails
    var language = LocalizationService.shared.language

    @State var hei: CGFloat = 180
    var Doctor:Doc
    @Binding var GotoReviews : Bool
    @Binding var GotoAddReview : Bool

    var body: some View {
        VStack{
            HStack{
                Text("Reviews".localized(language))
                Spacer()
                Button(action: {
                    GotoReviews = true
                }, label: {
                  
                    HStack{
                        Text("View_all_reviews".localized(language))
                            .foregroundColor(Color("darkGreen"))
                        Image( systemName: "chevron.forward")
                            .foregroundColor(Color("darkGreen"))
                            .padding(.trailing)

                    }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                })
                
                
            }
            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

            .frame(width: UIScreen.main.bounds.width-20, height: 35, alignment:.bottomLeading)
            
            ScrollView(.horizontal){
                HStack{
                    ForEach(Doctor.DoctorRate ?? [],id:\.self){Rate in
                        ZStack{
                            ZStack {
                                
                            } //Z
                            .frame(width:(UIScreen.main.bounds.width/1)-80)
                            .frame( minHeight: hei)
                            .background(.white)
                            
                            .cornerRadius(9)
                            .offset( y: 30)
                            
                            VStack( spacing:0){
                                
                                VStack( ) {
                                    Spacer().frame(height:0)
                                    HStack(){
                                        
                                        Image("logo")
                                            .resizable()
                                            .frame(width: 60, height: 60)
                                            .background(Color.gray)
                                            .cornerRadius(9)
                                    
                                        VStack(spacing:0){
                                            Text(Rate.PatientName ?? "")
                                                .padding(.bottom,8)
//                                            .font(Font.SalamtechFonts.Bold18)
                                            .font(.system(size: 20))
                                        
                                            StarsView(rating: Float(Rate.Rate ?? 00) )

                                        }
                                        .padding(.top, 10)

                                        Spacer()
                                    }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                                }
                                .padding()
                                
                                VStack(alignment:.leading, spacing:0){
                                    
                                    Text(Rate.Comment ?? "" )

                                    .foregroundColor(.gray)
                                        .font(Font.SalamtechFonts.Reg14)
                                    
//                                    HStack{
//                                        Spacer()
//                                        Text("26.02.2019" )
//                                            .foregroundColor(.gray.opacity(0.3))
//                                            .font(Font.SalamtechFonts.Reg14)
//                                    }.padding(.trailing)
//                                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

                                    
                                    
                                }.padding(.leading)
                                    .frame(height: 100)
                                
                            }//V
                            .background(Color.clear)
                            
                        }//Z
                        .frame(width: (UIScreen.main.bounds.width/1)-80)
                        .background(.clear)
                        .cornerRadius(9)
                        .shadow(color: .black.opacity(0.1), radius: 9)
                        
                    }
                }
                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                .padding([.bottom,.leading],8)
            }
            
//            Button(action: {
//                // add review
//                GotoAddReview = true
//            }, label: {
//                HStack {
//                    Image("pen")
//                        .font(.title)
//                    Text("Write_a_Review".localized(language))
//                        .fontWeight(.semibold)
//                        .font(.title3)
//                }
//                .frame(minWidth: 0, maxWidth: .infinity)
//                .padding()
//                .foregroundColor(Color("darkGreen"))
//                .background(.gray.opacity(0.09))
//                .cornerRadius(12)
//                .padding(.horizontal, 20)
//            })
            
        }
    }
}



struct quickLoginSheet : View {
    
    var language = LocalizationService.shared.language
    @Binding var IsPresented: Bool
    @Binding var QuickLogin : Bool
    @Binding var QuickReservation : Bool

    var width: CGFloat
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                 VStack {
                        Capsule()
                            .frame(width: 50, height: 4)
                            .foregroundColor(.gray)
                            .padding(.top ,10)
                            .padding(.bottom,20)
                    
                    VStack {
                        ButtonView(text:"Sign_in".localized(language), action: {
                                withAnimation(.easeIn(duration: 0.3)) {
                                    IsPresented =  false
                                    QuickLogin = true
                                }
                            })
                        
                        ButtonView(text: "Quick_Reservation".localized(language), backgroundColor: .white){
                            // action
                            IsPresented =  false
                            QuickReservation = true
                        }
                            .border(Color("mainColor"), width: 2)
                            .cornerRadius(4)
                            .padding(.bottom,10)

                    }

                }.background(
                    RoundedRectangle(cornerRadius: 40.0)
                        .foregroundColor(.white)
                        .ignoresSafeArea()
                        .opacity(1.5)
                        .shadow(radius: 15)
                        .frame(width: UIScreen.main.bounds.width)

)

            }

        }
        .frame(width: UIScreen.main.bounds.width)
        .background(
            Color.black.opacity(0.3)
                .blur(radius: 12)
        )
        .onTapGesture(perform: {
            IsPresented =  false

        })
        
    }
}

struct slotView:View{
    var slots : [Sched]
    var vGridLayout = [ GridItem(.adaptive(minimum: 90), spacing: 20) ]
    @Binding var selectedTime :String
    var body:some View{
        LazyVGrid(columns: vGridLayout){
            ForEach(slots, id:\.id ) { exType in
                            ZStack {
                                Button(action: {
                                    selectedTime = exType.SlotTime ?? ""

                                }, label: {
                                    Text(ConvertStringDate(inp: exType.SlotTime ?? "", FormatFrom: "HH:mm:ss", FormatTo: "hh:mm a") )

                                .padding(.vertical,10)
                                .foregroundColor(selectedTime == (exType.SlotTime ) ? .white : .gray)
                                })
                                    .frame(width: (UIScreen.main.bounds.width/3)-20, height: 35)
                                    .background(!(exType.IsAvailable ?? true) ? Color("darkGreen").opacity(0.3):selectedTime == (exType.SlotTime) ? Color("darkGreen").opacity(0.7):.white)
                                    .cornerRadius(8)
                                    .shadow(color: .black.opacity(0.099), radius: 5)
                                    .disabled(!(exType.IsAvailable ?? true))
                            }
            }

        }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
        .padding(.horizontal,13)

    }
}
