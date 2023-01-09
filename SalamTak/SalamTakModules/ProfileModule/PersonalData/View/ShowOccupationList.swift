//
//  ShowOccupationList.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 13/06/2022.
//

import Foundation
import SwiftUI

struct ShowOccupationList: View {
    @Binding var ShowOccupation:Bool
    @Binding var SelectedOccupationName : String
    @Binding var SelectedOccupationId : Int
    
    var body: some View {
        ZStack {
            ChooseOccupation(IsPresented: $ShowOccupation, SelectedOccupationName: $SelectedOccupationName, SelectedOccupationId: $SelectedOccupationId)
            
        }
        .transition(.move(edge: .bottom))
        .background(
            Color.black
                .ignoresSafeArea()
                .opacity(0.3)
                .blur(radius: 0.5)
                .disabled(ShowOccupation)
        )
        .onTapGesture(perform: {
            ShowOccupation = false
        })
    }
}

struct ShowOccupationList_Previews: PreviewProvider {
    static var previews: some View {
        
        ShowOccupationList(ShowOccupation: .constant(true),SelectedOccupationName: .constant(""),SelectedOccupationId: .constant(0))
    }
}
