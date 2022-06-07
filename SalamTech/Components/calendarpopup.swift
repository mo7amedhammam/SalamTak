//
//  calendarpopup.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 07/06/2022.
//

import Foundation
import SwiftUI
import Combine

struct calendarPopUp:View{
    @Binding var selectedDate : Date
    @Binding var isPresented : Bool

    var body: some View{
        if isPresented{
        ZStack {
                DatePicker("", selection: $selectedDate, in: Date()..., displayedComponents: .date )
                    .datePickerStyle(.graphical)
                    .background(.white)
                    .cornerRadius(22)
                    .padding()

            
            
        }
        .shadow(color: .black.opacity(0.3), radius: 12)
                .onChange(of: selectedDate){_ in
                    isPresented = false
                }
        }
           

    }
}
struct calendarPopUp_Previews: PreviewProvider {
    static var previews: some View {
        calendarPopUp(selectedDate: .constant(Date()), isPresented: .constant(true))
        
    }
}

