//
//  ButtonView.swift
//  SalamTech
//
//  Created by wecancity agency on 3/29/22.
//


import SwiftUI

struct ButtonView: View {
    var text: String
    var backgroundColor: Color = Color("mainColor")
    var action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            HStack {
                Spacer()
                Text(text)
                    .bold()
                    .font(.system(size: 16))
                
                Spacer()
            }
            .padding(.vertical, 16)
            .frame(width: 344, height: 53)
            .foregroundColor(backgroundColor == .white ? Color("mainColor") : .white)
            .background(backgroundColor)
            .cornerRadius(4.0)
//            .buttonStyle(.bordered)
        })
    }}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(text: "SignUp",backgroundColor: Color("blueButton") ){}
    }
}
