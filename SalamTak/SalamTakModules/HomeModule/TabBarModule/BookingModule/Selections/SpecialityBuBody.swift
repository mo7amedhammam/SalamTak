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
    var forgroundColor:Color
    var backgroundColor:Color

    var body: some View {
//        ZStack {
//            HStack{
//                Spacer().frame(width:80)
//                Text(speciality.Name ?? "")
//                    .frame(height:35)
//                    .font(Font.SalamtechFonts.Reg18)
//                    .foregroundColor(.black)
//                Spacer()
//            }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
//                .frame(width: (UIScreen.main.bounds.width)-33, height: 55)
//                .background(Color.white)
//                .cornerRadius(25)
//                .shadow(color: .black.opacity(0.099), radius: 5)
//
            
            VStack {
//                AsyncImage(url: URL(string:   URLs.BaseUrl + "\(speciality.image ?? "")" )) { image in
//
//                    image.resizable()
//                } placeholder: {
//                    Image("heart")
//                        .resizable()
//                }
                remoteAsyncImage(imageUrl: "\(speciality.image ?? "")")
//                .clipShape(Circle())
//                .frame(width: 60, height: 60)
//                Spacer()
                
                Text(speciality.Name ?? "")
//                    .frame(height:30)
                    .font(.salamtakBold(of: 18))
                    .foregroundColor(forgroundColor)
                    .background(backgroundColor)

            }
//            .frame(width: 80, height: 80, alignment: .center)
//            .padding(.leading,5)
                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
   
//        }
    }
}

struct SpecialityBuBody_Previews: PreviewProvider {
    static var previews: some View {
        SpecialityBuBody(speciality: Speciality.init(), forgroundColor: .blue, backgroundColor: .white)
    }
}
