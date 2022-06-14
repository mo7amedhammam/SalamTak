//
//  ShowBloodTypeList.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 13/06/2022.
//

import Foundation
import SwiftUI

struct ShowBloodTypeList: View {
@EnvironmentObject var medicalCreatedVM : ViewModelCreateMedicalProfile
@EnvironmentObject var BloodTypeVM : ViewModelBloodType

@Binding var ShowBloodType:Bool
@Binding var bounds : CGRect
@Binding var offset:CGSize

var body: some View {
    ZStack {
        ChooseBloodType(  IsPresented:$ShowBloodType ,  SelectedBloodName: $medicalCreatedVM.BloodTypeName, SelectedBloodId: $medicalCreatedVM.BloodTypeId, width: bounds.size.width).environmentObject(BloodTypeVM)
    }
//    .transition(.move(edge: .bottom))
    .offset(x: 0, y: offset.height > 0 ? offset.height : 0)
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

