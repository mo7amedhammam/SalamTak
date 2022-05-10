//
//  ViewDocDetails.swift
//  SalamTech
//
//  Created by wecancity on 11/04/2022.
//

import SwiftUI
import Combine

var selectedDate = Date()
var totalSquares = [Date]()

struct ViewDocDetails:View{
    var Doctor:Doc
   @State var showQuickLogin = false
//    @StateObject var DocDetails = ViewModelDocDetails()
    @State var GotoSummary = false
    @Binding var ExType :Int
    
    //Calendar
    @State var ShowCalendar = false
    @State var selectedDate = Date()
    
    
    @State var selectedSchedualId = 0
    @State var selectedTime = ""

    
    
    var body: some View{
                    ZStack {
                VStack{
                    Image("Rectangle")
                        .resizable()
                        .frame(width:UIScreen.main.bounds.width, height: 200)

                    ScrollView {
                        ViewDocMainInfo(Doctor: Doctor)
                        ViewDateAndTime(ShowCalendar: $ShowCalendar, selectedDate: $selectedDate, selectedSchedualId: $selectedSchedualId , selectedTime:$selectedTime)
                        ViewDocReviews( Doctor: Doctor)

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
                            Text("Book")
                                .fontWeight(.semibold)
                                .font(.title3)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(selectedTime == "" ?  Color("blueColor").opacity(0.2): Color("blueColor"))
        //                .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                    }).disabled(selectedTime == "")
                        
                        
                        
                    }.background(.clear
                    )
                        .shadow(color: .gray, radius: 9)
                    
                }
                .blur(radius: ShowCalendar||showQuickLogin ? 9:0)
                .disabled(ShowCalendar)
                .background(Color("CLVBG"))
                        if showQuickLogin{
                        quickLoginSheet(IsPresented: $showQuickLogin, width: UIScreen.main.bounds.width)
                        }

                        if ShowCalendar {
                        ZStack{
                            calendarPopUp(selectedDate: $selectedDate, isPresented: $ShowCalendar)
                        }
                        }

                    }
            .edgesIgnoringSafeArea(.top)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if !showQuickLogin{
                        BackButtonView()
                    }
                }
            }
            .navigationBarHidden(showQuickLogin||ShowCalendar)
            .navigationBarBackButtonHidden(true)
            .onAppear(perform: {
                setWeekView()
//                let now = convertDateToLocalTime(Date())
//                let startWeek = convertDateToLocalTime(now.startOfWeek!)
//                let endWeek = convertDateToLocalTime(now.endOfWeek!)
//                print("Local time is: \(now)")
//                print("Start of week is: \(startWeek)")
//                print("End of week is: \(endWeek)")
//
//                print("Month : \(CalendarHelper().monthString(date: selectedDate))  \(CalendarHelper().yearString(date: selectedDate) )")
//                print(" week :")
//                for dayyy  in totalSquares{
//                    print(dayyy)
//                }

            })
        
        
        
     // go to clinic info
        NavigationLink(destination:ViewSummary(Doctor: Doctor, ExType: $ExType, BookingscedualId: $selectedSchedualId, BookiDate: $selectedDate, BookiTime: $selectedTime),isActive: $GotoSummary) {
             }
        
//     .navigationBarHidden(true)
//     .navigationBarBackButtonHidden(true)


        
        
    }
    
    


    
}

struct ViewDocDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ViewDocDetails(Doctor: Doc.init(), ExType: .constant(15545454))
        }.navigationBarHidden(true)
    }
}

func setWeekView()
{
//        totalSquares.removeAll()
    
    var current = CalendarHelper().sundayForDate(date: selectedDate)
    let nextSunday = CalendarHelper().addDays(date: current, days: 7)
    
    while (current < nextSunday)
    {
        totalSquares.append(current)
        current = CalendarHelper().addDays(date: current, days: 1)
    }
    
//        monthLabel.text = CalendarHelper().monthString(date: selectedDate)
//            + " " + CalendarHelper().yearString(date: selectedDate)
//        collectionView.reloadData()
//        tableView.reloadData()
}


