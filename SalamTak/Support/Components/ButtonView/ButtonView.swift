//
//  ButtonView.swift
//  Salamtak-Dr
//
//  Created by wecancity agency on 12/26/21.
//

import SwiftUI

struct ButtonView: View {
    var text: String
    
    var backgroundColor: Color = Color("blueButton")
   @State var forgroundColor: Color = .white
    @State var fontSize: Font = Font.salamtakBold(of: 16)

    var action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            HStack {
                Spacer()
                Text(text)
                    .font(fontSize)
                    .foregroundColor(forgroundColor )

                Spacer()
            }
            .foregroundColor(forgroundColor )
            .padding(.vertical, 16)
            .frame( height: 53)
            .background(backgroundColor)
            .cornerRadius(4.0)
//            .buttonStyle(.bordered)
        })
    }}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(text: "SignUp",backgroundColor: Color("blueButton"), forgroundColor: .white ){}
    }
}

struct BorderedButton:View {
    var text: String
    @State var backgroundColor: Color = .salamtackBlue
    @State var forgroundColor: Color = .white
    @State var font: Font = Font.salamtakBold(of: 16)
    @Binding var isActive: Bool

    var action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            HStack {
                Spacer()
                Text(text)
                    .font(font)
                    .foregroundColor(isActive ? backgroundColor:backgroundColor.opacity(0.3) )

                Spacer()
            }
            .padding(.vertical, 16)
            .frame( height: 53)
            .foregroundColor(forgroundColor )
//            .background(backgroundColor)
            .cornerRadius(4.0)
        })
            .disabled(!isActive)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(isActive ? backgroundColor:backgroundColor.opacity(0.3) , lineWidth: 2)
            )
    }}

struct BorderedButton_Previews: PreviewProvider {
    static var previews: some View {
        BorderedButton(text: "SignUp",backgroundColor: Color("blueButton"), forgroundColor: .white ,isActive: .constant(false)){}
    }
}
