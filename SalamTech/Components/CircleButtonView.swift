//
//  CircleButtonView.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 03/04/2022.
//

import SwiftUI

struct CircularButton : View {
    var ButtonImage : Image
    var forgroundColor : Color?
    var backgroundColor : Color?
    var Buttonwidth : CGFloat?
    var Buttonheight : CGFloat?
    
    var action: () -> Void
    
    
    var body: some View {
        Button(action: action) {
            ButtonImage.resizable().scaledToFit()
                .frame(width: Buttonwidth, height: Buttonheight)
            
        }
        
        .frame(width: Buttonheight! + 15, height: Buttonheight! + 15)
        .foregroundColor(forgroundColor)
        .background( backgroundColor)
        .clipShape(Circle())
        
    }
}