struct ViewDocMainInfo: View {
    var Doctor:Doc

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
                //            .clipShape(Circle())
                                .scaledToFill()
                                .frame(width:60)
                                .background(Color.gray)
                                .cornerRadius(9)

                            
                            //
                            //                                    }
                            //                                    .frame( height: 80)
                            //                                    .padding()
                            //                                    .padding(.top,-20)
                            
                            Text("Dr/")
                                .foregroundColor(.black.opacity(0.7))
                                .font(Font.SalamtechFonts.Bold18)
                            
                            Text(Doctor.DoctorName ?? "")
                                .font(Font.SalamtechFonts.Bold18)
                            
                            Spacer()
                        }
                    }
                    .padding()
                    //                                    .padding(.top,-10)
                    
                    VStack(alignment:.leading, spacing:0){
                        
                        
                        HStack{
                            Text(Doctor.SeniortyLevelName ?? "")
                                .foregroundColor(.gray.opacity(0.7))
                                .font(Font.SalamtechFonts.Reg14)
                        }
                        HStack{
//                            ForEach(0..<5){_ in
//                                Image(systemName: "star.fill") // Imagenames: star || star.fill || star.leadinghalf.filled
//                                    .foregroundColor(.yellow)
//                            }
                            StarsView(rating: Float( Doctor.Rate ?? 0))

                            
                            
                            Text("( \(Doctor.NumVisites ?? 0)"+" Patients )")
                                .foregroundColor(.black.opacity(0.7))
                                .font(Font.SalamtechFonts.Reg14)
                        }
                        
                        HStack{
                            Image("doc1")
                            Text(Doctor.SpecialistName ?? "" )
                                .foregroundColor(Color("darkGreen"))
                                .font(Font.SalamtechFonts.Reg14)
                            Text(" Specialized in ")
                                .foregroundColor(.secondary)
                                .font(Font.SalamtechFonts.Reg14)
                            Text(Doctor.SubSpecialistName?.joined(separator: ", ") ?? "" )
                                .foregroundColor(Color("darkGreen"))
                                .font(Font.SalamtechFonts.Reg14)
                            
                            
                            Spacer()
                        }
                        
                        Spacer()
                        
                    }.padding(.leading)
                    
                }//V
                
                
                .frame(height: 160)
                .background(Color.clear)
                //                            .frame( height: 140)
                //                            .cornerRadius(9)
                
            }//Z
            .frame(width: UIScreen.main.bounds.width-20, height: 180)
            //                        .offset(y:40)
            .background(.clear)
            .cornerRadius(9)
        .shadow(color: .black.opacity(0.1), radius: 9)
            
            
            
            
            
            ZStack {
                HStack(){
                    Image("doc3")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(.leading)
                    VStack{
                    Text("Fees:")
                        .foregroundColor(Color("darkGreen"))
                        .font(Font.SalamtechFonts.Reg14)
                        Text( String( Doctor.FeesFrom ?? 0.0))
                        .foregroundColor(.secondary)
                        .font(Font.SalamtechFonts.Reg14)
                    
//                            Spacer()
                    }.padding(.trailing)
                    Spacer()
Divider()
                    
//                        HStack{
                    Image("doc4")
                        .resizable()
                        .frame(width: 20, height: 20)
//                                        .padding(.leading)
                    VStack{
                    Text("Waiting Time:")
                        .foregroundColor(Color("darkGreen"))
                        .font(Font.SalamtechFonts.Reg14)
                        Text("\(Doctor.WaitingTime ?? 0)" + " Minutes")
                        .foregroundColor(.secondary)
                        .font(Font.SalamtechFonts.Reg14)
                    
                    }.padding(.trailing)
                }
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
                
            }
            .background(Color.white)
        }
        .frame(width: UIScreen.main.bounds.width-30, height:55)
        .cornerRadius(9)
        .shadow(color: .black.opacity(0.1), radius: 9)
        }
    }
}

struct ViewDateAndTime: View {
    @State var TappedDate = Date()
    @State var timeexpanded = false
    @StateObject var DocDetails = ViewModelDocDetails()

