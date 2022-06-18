//
//  doctorCellTopSection.swift
//  SalamTak
//
//  Created by wecancity on 05/06/2022.
//

import Foundation
import SwiftUI

struct ViewTopSection: View {
    var language = LocalizationService.shared.language

    var Doctor:Doc
    @Binding var ispreviewImage:Bool
    @Binding var previewImageurl:String

    var body: some View {
        HStack{
            AsyncImage(url: URL(string:   URLs.BaseUrl + "\(Doctor.Image ?? "")" )) { image in
                image.resizable()
                
            } placeholder: {
                Image("logo")
                    .resizable()
            }
            .scaledToFill()
            .frame(width:70)
            .background(Color.gray)
            .cornerRadius(9)
            .onTapGesture(perform: {
                ispreviewImage = true
                previewImageurl = URLs.BaseUrl + "\(Doctor.Image ?? "")"
            })
            
            VStack(alignment:.leading){
                //MARK:  --- Name ---
                HStack{
                    Text("Dr/ ".localized(language))
                        .foregroundColor(.black.opacity(0.7))
                    Text(Doctor.DoctorName ?? "")
                        .font(Font.SalamtechFonts.Bold18)
                    
                }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                
                //MARK:  --- Seniority  ---
                HStack{
                    Text(Doctor.SeniortyLevelName ?? "")
                        .foregroundColor(.gray.opacity(0.7))
                        .font(Font.SalamtechFonts.Reg14)

                }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                
                //MARK:  --- Rate ---
                HStack{
                    StarsView(rating: Float( Doctor.Rate ?? 0))
                    
                    Text("( \(Doctor.NumVisites ?? 0) "+"Patientsـ)".localized(language))
                        .foregroundColor(.black.opacity(0.7))
                        .font(Font.SalamtechFonts.Reg14)
                }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
            }
            Spacer()
            
        }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
        .padding(10)
        .frame(height:115)
    }
}

struct ViewTopSection_Previews: PreviewProvider {
    static var previews: some View {
        ViewTopSection(Doctor: Doc.init(), ispreviewImage: .constant(false), previewImageurl: .constant(""))
    }
}
