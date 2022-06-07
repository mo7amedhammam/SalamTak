//
//  ConfirmButton.swift
//  SalamTak
//
//  Created by wecancity on 07/06/2022.
//

import Foundation
import SwiftUI
import Combine

struct ConfirmButton: View {
    @EnvironmentObject var CreateAppointment:VMCreateAppointment
    var Doctor:Doc
    var body: some View {
        HStack{
            ZStack() {
                Text("\(String(Doctor.FeesFrom ?? 0.0))")                                .font(.system(size: 18))
                    .padding(.top,-20)
                
                Text("\n"+"EGP".localized(language))
                    .font(.system(size: 15))
                    .foregroundColor(.black.opacity(0.5))
                    .padding(.bottom,-20)
                
            }
            .padding(.leading)
            Button(action: {
                // Create patient appointment
                //                        CreateAppointment.isLoading = true
                DispatchQueue.main.async{
                    CreateAppointment.CreatePatientAppointment()
                }
            }, label: {
                HStack {
                    Text("Confirm".localized(language))
                        .fontWeight(.semibold)
                        .font(.title2)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color("blueColor"))
                .cornerRadius(12)
                .padding(.horizontal, 20)
            })
        }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
        
            .frame( height: 60)
            .padding(.horizontal)
            .padding(.bottom,20)
    }
}

