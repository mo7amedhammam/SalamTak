//
//  File.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 05/06/2022.
//

import Foundation
import SwiftUI

struct SpecialityBuBody: View {
    
    var speciality:Speciality
    var body: some View {
        ZStack {
            HStack{
                Spacer().frame(width:80)
                Text(speciality.Name ?? "")
                    .frame(height:35)
                    .font(Font.SalamtechFonts.Reg18)
                    .foregroundColor(.black)
                Spacer()
            }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                .frame(width: (UIScreen.main.bounds.width)-33, height: 55)
                .background(Color.white)
                .cornerRadius(25)
                .shadow(color: .black.opacity(0.099), radius: 5)
            
            
            HStack {
                AsyncImage(url: URL(string:   URLs.BaseUrl + "\(speciality.image ?? "")" )) { image in
                    
                    image.resizable()
                } placeholder: {
                    Image("heart")
                        .resizable()
                }
                .clipShape(Circle())
                .frame(width: 60, height: 60)
                Spacer()
            }.padding(.leading,5)
                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
   
        }
    }
}
