//
//  InputTxtFields.swift
//  SalamTak
//
//  Created by wecancity on 18/06/2022.
//

import Foundation
import SwiftUI

struct SecureInputView: View {
    
    @Binding var text: String
    @State var isSecured: Bool = true
    var title: String
    @State var placholdercolor : Color = .gray
    @State var backgroundColor : Color = .white
    @State var isBorderd : Bool = false
    var body: some View {
        ZStack(alignment: .trailing) {
            if isSecured {
                //   PasswordView(text: text, placeHolder: title)
                SecureField("", text: $text)
                    .autocapitalization(.none)
                    .font(.system(size: 13))
                    .padding(.horizontal, 12)
                    .disableAutocorrection(true)
                    .background(
                        backgroundColor
                    )
                    .foregroundColor(Color("blueColor"))
                    .cornerRadius(5)
                    .shadow(color: Color.gray.opacity(0.099), radius: 3)
            } else {
                TextField(title, text: $text)
                    .autocapitalization(.none)
                    .font(.system(size: 13))
                    .padding(.horizontal)
                    .disableAutocorrection(true)
                    .background(
                        backgroundColor
                    )
                    .foregroundColor(Color("blueColor"))
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
        .onChange(of: text, perform: {newval in
            if newval.count > 32{
                text = "\(newval.dropLast())"
            }else{
            let ArChars = "د ج ح خ ه ع غ ف ق ث ص ض ذ ط ك م ن ت ا ل ب ي س ش ظ ز و ة ى لا ر ؤ ء ئ ألأ ١ ٢ ٣ ٤ ٥ ٦ ٧ ٨ ٩ ٠ , ٫ "
            if ArChars.contains("\(newval.last ?? " ")"){
                text = "\(newval.dropLast())"
                print(newval)
            }else{
                text = "\(newval)"
                print(newval)
            }}
        })
        .frame( height: 40)
        .overlay(
            ZStack {
                HStack {
                    Text(title)
                        .font(.system(size: 15))
                        .foregroundColor(text.isEmpty && false ? .gray : placholdercolor)
                        .offset(x:5, y: text.isEmpty && false ? -10 : -30)
                        .scaleEffect(text.isEmpty || true ? 1 : 0.8, anchor: .leading)
               Spacer()
                }
                
                RoundedRectangle(cornerRadius: 25)
                    .stroke(isBorderd == true ? Color("blueColor"):Color.clear, lineWidth:isBorderd == true ? 1.5:0)
            }
               )
                .padding(.top,15)
                .padding(.bottom,1)
    }
}
struct SecureInputView_Previews: PreviewProvider {
    static var previews: some View {
        SecureInputView(text: .constant(""), title: "enter password",placholdercolor:.blue ,backgroundColor:.clear,isBorderd : true)
    }
}

struct InputTextField: View {
    @Binding var text: String
    var title : String
    @State var placholdercolor : Color = .gray
    @State var backgroundColor : Color = .white
    @State var isBorderd : Bool = false
    @State var textSize : Int = 13


    var body: some View {
        ZStack (alignment:.bottomLeading){
            
            Text(title)
                .font(.system(size: 15))
                .foregroundColor(text.isEmpty && false ? .gray : placholdercolor)
                .offset(x:5, y: text.isEmpty && false ? -10 : -40)
                .scaleEffect(text.isEmpty || true ? 1 : 0.8, anchor: .leading)
            
            TextField("",text:$text)
                .font(.system(size: CGFloat(textSize)))
                .frame( height: 40)
                .padding(.horizontal)
                .overlay(
                               RoundedRectangle(cornerRadius: 25)
                                .stroke(isBorderd == true ? Color("blueColor"):Color.clear, lineWidth:isBorderd == true ? 1.5:0)
                       )
                .autocapitalization(.none)
                .textInputAutocapitalization(.none)
        }
        .font(.system(size: 13))
        .padding(.top,15)
        .padding(.bottom,2)
        .padding(.horizontal,2)
        .disableAutocorrection(true)
        .background(
            backgroundColor
        )
        .foregroundColor(Color("blueColor"))
            .cornerRadius(5)
            .shadow(color: Color.black.opacity(0.099), radius: 3)
    }
}

struct InputTextField_Previews: PreviewProvider {
    static var previews: some View {
        InputTextField(text: .constant("mm"), title: "your name",backgroundColor: .clear,isBorderd: true)
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
