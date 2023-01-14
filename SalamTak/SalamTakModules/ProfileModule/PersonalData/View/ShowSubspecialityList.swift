//
//  ShowSubspecialityList.swift
//  SalamTak
//
//  Created by wecancity on 12/01/2023.
//

import SwiftUI

struct ShowSubspecialityList: View {
        @Binding var ShowSubspeciality:Bool
        @Binding var selectedspecialityId:Int
        @Binding var selectedSubspecialityName : [String]
        @Binding var selectedSubspecialityId:[Int]

        var body: some View {
            ZStack {
                ChooseSubSpeciality(IsPresented: $ShowSubspeciality, selectedSpecialityId: $selectedspecialityId, selectedSubSpecialityName: $selectedSubspecialityName, selectedSubSpecialityId: $selectedSubspecialityId)
            }
            .transition(.move(edge: .bottom))
            .background(
                Color.black
                    .ignoresSafeArea()
                    .opacity(0.3)
                    .blur(radius: 0.5)
                    .disabled(ShowSubspeciality)
            )
            .onTapGesture {
                ShowSubspeciality = false
            }
        }
    }


    struct ShowSubspecialityList_Previews: PreviewProvider {
        static var previews: some View {
            ShowSubspecialityList(ShowSubspeciality: .constant(true), selectedspecialityId: .constant(0),selectedSubspecialityName: .constant([]),selectedSubspecialityId: .constant([]))
        }
    }
