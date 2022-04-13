//
//  ViewDocDetails.swift
//  SalamTech
//
//  Created by wecancity on 11/04/2022.
//

import SwiftUI

struct ViewDocDetails:View{
    var body: some View{
//        NavigationView{

                    ZStack {
                VStack{
                    Image("Rectangle")
                        .resizable()
//                        .aspectRatio( contentMode: .fill)
                        .frame(width:UIScreen.main.bounds.width, height: 200)

                    ScrollView {
                        ViewDocMainInfo()

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
        
//     }
        
     // go to clinic info
//        NavigationLink(destination:SpecialityView(),isActive: $gotoSpec) {
//             }
//     .navigationBarHidden(true)
//     .navigationBarBackButtonHidden(true)

        
    }
}

struct ViewDocDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ViewDocDetails()
        }.navigationBarHidden(true)
        
    }
}

struct ViewDocMainInfo: View {
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
                            
                            Text("doctor name")
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
    @State var selectedDate = ""
    @State var timeexpanded = false
    var weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]


    var body: some View {
        VStack{
            Text("Choose date & time").frame(width: UIScreen.main.bounds.width-20, height: 35, alignment:.bottomLeading)
            
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
                            Text("Apr, 2022")
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
                        ForEach(weekdays){ day in
                            
                            Button(action: {
                                // select date
                                selectedDate = day
                            }, label: {
                                VStack{
                                    
                                    Text("1")
                                    Text(day)
                                    //                                                    .padding(.vertical, 0)
                                    
                                    if selectedDate == day{
                                        Text(".")
                                            .font(.system(size: 40) )
                                        //                                                        .frame(height:10)
                                            .padding(.top, -40)
                                    }
                                }                                            .frame(width:(UIScreen.main.bounds.width-40)/7)
                                
                                
                            }).foregroundColor(Color("blueColor"))
                                .background( selectedDate == day ? Color("darkGreen").opacity(0.19):.clear)
                                .cornerRadius(8)
                            
                                .padding(.bottom, 5)
                            
                            
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
                        .foregroundColor(Color("darkGreen"))
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
