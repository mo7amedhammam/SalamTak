//
//  ViewDocMainInfo.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 07/06/2022.
//

import Foundation
import SwiftUI

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
