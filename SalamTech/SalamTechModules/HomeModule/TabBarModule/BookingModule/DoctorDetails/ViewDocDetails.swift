//
//  ViewDocDetails.swift
//  SalamTech
//
//  Created by wecancity on 11/04/2022.
//

import SwiftUI

var selectedDate = Date()
var totalSquares = [Date]()

struct ViewDocDetails:View{
    var Doctor:Doc
    
    var body: some View{
//        NavigationView{

                    ZStack {
                VStack{
                    Image("Rectangle")
                        .resizable()
//                        .aspectRatio( contentMode: .fill)
                        .frame(width:UIScreen.main.bounds.width, height: 200)

                    ScrollView {
                        ViewDocMainInfo(Doctor: Doctor)

                        ViewDateAndTime()
                        
                        ViewAboutDoctor()
                        
                        ViewDocReviews()

                        Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.width-20)
                    .background(.clear)
                    .padding(.top,-105)

                    Spacer()
//                    }.padding(.top,5)

                    ZStack{
                    Button(action: {
                        // add review
                    }, label: {
                        HStack {
                            Text("Book")
                                .fontWeight(.semibold)
                                .font(.title3)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color("blueColor"))
        //                .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                    })
                    }.background(.clear
                    )
                        .shadow(color: .gray, radius: 9)
                    
                }
                .background(Color("CLVBG"))
            }
            .edgesIgnoringSafeArea(.top)
            .navigationBarItems(leading: BackButtonView())
            .navigationBarBackButtonHidden(true)
            .onAppear(perform: {
                setWeekView()
                let now = convertDateToLocalTime(Date())

                let startWeek = convertDateToLocalTime(now.startOfWeek!)
                let endWeek = convertDateToLocalTime(now.endOfWeek!)
                
                
                print("Local time is: \(now)")
                
                print("Start of week is: \(startWeek)")
                print("End of week is: \(endWeek)")
                
                print("Month : \(CalendarHelper().monthString(date: selectedDate))  \(CalendarHelper().yearString(date: selectedDate) )")
                print(" week :")
                for dayyy  in totalSquares{
                    print(dayyy)
                }


            })
        
        
        
//     }
        
     // go to clinic info
//        NavigationLink(destination:SpecialityView(),isActive: $gotoSpec) {
//             }
//     .navigationBarHidden(true)
//     .navigationBarBackButtonHidden(true)

        
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

    
}

struct ViewDocDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ViewDocDetails(Doctor: Doc.init())
        }.navigationBarHidden(true)
    }
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
                            
