//
//  ShowNationalityList.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 13/06/2022.
//

import Foundation
import SwiftUI

struct ShowNationalityList: View {
    @Binding var ShowNationality:Bool
    @Binding var SelectedNationalityName : String
    @Binding var SelectedNationalityId:Int
    
    var body: some View {
        GeometryReader { g in
            ZStack {
                ChooseNationality( IsPresented: $ShowNationality, SelectedNationalityName: $SelectedNationalityName, SelectedNationalityId: $SelectedNationalityId)
            }
            .transition(.move(edge: .bottom))
            .background(
                Color.black
                    .ignoresSafeArea()
                    .opacity(0.3)
                    .blur(radius: 0.5)
                    .disabled(ShowNationality)
            )

            .onTapGesture {
                ShowNationality = false
            }
        }
    }
}

struct ShowNationalityList_Previews: PreviewProvider {
    static var previews: some View {

        ShowNationalityList(ShowNationality: .constant(true),SelectedNationalityName: .constant(""),SelectedNationalityId: .constant(0))
        
    }
}
