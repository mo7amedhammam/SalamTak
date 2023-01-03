//
//  ShowCityList.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 13/06/2022.
//

import Foundation
import SwiftUI

struct ShowCityList: View {
    @Binding var ShowCity:Bool
    @Binding var SelectedCountryId:Int
    @Binding var SelectedCityName : String
    @Binding var SelectedCityId:Int
    
    var body: some View {
        ZStack {
            // needs to handle get country by id
            ChooseCity(IsPresented: $ShowCity , SelectedCityName: $SelectedCityName , SelectedCityId: $SelectedCityId ,SelectedCountryId: $SelectedCountryId )
        }
        .background(
            Color.black
                .ignoresSafeArea()
                .opacity(0.3)
                .blur(radius: 0.5)
                .disabled(ShowCity)
        )
        .transition(.move(edge: .bottom))
    }
}


struct ShowCityList_Previews: PreviewProvider {
    static var previews: some View {

        ShowCityList(ShowCity: .constant(true),SelectedCountryId: .constant(0),SelectedCityName: .constant(""),SelectedCityId: .constant(0))
        
    }
}
