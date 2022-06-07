//
//  slotView.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 07/06/2022.
//

import Foundation
import SwiftUI
struct slotView:View{
    var slots : [Sched]
    var vGridLayout = [ GridItem(.adaptive(minimum: 90), spacing: 20) ]
    @Binding var selectedTime :String
    var body:some View{
        LazyVGrid(columns: vGridLayout){
            ForEach(slots, id:\.id ) { exType in
                ZStack {
                    Button(action: {
                        selectedTime = exType.SlotTime ?? ""
                    }, label: {
                        Text(ConvertStringDate(inp: exType.SlotTime ?? "", FormatFrom: "HH:mm:ss", FormatTo: "hh:mm a") )
                            .padding(.vertical,10)
                            .foregroundColor(selectedTime == (exType.SlotTime ) ? .white : .gray)
                    })
                        .frame(width: (UIScreen.main.bounds.width/3)-20, height: 35)
                        .background(!(exType.IsAvailable ?? true) ? Color("darkGreen").opacity(0.3):selectedTime == (exType.SlotTime) ? Color("darkGreen").opacity(0.7):.white)
                        .cornerRadius(8)
                        .shadow(color: .black.opacity(0.099), radius: 5)
                        .disabled(!(exType.IsAvailable ?? true))
                }
            }
            
        }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
            .padding(.horizontal,13)
        
    }
}
