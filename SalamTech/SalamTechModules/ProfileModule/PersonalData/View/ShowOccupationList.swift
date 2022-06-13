//
//  ShowOccupationList.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 13/06/2022.
//

import Foundation
import SwiftUI

struct ShowOccupationList: View {
    @EnvironmentObject var patientCreatedVM : ViewModelCreatePatientProfile
    @EnvironmentObject var OccupationVM : ViewModelOccupation
    
    @Binding var ShowOccupation:Bool
    @Binding var bounds : CGRect
    @Binding var offset:CGSize
    
    var body: some View {
        
        ZStack {
            // needs to handle get country by id
            ChooseOccupation(IsPresented: $ShowOccupation, SelectedOccupationName: $patientCreatedVM.occupationName, SelectedOccupationId: $patientCreatedVM.OccupationId, width: bounds.size.width).environmentObject(OccupationVM)
            
        }
        .transition(.move(edge: .bottom))
        .offset(x: 0, y: offset.height > 0 ? offset.height : 0)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    self.offset.height = gesture.translation.height
                    
                }
                .onEnded { _ in
                    if self.offset.height > bounds.size.height / 8 {
                        withAnimation {
                            ShowOccupation = false
                        }
                        self.offset = .zero
                    } else {
                        self.offset = .zero
                    }
                }
            
        )
        
        
    }
}

