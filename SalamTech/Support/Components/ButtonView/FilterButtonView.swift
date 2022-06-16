//
//  FilterButtonView.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 16/06/2022.
//

import Foundation
import SwiftUI

struct FilterButtonView: View {
    var imagename = ""
    var action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }, label: {
            Image(imagename)
                .renderingMode(.original)
                .foregroundColor(.white)
                .padding()
                .font(.system(size: 22, weight: .bold))
                .background(
                    Rectangle()
                        .fill(LinearGradient(gradient:Gradient(colors: [Color.gray, Color.gray ]),startPoint: .center,endPoint: .trailing)
                              
                             )
                        .frame(width: 40, height: 40)
                        .cornerRadius(15)
                        .opacity(0.3)
                        .shadow(color: .white, radius: 3, x: 2, y: 2)
                )
        })
    }
}
