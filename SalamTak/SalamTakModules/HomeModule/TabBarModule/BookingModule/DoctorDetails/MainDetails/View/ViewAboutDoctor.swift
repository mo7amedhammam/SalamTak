//
//  ViewAboutDoctor.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 07/06/2022.
//

import Foundation
import SwiftUI

enum detailOrBooking{
    case Details,Booking
}

struct ViewAboutDoctor: View {
    var language = LocalizationService.shared.language

    var DoctorAbout : String
    var body: some View {
            VStack{
                HStack {
                    Text("About_doctor".localized(language))
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                        .bold()
                }
                .padding(.vertical,8)
                .padding(.horizontal,30)
                .background(Color.salamtackWelcome)
                .cornerRadius(20)
                
                ZStack{
                    Text(DoctorAbout)
//                        .frame(width: UIScreen.main.bounds.width-30)
                        .foregroundColor(.salamtackBlue)
                        .font(Font.SalamtechFonts.Reg14)
//                        .padding()
//                        .background(Color.white)
                      
                }
//                .frame(width: UIScreen.main.bounds.width-30)
//                .cornerRadius(9)
//                .shadow(color: .black.opacity(0.1), radius: 9)
            }
            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

    }
}

struct ViewAboutDoctor_Previews: PreviewProvider {
    static var previews: some View {
        ViewAboutDoctor(DoctorAbout : "k klnkl nkl nkl kln ,.miknkl mlkn l;mlkn l;ml klnl lml; ljl; mmopm l;jkl m l kl kl lk kl kl klnklnlkll kl kl kl kl kl  kl jhklnklnlkklnfladnfklsdnvldsklvnlk kl njkn")
        
    }
}
