//
//  ShowUpdateBloodTypeList.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 13/06/2022.
//

import Foundation
import SwiftUI

struct ShowUpdateBloodTypeList: View {
    @EnvironmentObject var medicalUpdatedVM : ViewModelUpdateMedicalProfile
    @EnvironmentObject var BloodTypeVM : ViewModelBloodType

    @Binding var ShowBloodType:Bool
    @Binding var bounds : CGRect
    @Binding var offset:CGSize

    var body: some View {
        ZStack {
            
            ChooseBloodType( IsPresented:$ShowBloodType ,  SelectedBloodName: $medicalUpdatedVM.BloodTypeName, SelectedBloodId: $medicalUpdatedVM.BloodTypeId, width: bounds.size.width)
                .environmentObject(BloodTypeVM)
                .environmentObject(medicalUpdatedVM)

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
                            ShowBloodType.toggle()
                        }
                        self.offset = .zero
                    } else {
                        self.offset = .zero
                    }
                }
        )
    }
}

