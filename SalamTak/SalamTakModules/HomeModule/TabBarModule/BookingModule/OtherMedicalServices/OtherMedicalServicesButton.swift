//
//  OtherMedicalServicesButton.swift
//  SalamTak
//
//  Created by wecancity on 01/02/2023.
//


import Foundation
import SwiftUI

struct OtherMedicalServicesButton: View {
    var language = LocalizationService.shared.language

    var MedicalType:ExaminationType
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
            
        VStack(spacing:0) {
//                AsyncImage(url: URL(string:   URLs.BaseUrl + "\(speciality.image ?? "")" )) { image in
//
//                    image.resizable()
//                } placeholder: {
//                    Image("heart")
//                        .resizable()
//                }
//                remoteAsyncImage(imageUrl: "\(MedicalType.image ?? "")")
//                .clipShape(Circle())
//                .frame(width: 60, height: 60)
//                Spacer()
                Image(MedicalType.image ?? "")
                    .resizable()
                    .aspectRatio( contentMode: .fill)

                
                Text(MedicalType.Name?.localized(language) ?? "")
                    .multilineTextAlignment(.center)
                    .frame(height:50)
//                    .font(.salamtakBold(of: 18))
//                    .bold()
                    .foregroundColor(forgroundColor)
//                    .background(backgroundColor)
            }
        .background(backgroundColor)

            .frame(width: (UIScreen.main.bounds.width)/4,height:140)

//            .frame(width: 80, height: 80, alignment: .center)
//            .padding(.leading,5)
                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
   
//        }
    }
}

struct OtherMedicalServicesButton_Previews: PreviewProvider {
    static var previews: some View {
        OtherMedicalServicesButton(MedicalType: ExaminationType.init(id: 0, Name: "Radiology Center", image: "RadiologyCenter", Inactive: false) , forgroundColor: .blue, backgroundColor: .white)
    }
}
