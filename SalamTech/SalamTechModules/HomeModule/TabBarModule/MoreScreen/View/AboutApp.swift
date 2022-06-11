//
//  AboutApp.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 26/05/2022.
//

import Foundation
import SwiftUI

struct AboutApp: View {
    @Binding var isPresented:Bool
    
    @AppStorage("language")
    var language = LocalizationService.shared.language
    var abouttext = "about_app"

    var body: some View {
        ZStack{
            ScrollView{
                Text(abouttext.localized(language))
                    .foregroundColor(Color("blueColor"))                    .multilineTextAlignment(.center)
            }
            .padding([.vertical,.horizontal],20)
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
     
    }
}

struct AboutApp_Previews: PreviewProvider {
    static var previews: some View {
        AboutApp(isPresented: .constant(false))
    }
}