    var weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    var vGridLayout = [ GridItem(.adaptive(minimum: 90), spacing: 30) ]
    var daytimes = ["2:30 PM", "2:50 PM", "3:30 PM", "3:50 PM","4:30 PM", "4:50 PM","5:30 PM", "5:50 PM"]
//    @State var selectedTime = ""
    @State var seldatenum = ""
    @State var openSlots = false
    @Binding var ShowCalendar : Bool
    @Binding var selectedDate : Date
    @Binding var selectedSchedualId :Int
    @Binding var selectedTime :String

    
   
    
    init(ShowCalendar: Binding<Bool>, selectedDate: Binding<Date>,selectedSchedualId: Binding<Int>,selectedTime: Binding<String>){
        self._ShowCalendar = ShowCalendar
        self._selectedDate = selectedDate
        self._selectedSchedualId = selectedSchedualId
        self._selectedTime = selectedTime

        setWeekView()
//        TappedDate = Date()
    }
    var body: some View {
        VStack{
                

            
            Text("Choose date & time").frame(width: UIScreen.main.bounds.width-20, height: 35, alignment:.bottomLeading)
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
                            //                                VStack{
                            Text("\(seldatenum) \(CalendarHelper().monthString(date: selectedDate))  \(CalendarHelper().yearString(date: selectedDate) )")
                                .foregroundColor(Color("darkGreen"))
                                .font(Font.SalamtechFonts.Reg18)

                            Image( systemName: "chevron.forward")
                            //                                        .resizable()
                                .foregroundColor(Color("darkGreen"))
                            //                                        .frame(width: 20, height: 20)
                                .padding(.bottom,3)

                            Spacer()

                        }.frame(height:15)
                    })
                        .padding()

                    Divider().padding(.top,-10)

