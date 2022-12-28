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

