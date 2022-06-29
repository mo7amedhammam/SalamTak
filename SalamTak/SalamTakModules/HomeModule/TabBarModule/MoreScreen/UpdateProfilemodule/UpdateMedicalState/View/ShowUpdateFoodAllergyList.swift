//
//  ShowUpdateFoodAllergyList.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 13/06/2022.
//

import Foundation
import SwiftUI

struct ShowUpdateFoodAllergyList: View {
    @EnvironmentObject var medicalUpdatedVM : ViewModelUpdateMedicalProfile

    @Binding var ShowFoodAllergy:Bool
    @Binding var bounds : CGRect
    @Binding var offset:CGSize

    var body: some View {
        ZStack {
            ChooseFoodAllergy(IsPresented: $ShowFoodAllergy, selectedServiceName: $medicalUpdatedVM.PatientFoodAllergiesName, selectedServiceId: $medicalUpdatedVM.PatientFoodAllergiesDto,  width: UIScreen.main.bounds.size.width)
        }
        .transition(.move(edge: .bottom))
        .offset(x: 0, y: offset.height > 0 ? offset.height : -160)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    self.offset.height = gesture.translation.height

                }
                .onEnded { _ in
                    if self.offset.height > bounds.size.height / 8 {
                        withAnimation {
                            ShowFoodAllergy = false
                        }
                        self.offset = .zero
                    } else {
                        self.offset = .zero
                    }
                }
        )
    }
}

