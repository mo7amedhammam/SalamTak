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
    var operation:detailOrBooking
    @Binding var ispreviewImage:Bool
    @Binding var previewImageurl:String
    var language = LocalizationService.shared.language
    
    var body: some View {
        VStack {
            ZStack{
//                ZStack {
//
//                } //Z
//                .frame(width:UIScreen.main.bounds.width-30, height: 140)
//                .background(.white)
//                .cornerRadius(9)
//                .offset( y: 20)
                
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
                            .frame(width:60,height: 60)
                            .background(Color.gray)
                            .cornerRadius(9)
                            .onTapGesture(perform: {
                                ispreviewImage = true
                                previewImageurl = URLs.BaseUrl + "\(Doctor.Image ?? "")"
                            })
                            
                            VStack(alignment:.leading, spacing:0){
                                HStack{
                            Text("Dr/ ".localized(language))
                                .foregroundColor(.black.opacity(0.7))
                                .font(.salamtakBold(of: 18))
                                .foregroundColor(.salamtackBlue)
                            
                            Text(Doctor.DoctorName ?? "")
                                .font(.salamtakBold(of: 20))
                                .foregroundColor(.salamtackBlue)
//                                    Spacer()

                                }
                                HStack{
                                    Text(Doctor.SeniortyLevelName ?? "seniiority namr")
                                        .foregroundColor(.black.opacity(0.7))
                                        .font(.system(size: 12))
//                                    Spacer()
                                }
                                
                                HStack{
                                    StarsView(rating: Float( Doctor.Rate ?? 0))
                                    
                                    Text("( \(Doctor.NumVisites ?? 0) "+"Patientsـ)".localized(language))
                                        .foregroundColor(.black.opacity(0.7))
                                        .font(.system(size: 11))
//                                    Spacer()
                                }
                            }
                            Spacer()
                        }
//                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                    }
                    .padding()
                    
                    VStack(alignment:.leading, spacing:0){
                        
                        
                        
                        
                        HStack(spacing:2){
//                            Image("doc1")
                            Text(Doctor.SpecialistName ?? "dentist" )
                                .foregroundColor(.salamtackBlue)
                                .font(.salamtakBold(of: 16))
                            Text(" Specialized_in ".localized(language))
                                .foregroundColor(.secondary)
                                .font(Font.SalamtechFonts.Reg14)
                            Text(Doctor.SubSpecialistName?.joined(separator: ", ") ?? "sub1, sub2, sub3" )
                                .foregroundColor(.black.opacity(0.7))
                                .font(Font.SalamtechFonts.Reg14)
                            
                            
                            Spacer()
                        }
//                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                        
                        
//                        Spacer()
                        
                    }.padding(.leading)
//                        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                    
                }//V
//                .frame(height: 160)
                .background(Color.clear)
                
            }//Z
//            .frame(width: UIScreen.main.bounds.width-20, height: 180)
//            .background(.clear)
            .cornerRadius(9)
//            .shadow(color: .black.opacity(0.1), radius: 9)
            
            if operation == .Booking{
            ZStack {
                HStack(){
                    Image("FilterFees")
//                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(8)
                        .clipShape(Circle())
                        .AddBlueBorder(cornerRadius: 25,linewidth: 1.2)
                    VStack(alignment:.leading){
                        Text("Fees:".localized(language))
                            .foregroundColor(.salamtackWelcome)
                            .font(.system(size: 16))
                            .bold()
                        Text( String( Doctor.FeesFrom ?? 0.0))
                            .foregroundColor(.black.opacity(0.7))
                            .font(Font.SalamtechFonts.Reg14)
                        
                    }.padding(.trailing)
                    Spacer()
//                    Divider()
                    
                    Image("doc4")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(8)
                        .clipShape(Circle())
                        .AddBlueBorder(cornerRadius: 25,linewidth: 1.2)

                        
                    VStack(alignment:.leading){
                        Text("Waiting_Time:".localized(language))
                            .foregroundColor(.salamtackWelcome)
                            .font(.system(size: 16))
                            .bold()
                        Text("\(Doctor.WaitingTime ?? 0) " + "Minutes".localized(language))
                            .foregroundColor(.black.opacity(0.7))
                            .font(Font.SalamtechFonts.Reg14)
                        
                    }.padding(.trailing)
                }
//                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                
//                    .background(Color.white)
            }
            .frame(width: UIScreen.main.bounds.width-30, height:55)
//            .cornerRadius(9)
//            .shadow(color: .black.opacity(0.1), radius: 9)
            
            ZStack{
                HStack{
                    Image("doc2")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(8)
                        .clipShape(Circle())
                        .AddBlueBorder(cornerRadius: 25,linewidth: 1.2)
                    VStack(alignment:.leading,spacing:0){
                        Text("\(Doctor.ClinicName ?? "hosary clinic"): ")
                            .foregroundColor(.salamtackWelcome)
//                            .font(.salamtakBold(of: 17))
                            .font(.system(size: 16))
                            .bold()
                        Text("\(Doctor.ClinicAddress ?? "6th october - hiosary")")
                            .foregroundColor(.black.opacity(0.7))
                            .font(Font.SalamtechFonts.Reg14)
                        //                Spacer()
                    }
//                    .padding(.leading)
//                        .padding()
                    Spacer()
                    
                }
//                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                    .background(Color.white)
            }
            .frame(width: UIScreen.main.bounds.width-30, height:55)
//            .cornerRadius(9)
//            .shadow(color: .black.opacity(0.1), radius: 9)
        }
        }
    }
}

struct ViewDocMainInfo_Previews: PreviewProvider {
    static var previews: some View {
        ViewDocMainInfo(Doctor: Doc.init(DoctorName:"ali mohamed ali"), operation: .Booking, ispreviewImage: .constant(false), previewImageurl: .constant(""))
    }
}
