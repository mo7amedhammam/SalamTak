////
////  ShowUpdateNationalityList.swift
////  SalamTak
////
////  Created by Mohamed Hammam on 13/06/2022.
////
//
//import Foundation
//import SwiftUI
//
//struct ShowUpdateNationalityList: View {
//    @EnvironmentObject var patientUpdatedVM : ViewModelUpdatePatientProfile
//    @EnvironmentObject var NationalityVM : ViewModelCountries
//    @Binding var ShowNationality:Bool
//    @Binding var bounds : CGRect
//    @Binding var offset:CGSize
//    
//    var body: some View {
//        ZStack {
//            ChooseNationality( IsPresented: $ShowNationality, SelectedNationalityName: $patientUpdatedVM.NationalityName, SelectedNationalityId: $patientUpdatedVM.NationalityId)
//                .environmentObject(NationalityVM)
//                .environmentObject(patientUpdatedVM)
//            
//        }
//        .transition(.move(edge: .bottom))
//        .offset(x: 0, y: offset.height > 0 ? offset.height : -160)
//        .gesture(
//            DragGesture()
//                .onChanged { gesture in
//                    self.offset.height = gesture.translation.height
//                }
//                .onEnded { _ in
//                    if self.offset.height > bounds.size.height / 8 {
//                        withAnimation {
//                            ShowNationality.toggle()
//                        }
//                        self.offset = .zero
//                    } else {
//                        self.offset = .zero
//                    }
//                }
//        )
//    }
//}
//
