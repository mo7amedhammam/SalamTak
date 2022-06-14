//
//  ShowFoodAllergyList.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 13/06/2022.
//

import Foundation
import SwiftUI
struct ShowFoodAllergyList: View {
    @EnvironmentObject var medicalCreatedVM : ViewModelCreateMedicalProfile

    @Binding var ShowFoodAllergy:Bool
    @Binding var bounds : CGRect
    @Binding var offset:CGSize

    var body: some View {
        ZStack {
            ChooseFoodAllergy(IsPresented: $ShowFoodAllergy, selectedServiceName: $medicalCreatedVM.PatientFoodAllergiesName, selectedServiceId: $medicalCreatedVM.PatientFoodAllergiesDto,  width: UIScreen.main.bounds.size.width)
        }
//        .transition(.move(edge: .bottom))
        .offset(x: 0, y: offset.height > 0 ? offset.height : 0)
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


