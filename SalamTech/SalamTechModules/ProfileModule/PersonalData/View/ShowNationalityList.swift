//
//  ShowNationalityList.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 13/06/2022.
//

import Foundation
import SwiftUI

struct ShowNationalityList: View {
    @EnvironmentObject var patientCreatedVM : ViewModelCreatePatientProfile
    @EnvironmentObject var NationalityVM : ViewModelCountries
    @Binding var ShowNationality:Bool
    @Binding var bounds : CGRect
    @Binding var offset:CGSize
    
    var body: some View {
        ZStack {
            ChooseNationality( IsPresented: $ShowNationality, SelectedNationalityName: $patientCreatedVM.NationalityName, SelectedNationalityId: $patientCreatedVM.NationalityId, width: bounds.size.width)
                .environmentObject(NationalityVM)
            
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
                            ShowNationality.toggle()
                        }
                        self.offset = .zero
                    } else {
                        self.offset = .zero
                    }
                }
        )
    }
}

