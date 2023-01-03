////
////  ShowUpdateCityList.swift
////  SalamTak
////
////  Created by Mohamed Hammam on 13/06/2022.
////
//
//import Foundation
//import SwiftUI
//
//struct ShowUpdateCityList: View {
////    @EnvironmentObject var patientUpdatedVM : ViewModelUpdatePatientProfile
//    @Binding var ShowCity:Bool
//    @Binding var SelectedCountryId : Int
//    @Binding var SelectedCityId:Int
//    @Binding var SelectedCityName:String
//    var body: some View {
//        ZStack {
//            // needs to handle get country by id
//            ChooseCity(IsPresented: $ShowCity , SelectedCityName: $SelectedCityName , SelectedCityId: $SelectedCityId ,SelectedCountryId: $SelectedCountryId )
//        }
//        .transition(.move(edge: .bottom))
////        .offset(x: 0, y: offset.height > 0 ? offset.height : -160)
////        .gesture(
////            DragGesture()
////                .onChanged { gesture in
////                    self.offset.height = gesture.translation.height
////                }
////                .onEnded { _ in
////                    if self.offset.height > bounds.size.height / 8 {
////                        withAnimation {
////                            ShowCity = false
////                        }
////                        self.offset = .zero
////                    } else {
////                        self.offset = .zero
////                    }
////                }
////        )
//        
//    }
//}
//
//
//struct ShowUpdateCityList_Previews: PreviewProvider {
//    static var previews: some View {
//        ShowUpdateCityList( ShowCity: .constant(true),SelectedCountryId: .constant(0),SelectedCityId: .constant(0),SelectedCityName: .constant(""))
////            .environmentObject(ViewModelUpdatePatientProfile())
//    }
//}
