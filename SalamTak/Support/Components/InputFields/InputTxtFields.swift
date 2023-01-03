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
    var MaxLength : Int?
    @Binding var errorMsg: String
    @State var isSecured: Bool = true
    var title: String
    @State var placholdercolor : Color = .gray
    @State var backgroundColor : Color = .white
    @State var isBorderd : Bool = false
    var body: some View {
        VStack(spacing:0) {
            HStack {
                Text(title)
                    .font(.system(size: 15))
                    .foregroundColor(text.isEmpty && false ? .gray : placholdercolor)
//                    .offset(x:5, y: text.isEmpty && false ? -10 : -30)
                    .scaleEffect(text.isEmpty || true ? 1 : 0.8, anchor: .leading)
           Spacer()
            }

            ZStack(alignment: .trailing) {
                if isSecured {
                    //   PasswordView(text: text, placeHolder: title)
                    SecureField("", text: $text)
                        .textContentType(.password)
                        .onChange(of: text , perform: {newVal in
                            text = "\(newVal.prefix(MaxLength ?? 1000))"
                        })
                        .autocapitalization(.none)
                        .font(.salamtakRegular(of: 14))
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
                        .onChange(of: text , perform: {newVal in
                            text = "\(newVal.prefix(MaxLength ?? 1000))"
                        })
                        .autocapitalization(.none)
                        .font(.salamtakRegular(of: 14))
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
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(isBorderd == true ? Color("blueColor"):Color.clear, lineWidth:isBorderd == true ? 1.5:0)
                   )
//                    .padding(.top,15)
//                .padding(.bottom,1)
            
            
            
            if errorMsg != "" {
            HStack {
                Text(errorMsg )
                    .font(.salamtakRegular(of: 12))
                    .foregroundColor( .red)
    //                .offset(x:5, y: text.isEmpty && false ? -10 : -40)
                .scaleEffect(text.isEmpty || true ? 1 : 0.8, anchor: .leading)
                Spacer()
            }
            }
        }
        .padding(.horizontal, 2)
    }
}
struct SecureInputView_Previews: PreviewProvider {
    static var previews: some View {
        SecureInputView(text: .constant("123"), errorMsg: .constant("weak password"),title: "enter password",placholdercolor:.blue ,backgroundColor:.clear,isBorderd : true)
    }
}
enum inputTypes:Equatable{
    case normalinput, DropList(icon:String)
    
    func icone() -> String{
        switch self {
        case .normalinput:
            return ""
        case .DropList(icon: let image):
            return image
        }
    }
    
}

struct InputTextField: View {
    @Binding var text: String
    var MaxLength : Int?
    @State var iconName : inputTypes = .normalinput
    @State var iconSize : CGFloat = 15

    @State var textplacholder : String = ""
    @Binding var errorMsg: String
    var title : String
    @State var titleColor : Color = .salamtackBlue
    @State var backgroundColor : Color = .white
    @State var isBorderd : Bool = true
    @State var isactive : Bool = true
    @State var textSize : CGFloat = 15
    var Action: (() -> ())?

    var body: some View {
        VStack(spacing:0) {
            if title != ""{
            HStack {
                Text(title)
                    .font(.salamtakBold(of: 14))
                    .foregroundColor(text.isEmpty && false ? .gray : titleColor)
    //                .offset(x:5, y: text.isEmpty && false ? -10 : -40)
                .scaleEffect(text.isEmpty || true ? 1 : 0.8, anchor: .leading)
                Spacer()
            }
            }
            
            ZStack{
            if iconName == .normalinput{
                HStack {
                    TextField(textplacholder,text:$text)
                        .onChange(of: text , perform: {newVal in
                            text = "\(newVal.prefix(MaxLength ?? 1000))"
                        })
                        .font(.salamtakRegular(of:text=="" ? 12:textSize))
                        .frame( height: 40)
                        .padding(.horizontal)
                        .autocapitalization(.none)
                    .textInputAutocapitalization(.none)
                    .disabled(!isactive)
                    
                    if iconName.icone() != "" {
//                    HStack {
                        Spacer()
                        Image(iconName.icone())
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.salamtackBlue.opacity(0.8))
                            .frame(width: iconSize, height: iconSize)
                            
//                            .font(.system(size: 5))
//                    }
                            .padding(language.rawValue == "en" ? .trailing:.leading)
                    }
                }
            }else{
                Button(action: {Action?()}, label: {
                    HStack {
                        TextField(textplacholder,text:$text)
                            .font(.salamtakRegular(of:text=="" ? 12:textSize))
                            .frame( height: 40)
                            .padding(.horizontal)
                            .autocapitalization(.none)
                        .textInputAutocapitalization(.none)
                        .disabled(!isactive || iconName != .normalinput )
                        
                        if iconName.icone() != "" {
    //                    HStack {
                            Spacer()
                            Image(iconName.icone())
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(.salamtackBlue.opacity(0.8))
                                .frame(width: iconSize, height: iconSize)
                                
    //                            .font(.system(size: 5))
    //                    }
                                .padding(language.rawValue == "en" ? .trailing:.leading)
                        }
                    }

                })
            }
            }
            .disableAutocorrection(true)
            .foregroundColor(.salamtackBlue)
                .cornerRadius(25)
            .overlay(
                ZStack{
                RoundedRectangle(cornerRadius: 25)
                        .stroke(  isBorderd == true ? .salamtackBlue:Color.clear, lineWidth:isBorderd == true ? 1.5:0)
//                    if iconName.icone() != "" {
//                    HStack {
//                        Spacer()
//                        Image(iconName.icone())
//                            .resizable()
//                            .renderingMode(.template)
//                            .foregroundColor(.salamtackBlue)
//                            .font(.system(size: 5))
//                    }
//                    }
                    }
                   )
            
            if errorMsg != ""{
            HStack {
                Text(errorMsg )
                    .font(.salamtakRegular(of: 12))
                    .foregroundColor( .red)
    //                .offset(x:5, y: text.isEmpty && false ? -10 : -40)
                .scaleEffect(text.isEmpty || true ? 1 : 0.8, anchor: .leading)
                Spacer()
            }
            }
        }
        .padding(.horizontal,2)
    }
}

struct InputTextField_Previews: PreviewProvider {
    static var previews: some View {
        InputTextField(text: .constant("mm"),iconName: .DropList(icon: "newdown"), errorMsg: .constant("Error Message"), title: "your name",backgroundColor: .clear,isBorderd: true)
    }
}

struct ExpandableTxtField: View {
    @Binding var text: String
    var title : String
    let screenWidth = UIScreen.main.bounds.size.width - 50
    var body: some View {
        VStack {
            
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
}
struct ExpandableTxtField_Previews: PreviewProvider {
    static var previews: some View {
        ExpandableTxtField(text: .constant(""), title: "expandable text field")
        
    }
}



//MARK: --- Char number limit ----
struct TextFieldLimitModifer: ViewModifier {
    @Binding var value: String
    var length: Int

    func body(content: Content) -> some View {
        content
            .onReceive(value.publisher.collect()) {
                value = String($0.prefix(length))
            }
    }
}

extension View {
    func limitInputLength(value: Binding<String>, length: Int) -> some View {
        self.modifier(TextFieldLimitModifer(value: value, length: length))
    }
}

