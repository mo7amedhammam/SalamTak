//
//  quickLoginSheet.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 07/06/2022.
//

import Foundation
import SwiftUI
struct quickLoginSheet : View {
    
    var language = LocalizationService.shared.language
    @Binding var IsPresented: Bool
    @Binding var QuickLogin : Bool
    @Binding var QuickReservation : Bool
    
    var width: CGFloat
    
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
                        ButtonView(text:"Sign_in".localized(language), action: {
                            withAnimation(.easeIn(duration: 0.3)) {
                                IsPresented =  false
                                QuickLogin = true
                            }
                        })
                        
                        ButtonView(text: "Quick_Reservation".localized(language), backgroundColor: .white){
                            // action
                            IsPresented =  false
                            QuickReservation = true
                        }
                        .border(Color("mainColor"), width: 2)
                        .cornerRadius(4)
                        .padding(.bottom,10)
                        
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
        .frame(width: UIScreen.main.bounds.width)
        .background(
            Color.black.opacity(0.3)
                .blur(radius: 12)
        )
        .onTapGesture(perform: {
            IsPresented =  false
            
        })
        
    }
}

struct quickLoginSheet_Previews: PreviewProvider {
    static var previews: some View {
        quickLoginSheet(IsPresented: .constant(true), QuickLogin: .constant(false), QuickReservation: .constant(false), width: 333)
    }
}
