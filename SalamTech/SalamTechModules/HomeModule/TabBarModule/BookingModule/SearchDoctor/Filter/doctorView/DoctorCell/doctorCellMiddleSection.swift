//
//  doctorCellMiddleSection.swift
//  SalamTak
//
//  Created by wecancity on 05/06/2022.
//

import Foundation
import SwiftUI

struct ViewMiddelSection: View {
    var language = LocalizationService.shared.language

    var Doctor:Doc
    @State var multiline = true
    var body: some View {
        VStack(spacing:0){
            
            //MARK: --- Speciality & Sub speciality ---
            HStack{
                Image("doc1")
                Text(Doctor.SpecialistName ?? "")
                    .foregroundColor(Color("darkGreen"))
                    .font(Font.SalamtechFonts.Reg14)
                Text(" Specialized_in ".localized(language))
                    .foregroundColor(.secondary)
                    .font(Font.SalamtechFonts.Reg14)
                Text(Doctor.SubSpecialistName?.joined(separator: ", ") ?? "")
                    .foregroundColor(Color("darkGreen"))
                    .font(Font.SalamtechFonts.Reg14)
                    .lineLimit(multiline ? 0:1)
                    .onTapGesture {
                        multiline.toggle()
                    }
                Spacer()
            }.padding(.leading)
                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

            //MARK: --- Clinic Name & address ---
            HStack{
                Image("doc2")
                Text("\(Doctor.ClinicName  ?? ""): ")
                    .foregroundColor(Color("darkGreen"))
                    .font(Font.SalamtechFonts.Reg14)
                Text("\n        \(Doctor.ClinicAddress ?? "")")
                    .foregroundColor(.secondary)
                    .font(Font.SalamtechFonts.Reg14)
                Spacer()
            }.padding(.leading)
                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

            
            //MARK: --- Fees ---
            HStack{
                Image("FilterFees")
                Text("Fees:".localized(language))
                    .foregroundColor(Color("darkGreen"))
                    .font(Font.SalamtechFonts.Reg14)
                Text("\( String( Doctor.FeesFrom ?? 0.0)) "+"to".localized(language)+" \( String( Doctor.FeesTo ?? 0.0)) "+"EGP_(Upon_time_&_date)".localized(language))
                    .foregroundColor(.secondary)
                    .font(Font.SalamtechFonts.Reg14)
                
                Spacer()
            }.padding(.leading)
                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

            
            //MARK: --- Waiting Time ---
            HStack{
                Image("doc4")
                Text("Waiting_Time:".localized(language))
                    .foregroundColor(Color("darkGreen"))
                    .font(Font.SalamtechFonts.Reg14)
                Text("\(Doctor.WaitingTime ?? 0) " + "Minutes".localized(language))
                    .foregroundColor(.secondary)
                    .font(Font.SalamtechFonts.Reg14)
                
                Spacer()
            }.padding(.leading)
                .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

            
            
        }
    }
}
