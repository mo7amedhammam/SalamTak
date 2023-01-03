//
//  ShowBloodTypeList.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 13/06/2022.
//

import Foundation
import SwiftUI

struct ShowBloodTypeList: View {

    @Binding var ShowBloodType:Bool
    @Binding var SelectedBloodName : String
    @Binding var SelectedBloodId:Int

    var body: some View {
        ZStack {
            ChooseBloodType( IsPresented:$ShowBloodType ,  SelectedBloodName: $SelectedBloodName, SelectedBloodId: $SelectedBloodId)
        }
        .transition(.move(edge: .bottom))
        .background(
            Color.black
                .ignoresSafeArea()
                .opacity(0.3)
                .blur(radius: 0.5)
                .disabled(ShowBloodType)
        )
        .onTapGesture {
            ShowBloodType = false
        }
    }
}


struct ShowBloodTypeList_Previews: PreviewProvider {
    static var previews: some View {

        ShowBloodTypeList(ShowBloodType: .constant(true),SelectedBloodName: .constant(""),SelectedBloodId: .constant(0))
    }
}
