//
//  ShowFoodAllergyList.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 13/06/2022.
//

import Foundation
import SwiftUI
struct ShowFoodAllergyList: View {
    @Binding var ShowFoodAllergy:Bool
    @Binding var selectedFoodAlgName : [String]
    @Binding var selectedFoodAlgId:[Int]

    var body: some View {
        ZStack {
            ChooseFoodAllergy(IsPresented: $ShowFoodAllergy, selectedFoodAlgName: $selectedFoodAlgName, selectedFoodAlgId: $selectedFoodAlgId)
        }
        .transition(.move(edge: .bottom))
        .background(
            Color.black
                .ignoresSafeArea()
                .opacity(0.3)
                .blur(radius: 0.5)
                .disabled(ShowFoodAllergy)
        )
        .onTapGesture {
            ShowFoodAllergy = false
        }
    }
}


struct ShowFoodAllergyList_Previews: PreviewProvider {
    static var previews: some View {
        ShowFoodAllergyList(ShowFoodAllergy: .constant(true),selectedFoodAlgName: .constant([]),selectedFoodAlgId: .constant([]))
    }
}
