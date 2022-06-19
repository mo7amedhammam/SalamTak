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

struct ShowBloodTypeList_Previews: PreviewProvider {
    static var previews: some View {
        let bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        let offset = CGSize(width: 100, height: 100)
        let environmentobject = ViewModelCreateMedicalProfile()
        let environmentobject1 = ViewModelBloodType()

        ShowBloodTypeList(ShowBloodType: .constant(true), bounds: .constant(bounds), offset: .constant(offset))
            .environmentObject(environmentobject)
            .environmentObject(environmentobject1)

        
    }
}