                            Image("logo")
                                .resizable()
                                .frame(width: 60, height: 60)
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
                            Text("Seniority lvl ")
                                .foregroundColor(.gray.opacity(0.7))
                                .font(Font.SalamtechFonts.Reg14)
                        }
                        HStack{
                            ForEach(0..<5){_ in
                                Image(systemName: "star.fill") // Imagenames: star || star.fill || star.leadinghalf.filled
                                    .foregroundColor(.yellow)
                            }
                            
                            
                            Text("( (240)"+" Patients )")
                                .foregroundColor(.black.opacity(0.7))
                                .font(Font.SalamtechFonts.Reg14)
                        }
                        
                        HStack{
                            Image("doc1")
                            Text("Doctor.SpecialistName" )
                                .foregroundColor(Color("darkGreen"))
                                .font(Font.SalamtechFonts.Reg14)
                            Text(" Specialized in ")
                                .foregroundColor(.secondary)
                                .font(Font.SalamtechFonts.Reg14)
                            Text("Doctor.subSpecialistName" )
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
                    Text("starting From 200 EGP")
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
                    Text("(15)" + " Minutes")
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
                    Text("(Doctor.ClinicName ?? ): ")
                        .foregroundColor(Color("darkGreen"))
                        .font(Font.SalamtechFonts.Reg14)
                    Text("(Doctor.ClinicAddress ?? )")
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
    @State var TappedDate = ""
    @State var timeexpanded = false
    var weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    var vGridLayout = [ GridItem(.adaptive(minimum: 90), spacing: 30) ]
    var daytimes = ["2:30 PM", "2:50 PM", "3:30 PM", "3:50 PM","4:30 PM", "4:50 PM","5:30 PM", "5:50 PM"]
    @State var selectedTime = ""


    var body: some View {
        VStack{
            
            Text("Choose date & time").frame(width: UIScreen.main.bounds.width-20, height: 35, alignment:.bottomLeading)
            
            //MARK: ---- Days of Week --------
            ZStack{
                VStack{
                    
                    Button(action: {
                        // open Calendar
                    }, label: {
                        HStack{
                            Image("Appointments")
                                .resizable()
                                .frame(width: 20, height: 20)
                            
                                .padding(.bottom,3)
                                .padding(.leading)
                            //                                VStack{
                            Text("\(CalendarHelper().monthString(date: selectedDate))  \(CalendarHelper().yearString(date: selectedDate) )")
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
                    
                    
                    HStack(spacing:0){
                        ForEach(0..<totalSquares.count, id:\.self){ day in
                            
                            Button(action: {
                                // select date
                                TappedDate = weekdays[day]
                                timeexpanded = false
                            }, label: {
                                VStack{
                                    let date = totalSquares[day]

                                    Text(                            String(CalendarHelper().dayOfMonth(date: date))
)
                                    Text(weekdays[day])
                                    //                                                    .padding(.vertical, 0)
                                    
                                    if TappedDate == weekdays[day]{
                                        Text(".")
                                            .font(.system(size: 40) )
                                        //                                                        .frame(height:10)
                                            .padding(.top, -40)
                                    }
                                }                                            .frame(width:(UIScreen.main.bounds.width-40)/7)
                                
                                
                            }).foregroundColor(Color("blueColor"))
                                .background( TappedDate == weekdays[day] ? Color("darkGreen").opacity(0.19):.clear)
                                .cornerRadius(8)
                            
                                .padding(.bottom, 10)
                            
                            
                        }
                        //                                    .padding(5)
                    }
                    //
                    
                    
                    
                    
                }
                
                .background(Color.white)
                
                
            }
            .frame(width: UIScreen.main.bounds.width-30)
            .cornerRadius(9)
            .shadow(color: .black.opacity(0.1), radius: 9)
         //---------------------------------
            
            //MARK: ---- periods of slot --------
            VStack{
            Button(action: {
                timeexpanded.toggle()
                
            }, label: {
                //                            ZStack{
                //                            VStack{
                
                HStack{
                    
                    HStack{
                        Text("2:30 PM")
                            .foregroundColor(Color("darkGreen"))
                            .font(Font.SalamtechFonts.Reg16)
                        
                        Text("To")
                            .foregroundColor(.gray)
                            .font(Font.SalamtechFonts.Reg16)
                        
                        Text("4:30 PM")
                            .foregroundColor(Color("darkGreen"))
                            .font(Font.SalamtechFonts.Reg16)
                        
                    }.background(Image("Rectangle2"))
                    Spacer()
                    
                    Text("Fee:")
                        .foregroundColor(.gray)
                        .font(Font.SalamtechFonts.Reg16)
                    
                    Text("200 EGP")
                        .foregroundColor(Color("darkGreen"))
                        .font(Font.SalamtechFonts.Reg16)
                    
                    Image( systemName: timeexpanded ?  "chevron.up":"chevron.down")
                        .foregroundColor(Color("blueColor"))
                        .padding(.bottom,3)
                    
                    
                }
                .frame(height:50)
                .padding(.horizontal)
                
                
                
                .background(Color.white)
                
                
                //                            }
                //                            .onTapGesture {
                //                                timeexpanded.toggle()
                //                            }
            })  .frame(width: UIScreen.main.bounds.width-30)
                .cornerRadius(9)
                .shadow(color: .black.opacity(0.1), radius: 9)
            
            if timeexpanded{
                LazyVGrid(columns: vGridLayout){
                    ForEach(daytimes) { exType in
                        
                        ZStack {
                            Button(action: {
                                selectedTime = exType
//                                gotoSpec=true
                                
                            }, label: {
                         

                                    
                                    Text(exType )
                                        .padding(.vertical,10)
                                        .foregroundColor(selectedTime == exType ? .white : .gray)
                                
                            })
                                .frame(width: (UIScreen.main.bounds.width/3)-20, height: 35)
                                .background( selectedTime == exType ? Color("darkGreen").opacity(0.7):.white)
                                .cornerRadius(8)
                                .shadow(color: .black.opacity(0.099), radius: 5)
                        }
                    }
                                        
                }
                .padding(.horizontal,13)
            }
        }
            
            //-----------------------------------------
            
            
        }
    }
}

struct ViewAboutDoctor: View {
    var body: some View {
        VStack{
            
            Text("About doctor").frame(width: UIScreen.main.bounds.width-20, height: 35, alignment:.bottomLeading)
            
            ZStack{
                
                Text("Ahmed was born on 1964 in El Fayoum. After studying veterinary medicine at Cairo University, Ahmed moved to Vienna, Austria where he completed his studies.")
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
    var body: some View {
        VStack{
            HStack{
                Text("Reviews")
                Spacer()
                Text("View all 125 reviews")
                    .foregroundColor(Color("darkGreen"))
                Image( systemName: "chevron.forward")
                //                                        .resizable()
                    .foregroundColor(Color("darkGreen"))
                //                                        .frame(width: 20, height: 20)
                    .padding(.trailing)
                
                
            }.frame(width: UIScreen.main.bounds.width-20, height: 35, alignment:.bottomLeading)
            
            ScrollView(.horizontal){
                HStack{
                    ForEach(0..<4){_ in
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
                                            Text("patient name").padding(.bottom,8)
//                                            .font(Font.SalamtechFonts.Bold18)
                                            .font(.system(size: 20))
                                        
                                            
                                            HStack(spacing:15){
                                                      ForEach(0..<5){_ in
                                                          Image(systemName: "star.fill") // Imagenames: star || star.fill || star.leadinghalf.filled
                                                              .frame(width: 10, height: 10)
                                                              .foregroundColor(.yellow)
                                                      }
                                                      
                                                      
                                                      
                                            }.padding(.trailing)

                                        }
                                        .padding(.top, 10)

                                        Spacer()
                                    }
                                }
                                .padding()
                                //                                    .padding(.top,-10)
                                
                                VStack(alignment:.leading, spacing:0){
                                    
                                    Text("Thank you very much! Great clinic! The dog was limping, X-rayed, prescribed quality treatment. Dog of fights! Excellent specialists! more" )
//                                    Text(".." )

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
