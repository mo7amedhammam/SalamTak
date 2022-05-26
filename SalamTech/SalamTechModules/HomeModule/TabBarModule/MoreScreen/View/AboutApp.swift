//
//  File.swift
//  SalamTak
//
//  Created by wecancity on 26/05/2022.
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
//                    .frame(height: UIScreen.main.bounds.height)4
            }                    .padding([.vertical,.horizontal],20)

            
        }
        .navigationViewStyle(StackNavigationViewStyle())

//        .edgesIgnoringSafeArea(.all)
     
    }
}

struct AboutApp_Previews: PreviewProvider {
    static var previews: some View {
        AboutApp(isPresented: .constant(false))
    }
}
