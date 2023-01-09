//
//  ShowAreaList.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 13/06/2022.
//

import Foundation
import SwiftUI

struct ShowAreaList: View {
    @Binding var ShowArea:Bool
    @Binding var SelectedCityId : Int
    @Binding var SelectedAreaName : String
    @Binding var SelectedAreaId : Int
    
    var body: some View {
        ZStack {
            // needs to handle get country by id
            ChooseArea(IsPresented:$ShowArea,SelectedAreaName:$SelectedAreaName, SelectedAreaId: $SelectedAreaId,SelectedCityId: $SelectedCityId  )
        }
        .transition(.move(edge: .bottom))
        .background(
            Color.black
                .ignoresSafeArea()
                .opacity(0.3)
                .blur(radius: 0.5)
                .disabled(ShowArea)
        )
        .onTapGesture(perform: {
            ShowArea = false
        })
        
    }
}

struct ShowAreaList_Previews: PreviewProvider {
    static var previews: some View {

        ShowAreaList(ShowArea: .constant(true),SelectedCityId: .constant(0),SelectedAreaName: .constant(""),SelectedAreaId: .constant(0))
    }
}
