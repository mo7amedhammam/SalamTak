//
//  ShowUpdateAreaList.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 13/06/2022.
//

import Foundation
import SwiftUI

//struct ShowUpdateAreaList: View {
//    @EnvironmentObject var patientUpdatedVM : ViewModelUpdatePatientProfile
//    @Binding var ShowArea:Bool
//    @Binding var bounds : CGRect
//    @Binding var offset:CGSize
//    
//    var body: some View {
//        ZStack {
//            // needs to handle get country by id
//            ChooseArea(IsPresented:$ShowArea,SelectedAreaName:$patientUpdatedVM.areaName, SelectedAreaId: $patientUpdatedVM.AreaId,SelectedCityId: $patientUpdatedVM.CityId , width: bounds.size.width )
//            
//        }
//        .transition(.move(edge: .bottom))
//        .offset(x: 0, y: offset.height > 0 ? offset.height : -160)
//        .gesture(
//            DragGesture()
//                .onChanged { gesture in
//                    self.offset.height = gesture.translation.height
//                    
//                }
//                .onEnded { _ in
//                    if self.offset.height > bounds.size.height / 8 {
//                        withAnimation {
//                            ShowArea = false
//                        }
//                        self.offset = .zero
//                    } else {
//                        self.offset = .zero
//                    }
//                }
//            
//        )
//        
//        
//    }
//}

