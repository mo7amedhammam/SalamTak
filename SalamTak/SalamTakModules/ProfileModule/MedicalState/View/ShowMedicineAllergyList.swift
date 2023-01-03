//
//  ShowMedicineAllergyList.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 13/06/2022.
//

import Foundation
import SwiftUI

struct ShowMedicineAllergyList: View {

    @Binding var ShowMedicineAllergy:Bool
    @Binding var selectedMedicalAlgName : [String]
    @Binding var selectedMedicalAlgId : [Int]

    var body: some View {
        ZStack {
            ChooseMedicineAllergy(IsPresented: $ShowMedicineAllergy, selectedMedicalAlgName: $selectedMedicalAlgName, selectedMedicalAlgId: $selectedMedicalAlgId)
        }
        .transition(.move(edge: .bottom))
        .background(
            Color.black
                .ignoresSafeArea()
                .opacity(0.3)
                .blur(radius: 0.5)
                .disabled(ShowMedicineAllergy)
        )
        .onTapGesture {
            ShowMedicineAllergy = false
        }
    }
}


struct ShowMedicineAllergyList_Previews: PreviewProvider {
    static var previews: some View {
        ShowMedicineAllergyList(ShowMedicineAllergy: .constant(true),selectedMedicalAlgName: .constant([]),selectedMedicalAlgId: .constant([]))        
    }
}
