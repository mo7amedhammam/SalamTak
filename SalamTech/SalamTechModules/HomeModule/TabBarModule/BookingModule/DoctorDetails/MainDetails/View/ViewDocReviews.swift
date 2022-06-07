//
//  ViewDocReviews.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 07/06/2022.
//

import Foundation
import SwiftUI

struct ViewDocReviews: View {
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
