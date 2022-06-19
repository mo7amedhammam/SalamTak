//
//  ShowAreaList.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 13/06/2022.
//

import Foundation
import SwiftUI

struct ShowAreaList: View {
    @EnvironmentObject var patientCreatedVM : ViewModelCreatePatientProfile
    @Binding var ShowArea:Bool
    @Binding var bounds : CGRect
    @Binding var offset:CGSize
    
    var body: some View {
        ZStack {
            // needs to handle get country by id
            ChooseArea(IsPresented:$ShowArea,SelectedAreaName:$patientCreatedVM.areaName, SelectedAreaId: $patientCreatedVM.AreaId,SelectedCityId: $patientCreatedVM.CityId , width: bounds.size.width )
            
        }
        .transition(.move(edge: .bottom))
        .offset(x: 0, y: offset.height > 0 ? offset.height : 0)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    self.offset.height = gesture.translation.height
                    
                }
                .onEnded { _ in
                    if self.offset.height > bounds.size.height / 8 {
                        withAnimation {
                            ShowArea = false
                        }
                        self.offset = .zero
                    } else {
                        self.offset = .zero
                    }
                }
            
        )
        
        
    }
}

struct ShowAreaList_Previews: PreviewProvider {
    static var previews: some View {
        let bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        let offset = CGSize(width: 100, height: 100)
        let environmentobject = ViewModelCreatePatientProfile()

        ShowAreaList(ShowArea: .constant(true), bounds: .constant(bounds), offset: .constant(offset))
                .environmentObject(environmentobject)
        
    }
}