//MARK: --- Current Week ------
                    HStack(spacing:0){
                        ForEach(0..<weekdays.count, id:\.self){ day in
                            let date = totalSquares[day]

                            Button(action: {
                                // select date
//                                print(totalSquares[day])
//                                TappedDate = totalSquares[day]
//                                timeexpanded = false
                                TappedDate = date
                                openSlots = true
//                                DocDetails.FetchDoctorDetails()
                                seldatenum =                             String(CalendarHelper().dayOfMonth(date: date))
                            }, label: {
                                    
                                VStack{

                                    Text(                            String(CalendarHelper().dayOfMonth(date: date))
)
                                    Text(weekdays[day])
                                    //                                                    .padding(.vertical, 0)
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
                    //                            ZStack{
                    //                            VStack{
                    
                    HStack{
                        
                        HStack{
                            Text(sched.TimeFrom ?? "" )
                                .foregroundColor(Color("darkGreen"))
                                .font(Font.SalamtechFonts.Reg16)
                            
                            Text("To")
                                .foregroundColor(.gray)
                                .font(Font.SalamtechFonts.Reg16)
                            
                            Text(sched.TimeTo ?? "")
                                .foregroundColor(Color("darkGreen"))
                                .font(Font.SalamtechFonts.Reg16)
                            
                        }.background(Image("Rectangle2"))
                        Spacer()
                        
                        Text("Fee:")
                            .foregroundColor(.gray)
                            .font(Font.SalamtechFonts.Reg16)
                        
                        Text("\(sched.Fees ?? 0) EGP")
                            .foregroundColor(Color("darkGreen"))
                            .font(Font.SalamtechFonts.Reg16)
                        
                        Image( systemName: timeexpanded ?  "chevron.up":"chevron.down")
                            .foregroundColor(Color("blueColor"))
                            .padding(.bottom,3)
                        
                        
                    }
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
//                        print(Date())
//                        print(TappedDate)
//                        DocDetails.SchedualDate = newdate
                DocDetails.FetchDoctorDetails()
            })
            .onChange(of:self.TappedDate ){newdate in
                DocDetails.publishedModelSearchDoc?.DoctorScheduals?.removeAll()
                DocDetails.SchedualDate = newdate
                DocDetails.FetchDoctorDetails()
            }
            .onChange(of: self.selectedDate){newdate in
                self.TappedDate = newdate
                seldatenum =                             String(CalendarHelper().dayOfMonth(date: newdate))
            }
            .onChange(of: self.selectedTime){ newTime in
                self.selectedTime = newTime
                print("\(Filterdatef.string(from: TappedDate))T\(newTime)")
//                self.selectedTime = "\(Filterdatef.string(from: TappedDate))T\(newTime)"
            }
    }
}

struct ViewAboutDoctor: View {
    var Docinfo : String
    var body: some View {
        VStack{
            
            Text("About doctor").frame(width: UIScreen.main.bounds.width-20, height: 35, alignment:.bottomLeading)
            
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
    @State var hei: CGFloat = 180
    var Doctor:Doc
    var body: some View {
        VStack{
            HStack{
                Text("Reviews")
                Spacer()
                Text("View all \(Doctor.DoctorRate?.count ?? 0) reviews")
                    .foregroundColor(Color("darkGreen"))
                Image( systemName: "chevron.forward")
                //                                        .resizable()
                    .foregroundColor(Color("darkGreen"))
                //                                        .frame(width: 20, height: 20)
                    .padding(.trailing)
                
                
            }.frame(width: UIScreen.main.bounds.width-20, height: 35, alignment:.bottomLeading)
            
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
                                            Text(Rate.PatientName ?? "").padding(.bottom,8)
//                                            .font(Font.SalamtechFonts.Bold18)
                                            .font(.system(size: 20))
                                        
                                            StarsView(rating: Float(Rate.Rate ?? 00) )
                                            
//                                            HStack(spacing:15){
//                                                      ForEach(0..<5){_ in
//                                                          Image(systemName: "star.fill") // Imagenames: star || star.fill || star.leadinghalf.filled
//                                                              .frame(width: 10, height: 10)
//                                                              .foregroundColor(.yellow)
//                                                      }
//
//
//
//                                            }.padding(.trailing)

                                        }
                                        .padding(.top, 10)

                                        Spacer()
                                    }
                                }
                                .padding()
                                //                                    .padding(.top,-10)
                                
                                VStack(alignment:.leading, spacing:0){
                                    
//                                    Text("Thank you very much! Great clinic! The dog was limping, X-rayed, prescribed quality treatment. Dog of fights! Excellent specialists! more" )
                                    Text(Rate.Comment ?? "" )

                                    .foregroundColor(.gray)
                                        .font(Font.SalamtechFonts.Reg14)
//
                                    HStack{
                                        Spacer()
                                        Text("26.02.2019" )
                                            .foregroundColor(.gray.opacity(0.3))
                                            .font(Font.SalamtechFonts.Reg14)
                                    }.padding(.trailing)
                                    
//                                    Spacer()
                                    
                                }.padding(.leading)
                                    .frame(height: 100)
                                
                            }//V
                            
                            
//
                            .background(Color.clear)
                            //                            .frame( height: 140)
                            //                            .cornerRadius(9)
                            
                        }//Z
                        .frame(width: (UIScreen.main.bounds.width/1)-80)
                        //                        .offset(y:40)
                        .background(.clear)
                        .cornerRadius(9)
                        .shadow(color: .black.opacity(0.1), radius: 9)
                        
                    }
                }.padding([.bottom,.leading],8)
            }
            
            Button(action: {
                // add review
            }, label: {
                HStack {
                    Image("pen")
                        .font(.title)
                    Text("Write a Review")
                        .fontWeight(.semibold)
                        .font(.title3)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(Color("darkGreen"))
                .background(.gray.opacity(0.09))
//                .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(12)
                .padding(.horizontal, 20)
            })
        }
    }
}



struct quickLoginSheet : View {
    
    var language = LocalizationService.shared.language
    @Binding var IsPresented: Bool
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
                        
                        
                        
                            ButtonView(text:"Sign in", action: {
                                withAnimation(.easeIn(duration: 0.3)) {
                                    IsPresented =  false
                                }
                            })
                        
                        ButtonView(text: "Quick Reservation", backgroundColor: .white){
                            // action
                            IsPresented =  false

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
    //                                gotoSpec=true

                                }, label: {
//
                Text(exType.SlotTime ?? "")
                                .padding(.vertical,10)
                                .foregroundColor(selectedTime == (exType.SlotTime ) ? .white : .gray)
//
                                })
                                    .frame(width: (UIScreen.main.bounds.width/3)-20, height: 35)
                                    .background( selectedTime == (exType.SlotTime) ? Color("darkGreen").opacity(0.7):.white)
                                    .cornerRadius(8)
                                    .shadow(color: .black.opacity(0.099), radius: 5)
                            }
            }

        }
        .padding(.horizontal,13)

    }
}
