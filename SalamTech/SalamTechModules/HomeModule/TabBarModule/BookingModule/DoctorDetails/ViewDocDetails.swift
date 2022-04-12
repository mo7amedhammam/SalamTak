//
//  ViewDocDetails.swift
//  SalamTech
//
//  Created by wecancity on 11/04/2022.
//

import SwiftUI

struct ViewDocDetails:View{
    var weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    var body: some View{
        NavigationView{

        
            
            ZStack {
                VStack{
                    Image("Rectangle")
                        .resizable()
                        .edgesIgnoringSafeArea(.top)
    //                    .aspectRatio( contentMode: .fill)
                        .frame( height: 80)
                        
                    
//                    VStack{

                    ScrollView {
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

                        Text("Choose date & time").frame(width: UIScreen.main.bounds.width-20, height: 35, alignment:.bottomLeading)
                        
                        ZStack{
                            VStack{
                                
                                HStack{
                                    Image("Appointments")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .padding(.leading)
                                    //                                VStack{
                                    Text("Apr 2022 >")
                                        .foregroundColor(Color("darkGreen"))
                                        .font(Font.SalamtechFonts.Reg14)
                                    
                                    Spacer()
                                    
                                }
                                .padding()
                                Divider().padding(.top,-10)
                                
                                
                                HStack{
                                    ForEach(weekdays){ day in
                                        
                                        VStack{
                                            
                                            Text("1")
                                            Text(day)
                                        }
                                        .padding(5)
                                      
                                        
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
                        
                        
                        
                        HStack{
                            Text("Reviews")
                            Spacer()
                            Text("View all 125 reviews  >")
                                .foregroundColor(Color("darkGreen"))

                            
                        }.frame(width: UIScreen.main.bounds.width-20, height: 35, alignment:.bottomLeading)
                        
                        

    Spacer()
                    }
                    .frame(width: UIScreen.main.bounds.width-20)
                    .background(.clear)
                    .padding(.top,-105)
//                    .edgesIgnoringSafeArea(.all)

                    Spacer()
                }
                
                .background(Color("CLVBG"))

            }
            
            
        
        
     }
        
     // go to clinic info
//        NavigationLink(destination:SpecialityView(),isActive: $gotoSpec) {
//             }
     .navigationBarHidden(true)
     .navigationBarBackButtonHidden(true)

        
    }
}

struct ViewDocDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ViewDocDetails()
        }.navigationBarHidden(true)
    }
}
