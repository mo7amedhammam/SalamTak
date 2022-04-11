//
//  ViewDocDetails.swift
//  SalamTech
//
//  Created by wecancity on 11/04/2022.
//

import SwiftUI

struct ViewDocDetails:View{
    
    var body: some View{
        NavigationView{

        
            
            ZStack {
                VStack{
                    Image("Rectangle")
                        .resizable()
                        .edgesIgnoringSafeArea(.top)
    //                    .aspectRatio( contentMode: .fill)
                        .frame( height: 80)
                        
                    
                    
                    ScrollView{
                        
                        ZStack{
                            ZStack {
                                VStack( spacing:0){

                                HStack{
                                    ZStack {
                                        Image("logo")
                                            .resizable()
                                            .frame(width: 70, height: 70)
                                            .background(Color.gray)
                                            .cornerRadius(9)
                                            .padding(.top,-35)

                                    }.frame(width: 70, height: 70)
//                                        .offset(y:-20)

                                    
                                        Text("Dr/ ")
                                        .foregroundColor(.black.opacity(0.7))
                                    
                                        Text("doctor name")
                                            .font(Font.SalamtechFonts.Bold18)

                                    Spacer()

                                }.padding(.leading)
                                
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

    //                                        Text(Doctor.SubSpecialistName?.joined(separator: ", ") ?? "")
    //                                            .foregroundColor(Color("darkGreen"))
    //                                            .font(Font.SalamtechFonts.Reg14)
                                            Spacer()
                                        }

                                        Spacer()

                                    }.padding(.leading)




        //                        VStack(spacing:0){
        //                            HStack{
        //                                Image("doc1")
        //                                Text(Doctor.SpecialistName ?? "")
        //                                    .foregroundColor(Color("darkGreen"))
        //                                    .font(Font.SalamtechFonts.Reg14)
        //                                Text(" Specialized in ")
        //                                    .foregroundColor(.secondary)
        //                                    .font(Font.SalamtechFonts.Reg14)
        //                                Text(Doctor.SubSpecialistName?.joined(separator: ", ") ?? "")
        //                                    .foregroundColor(Color("darkGreen"))
        //                                    .font(Font.SalamtechFonts.Reg14)
        //                                Spacer()
        //                            }.padding(.leading)
        //
        //                            HStack{
        //                                Image("doc2")
        //                                Text("\(Doctor.ClinicName  ?? ""): ")
        //                                        .foregroundColor(Color("darkGreen"))
        //                                        .font(Font.SalamtechFonts.Reg14)
        //                                Text("\n        \(Doctor.ClinicAddress ?? "")")
        //                                    .foregroundColor(.secondary)
        //                                    .font(Font.SalamtechFonts.Reg14)
        //                                    Spacer()
        //                            }.padding(.leading)
        //
        //                            HStack{
        //                                Image("doc3")
        //                                Text("Fees:")
        //                                    .foregroundColor(Color("darkGreen"))
        //                                    .font(Font.SalamtechFonts.Reg14)
        //                                Text("\( String( Doctor.FeesFrom ?? 0.0)) to \( String( Doctor.FeesTo ?? 0.0)) EGP (Upon time & date)")
        //                                    .foregroundColor(.secondary)
        //                                    .font(Font.SalamtechFonts.Reg14)
        //
        //                                Spacer()
        //                            }.padding(.leading)
        //
        //                            HStack{
        //                                Image("doc4")
        //                                Text("Waiting Time:")
        //                                    .foregroundColor(Color("darkGreen"))
        //                                    .font(Font.SalamtechFonts.Reg14)
        //                                Text("\(Doctor.WaitingTime ?? 0)" + " Minutes")
        //                                    .foregroundColor(.secondary)
        //                                    .font(Font.SalamtechFonts.Reg14)
        //
        //                                Spacer()
        //                            }.padding(.leading)
        //                        }



                            }//V
                                
                                
                            .frame(height: 140)
                            .background(Color.white).frame( height: 140).cornerRadius(9)

                                
                            } //Z
                            .frame(height: 180)
                            .background(.clear)

                            .cornerRadius(9)
                            .offset( y: -10)

              

                        }//Z
                        .frame(height: 180)
                        .background(.red)
                        .background(.white)
//                        .cornerRadius(9)
//                        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                        
                        .shadow(color: .black.opacity(0.1), radius: 9)

                       




                }
                .frame(width: UIScreen.main.bounds.width-30)
                .background(.clear)
                .offset( y: -105)

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
