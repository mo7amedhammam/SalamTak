//
//  GenericPopupContent.swift
//  SalamTak
//
//  Created by wecancity on 07/06/2022.
//

import Foundation
import SwiftUI

struct PopUpView <Content: View>: View {
    
    let content: Content
    var language : Language
    var IsPresented: Binding<Bool>
    
    init(  IsPresented:Binding<Bool>, @ViewBuilder content: () -> Content) {
        self.language = LocalizationService.shared.language
        self.IsPresented = IsPresented
        self.content = content()
    }
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                VStack {
                    Capsule()
                        .frame(width: 50, height: 4)
                        .foregroundColor(.gray)
                        .padding(.top ,10)
                        .padding(.bottom,20)
                    
                    VStack {
                        self.content
                    }
                    }.background(
                    RoundedRectangle(cornerRadius: 40.0)
                        .foregroundColor(.white)
                        .ignoresSafeArea()
                        .opacity(1.5)
                        .shadow(radius: 15)
                        .frame(width: UIScreen.main.bounds.width)
                )
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onTapGesture(perform: {
            IsPresented.wrappedValue.toggle()
            
        })
        
    }
}




