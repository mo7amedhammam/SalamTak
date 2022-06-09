//
//  PatientDetails.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 07/06/2022.
//

import Foundation
import SwiftUI
import Combine
struct PatientDetails: View {
    
    var body: some View {
        VStack(spacing:10){
            HStack {
                Text("Patient_details".localized(language))
                Spacer()
            }
            
            .padding(.leading)
            .padding(.vertical,10)
            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
            
            HStack(){
                Image("person")
                    .resizable()
                    .foregroundColor(Color("darkGreen"))
                
                    .frame(width: 25, height: 25)
                    .padding(.leading)
                HStack{
                    Text("Patient_Name_:".localized(language))
                        .foregroundColor(Color("darkGreen"))
                        .font(Font.SalamtechFonts.Reg14)
                    Text(  Helper.getpatientName() )
                        .foregroundColor(.secondary)
                        .font(Font.SalamtechFonts.Reg14)
                }
                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                
                .padding(.trailing)
                Spacer()
            }.padding(.leading)
                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
            
            HStack{
                Image( "Phone")
                    .resizable()
                    .foregroundColor(Color("darkGreen"))
                    .frame(width: 25, height: 25)
                    .padding(.leading)
                
                HStack(){
                    Text("Patient_Number_:".localized(language))
                        .foregroundColor(Color("darkGreen"))
                        .font(Font.SalamtechFonts.Reg14)
                    Text("\(Helper.getUserPhone() )" )
                        .foregroundColor(.secondary)
                        .font(Font.SalamtechFonts.Reg14)
                }
                .padding(.trailing)
                Spacer()
            }.padding(.leading)
                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
            HStack{
                Circle()
                    .fill(Color("CLVBG"))
                    .shadow(color: .black.opacity(0.2), radius: 2)
                    .frame(width: 40, height: 40).padding(.leading,-20)
                Image("Line")
                    .resizable()
                    .renderingMode(.original)
                    .tint(.black)
                    .frame( height: 2)
                    .foregroundColor(.black)
                Circle()
                    .fill(Color("CLVBG"))
                    .shadow(color: .black.opacity(0.2), radius: 2)
                    .frame(width: 40, height: 40).padding(.trailing,-20)
            }
            .padding(.bottom,0)
            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
           
        }
    }
}

