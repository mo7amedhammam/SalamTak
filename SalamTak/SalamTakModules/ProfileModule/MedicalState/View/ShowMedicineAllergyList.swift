//
//  ShowMedicineAllergyList.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 13/06/2022.
//

import Foundation
import SwiftUI

struct ShowMedicineAllergyList: View {
    @EnvironmentObject var medicalCreatedVM : ViewModelCreateMedicalProfile

    @Binding var ShowMedicineAllergy:Bool
    @Binding var bounds : CGRect
    @Binding var offset:CGSize

    var body: some View {
        ZStack {
            ChooseMedicineAllergy(IsPresented: $ShowMedicineAllergy, selectedServiceName: $medicalCreatedVM.PatientMedicineAllergiesName, selectedServiceId: $medicalCreatedVM.PatientMedicineAllergiesDto,  width: UIScreen.main.bounds.size.width)
            
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
                            ShowMedicineAllergy = false
                        }
                        self.offset = .zero
                    } else {
                        self.offset = .zero
                    }
                }
        )
    }
}


struct ShowMedicineAllergyList_Previews: PreviewProvider {
    static var previews: some View {
        let bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        let offset = CGSize(width: 100, height: 100)
        let environmentobject = ViewModelCreateMedicalProfile()
        ShowMedicineAllergyList(ShowMedicineAllergy: .constant(true), bounds: .constant(bounds), offset: .constant(offset))
            .environmentObject(environmentobject)
        
    }
}
