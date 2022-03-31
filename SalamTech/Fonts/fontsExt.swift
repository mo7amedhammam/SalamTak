//
//  fontsExt.swift
//  SalamTech
//
//  Created by wecancity on 30/03/2022.
//


import SwiftUI

extension Font {
    struct salamFonts {
        let Reg14 = Font.custom("STC-Regular", size: 14)
        let Reg16 = Font.custom("STC-Regular", size: 16)
        let Reg18 = Font.custom("STC-Regular", size: 18)
        let Reg24 = Font.custom("STC-Regular", size: 24)

        let Bold14 = Font.custom("STC-Bold", size: 14)
        let Bold16 = Font.custom("STC-Bold", size: 16)
        let Bold18 = Font.custom("STC-Bold", size: 18)
        let Bold24 = Font.custom("STC-Bold", size: 24)
    }
    static let SalamtechFonts = salamFonts()
}

//MARK: -- to use this custom font
// ("your Text") .font(Font.SalamtechFonts.Bold16)

