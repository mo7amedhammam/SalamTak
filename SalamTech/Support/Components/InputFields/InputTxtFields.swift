//
//  InputTxtFields.swift
//  SalamTak
//
//  Created by wecancity on 18/06/2022.
//

import Foundation
import SwiftUI

struct SecureInputView: View {
    
    @Binding private var text: String
    @State private var isSecured: Bool = true
    private var title: String
    let screenWidth = UIScreen.main.bounds.size.width - 50
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            if isSecured {
                //   PasswordView(text: text, placeHolder: title)
                SecureField(title, text: $text)
                    .autocapitalization(.none)
                    .frame(width: screenWidth, height: 30 , alignment: .trailing)
                    .font(.system(size: 13))
                    .padding(12)
                    .disableAutocorrection(true)
                    .background(
                        Color.white
                    ).foregroundColor(Color("mainColor"))
                    .cornerRadius(5)
                    .shadow(color: Color.gray.opacity(0.099), radius: 3)
            } else {
                TextField(title, text: $text)
                    .autocapitalization(.none)
                    .frame(width: screenWidth, height: 30)
                    .font(.system(size: 13))
                    .padding(12)
                    .disableAutocorrection(true)
                    .background(
                        Color.white
                    ).foregroundColor(Color("mainColor"))
                    .cornerRadius(5)
                    .shadow(color: Color.black.opacity(0.099), radius: 3)
                
            }
            Button(action: {
                isSecured.toggle()
            }) {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .accentColor(.gray)
                    .padding()
            }
        }
    }
}
struct SecureInputView_Previews: PreviewProvider {
    static var previews: some View {
        SecureInputView("", text: .constant(""))
        
    }
}




struct InputTextField: View {
    @Binding var text: String
    var title : String
    let screenWidth = UIScreen.main.bounds.size.width - 55
    var body: some View {
        ZStack (alignment:.leading){

            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
                .offset(y: text.isEmpty ? 0 : -20)
                .scaleEffect(text.isEmpty ? 1 : 0.8, anchor: .leading)

            TextField("",text:$text)
                .autocapitalization(.none)
                .textInputAutocapitalization(.none)

        }
        .frame(width: screenWidth, height: 30)
        .font(.system(size: 13))
        .padding(12)
        .disableAutocorrection(true)
        .background(
            Color.white
        ).foregroundColor(Color("mainColor"))
            .cornerRadius(5)
            .shadow(color: Color.black.opacity(0.099), radius: 3)

    }
}
struct InputTextField_Previews: PreviewProvider {
    static var previews: some View {
        InputTextField(text: .constant(""), title: "title")
        
    }
}



struct ExpandableTxtField: View {
    @Binding var text: String
    var title : String
    let screenWidth = UIScreen.main.bounds.size.width - 50
    var body: some View {
        ZStack (alignment:.leading){
            
            Text(title).padding(.leading,10)
                .font(.caption)
                .foregroundColor(.gray)
                .offset(y: text.isEmpty ? 0 : -20)
                .scaleEffect(text.isEmpty ? 1 : 0.8, anchor: .leading)
            
            TextField("",text:$text)
                .autocapitalization(.none)
                .textInputAutocapitalization(.none)
                .padding(12)
        }
        .frame( minHeight: 45 , maxHeight: .infinity)
        .font(.system(size: 13))
        .disableAutocorrection(true)
        .background(
            Color.white
        ).foregroundColor(Color("mainColor"))
            .cornerRadius(5)
            .shadow(color: Color.black.opacity(0.099), radius: 3)
    }
}
struct ExpandableTxtField_Previews: PreviewProvider {
    static var previews: some View {
        ExpandableTxtField(text: .constant(""), title: "expandable text field")
        
    }
}
