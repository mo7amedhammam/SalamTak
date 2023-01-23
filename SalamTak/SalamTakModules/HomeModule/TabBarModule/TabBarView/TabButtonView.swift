//
//  TabButtonView.swift
//  SalamTak
//
//  Created by wecancity on 08/06/2022.
//

import Foundation
import SwiftUI
struct TabButton: View{
    @AppStorage("language")
    var language = LocalizationService.shared.language
    var title: String
    
    @Binding var selectedTab: String
//    @Binding var AppointmentsTabIndex:Int
//    @Binding var promotionIndex: Int
//    @Binding var MoreIndex: Int
    
    var ButtonAction: (() -> ())?

    var body: some View {
        Button(action: {
            ButtonAction?()
       
        }, label: {
            VStack(spacing: 6){
                Image(title)
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(selectedTab == title ? .salamtackBlue : Color.black.opacity(0.2))
                    .frame(width: 24, height: 24)
                
                Text(title.localized(language))
                    .font(Font.SalamtechFonts.Reg16)
                    .font(.caption)
                    .foregroundColor(Color.black.opacity(selectedTab == title ? 0.6 : 0.2))
            }
        })
    }
}

struct TabButton_Previews: PreviewProvider {
    static var previews: some View {
        TabButton(title: "Home", selectedTab: .constant("Button"))
    }
}
