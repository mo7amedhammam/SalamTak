//
//  SignUpView.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 31/03/2022.
//

import SwiftUI
import Combine

struct ViewSignUp: View {
    var language = LocalizationService.shared.language
    @ObservedObject private var RegisterVM = ViewModelRegister(limit: 11)
    @State private var haveAccount = false
    
    @Binding var ispresented: Bool
    @Binding var quickSignup: Bool
    @FocusState private var isfocused : Bool
    @Environment(\.presentationMode) var presentationMode
    func editingChanged(_ value: String) {
        RegisterVM.phoneNumber = String(value.prefix(RegisterVM.characterLimit))
       }

    var body: some View {
//        NavigationView {
            ZStack {
                    VStack{
                        ScrollView(showsIndicators: false) {
                        VStack {
                            AppBarView(Title: "SignUp_Screen_title".localized(language))
//                                .navigationBarItems(leading: BackButtonView())
                                .navigationBarHidden(true)
                                .navigationBarBackButtonHidden(true)
                            Image("logo")
                                    .resizable()
                                    .frame(width: 110, height: 110, alignment: .center)
                                    .padding(.top, 30)

                            VStack (spacing: 15){
                                if language.rawValue == "en" {
                                    InputTextField( text: $RegisterVM.fullName,title: "SignUp_Screen_enterfullName".localized(language))
                                        .keyboardType(.namePhonePad)
                                        .textInputAutocapitalization(.never)
                                        .focused($isfocused)
                                    if !RegisterVM.nameErrorMessage.isEmpty{
                                        Text(RegisterVM.nameErrorMessage)
                                            .font(.system(size: 13))
                                            .padding(.horizontal,20)
                                            .foregroundColor(.red)
                                            .frame(maxWidth:.infinity, alignment: .leading)
                                    }
                                    
                                    InputTextField( text: $RegisterVM.email,title: "SignUp_Screen_enterEmail".localized(language))
                                        .keyboardType(.emailAddress)
                                        .textInputAutocapitalization(.never)
                                        .focused($isfocused)
                                    if !RegisterVM.emailErrorMessage.isEmpty{
                                        Text(RegisterVM.emailErrorMessage)
                                            .font(.system(size: 13))
                                            .padding(.horizontal,20)
                                            .foregroundColor(.red)
                                            .frame(maxWidth:.infinity, alignment: .leading)
                                    }
                                    
                                    
                                    InputTextField( text: $RegisterVM.phoneNumber,title: "SignUp_Screen_enterPhone".localized(language))
                                        .keyboardType(.numberPad)
                                        .textInputAutocapitalization(.never)
                                        .focused($isfocused)
                                        .onChange(of: RegisterVM.phoneNumber, perform: editingChanged)
                                    if !RegisterVM.phoneErrorMessage.isEmpty{
                                        Text(RegisterVM.phoneErrorMessage)
                                            .font(.system(size: 13))
                                            .padding(.horizontal,20)
                                            .foregroundColor(.red)
                                            .frame(maxWidth:.infinity, alignment: .leading)
                                    }

                                    if quickSignup == false{
                                    SecureInputView("SignUp_Screen_enterPassword".localized(language), text: $RegisterVM.password)
                                        .focused($isfocused)
                                        .textInputAutocapitalization(.never)
                                    
                                    SecureInputView("SignUp_Screen_enterconfirmPassword".localized(language), text: $RegisterVM.password1)
                                        .focused($isfocused)
                                        .textInputAutocapitalization(.never)
                                    }
                                } else if language.rawValue == "ar" {
                                    
                                    InputTextFieldArabic( text: $RegisterVM.fullName,title: "SignUp_Screen_enterfullName".localized(language))
                                        .keyboardType(.namePhonePad)
                                        .textInputAutocapitalization(.never)
                                        .focused($isfocused)
                                    if !RegisterVM.nameErrorMessage.isEmpty{
                                        Text(RegisterVM.nameErrorMessage)
                                            .font(.system(size: 13))
                                            .padding(.horizontal,20)
                                            .foregroundColor(.red)
                                            .frame(maxWidth:.infinity, alignment: .leading)
                                    }
                                    
                                
                                    InputTextFieldArabic( text: $RegisterVM.email,title: "SignUp_Screen_enterEmail".localized(language))
                                        .keyboardType(.emailAddress)
                                        .textInputAutocapitalization(.never)
                                        .focused($isfocused)
                                    if !RegisterVM.emailErrorMessage.isEmpty{
                                        Text(RegisterVM.emailErrorMessage)
                                            .font(.system(size: 13))
                                            .padding(.horizontal,20)
                                            .foregroundColor(.red)
                                            .frame(maxWidth:.infinity, alignment: .leading)
                                    }
                                    
                                    
                                    InputTextFieldArabic( text: $RegisterVM.phoneNumber,title: "SignUp_Screen_enterPhone".localized(language))
                                        .keyboardType(.numberPad)
                                        .textInputAutocapitalization(.never)
                                        .focused($isfocused)
                                        .onChange(of: RegisterVM.phoneNumber, perform: editingChanged)
                                    if !RegisterVM.phoneErrorMessage.isEmpty{
                                        Text(RegisterVM.phoneErrorMessage)
                                            .font(.system(size: 13))
                                            .padding(.horizontal,20)
                                            .foregroundColor(.red)
                                            .frame(maxWidth:.infinity, alignment: .leading)
                                    }

                                    if quickSignup == false{
                                    SecureInputArabicView("SignUp_Screen_enterPassword".localized(language), text: $RegisterVM.password)
                                        .focused($isfocused)
                                        .textInputAutocapitalization(.never)
                                    
                                    SecureInputArabicView("SignUp_Screen_enterconfirmPassword".localized(language), text: $RegisterVM.password1)
                                        .focused($isfocused)
                                        .textInputAutocapitalization(.never)
                                    }
                                }
                               
                               
                                Text(RegisterVM.inlineErrorPassword)
                                    .foregroundColor(.red)
                                }
                            
                            
                            }
                            
                       

                            Spacer()
                            ButtonView(text: "SignUp_Button".localized(language), backgroundColor: RegisterVM.fullName != "" && RegisterVM.email != "" && RegisterVM.phoneNumber != "" && (( RegisterVM.password != "" && RegisterVM.password1 == RegisterVM.password ) || quickSignup == true) && RegisterVM.emailErrorMessage == "" && RegisterVM.phoneErrorMessage == "" && RegisterVM.nameErrorMessage == "" ? Color("mainColor") :  Color(uiColor: .lightGray)){
    //                            RegisterVM.isLoading = true
                                RegisterVM.startFetchUserRegisteration(fullname: RegisterVM.fullName, email: RegisterVM.email, phone: RegisterVM.phoneNumber, password: RegisterVM.password)
                            }.disabled( RegisterVM.fullName == "" || RegisterVM.email == "" || RegisterVM.phoneNumber == "" || (( RegisterVM.password == "" || RegisterVM.password1 != RegisterVM.password  ) && quickSignup == false ) || RegisterVM.emailErrorMessage != "" || RegisterVM.phoneErrorMessage != "" || RegisterVM.nameErrorMessage != "")
                        
                            if quickSignup == false{
                            HStack (spacing: -10){
                                Text("SignUp_Screen_haveAccount".localized(language))
                                    .padding()
                                    .font(.system(size: 14))
                                    .foregroundColor(.gray)
                                Button("SignIn_Button".localized(language)) {
                                    print ("sign in ")

                                    //  present sign in
                                    if self.ispresented == true {
                                        print ("sign in ")
    //                                    ispresented = false
                                        presentationMode.wrappedValue.dismiss()

                                    }else {
                                        self.haveAccount = true
                                }
                                }

                                .font(.system(size: 13, weight: .bold))
                                .foregroundColor(Color("mainColor"))
                            }
                            }
                            Spacer().frame(height:25)
                        }

                    }

                            
        //           Spacer()
                    // showing loading indicator
                    ActivityIndicatorView(isPresented: $RegisterVM.isLoading)
                    
                
                
                
            //            phone verification
                        NavigationLink(destination: ViewLogin(ispresented: $haveAccount, QuickLogin: .constant(false)),isActive: $haveAccount, label: {
                            })

            //phone verification
                NavigationLink(destination: PhoneVerificationView(passedmodel: RegisterVM),isActive: $RegisterVM.isRegistered, label: {
                })
                }
            .navigationViewStyle(StackNavigationViewStyle())

                .background(Color("CLVBG"))
            
                    .adaptsToKeyboard()
                    .ignoresSafeArea()
                    .onTapGesture(perform: {
                        hideKeyboard()
                    })
            
            //Quick Login
                    .onChange(of: RegisterVM.isRegistered ){newval in
                if newval==true{
                    self.quickSignup=false
                }
            }
                    .toolbar{
                        ToolbarItemGroup(placement: .keyboard ){
                            Spacer()
                            Button("Done"){
                                isfocused = false
                            }
                        }
                    }

    //                .sheet(isPresented: $haveAccount ,onDismiss: {
    //                    print("dismiss")
    //                }, content: {ViewLogin(ispresented: $haveAccount)})
            

               

                
                // Alert with no internet connection
                    .alert(isPresented: $RegisterVM.isNetworkError, content: {
                Alert(title: Text("Check Your Internet Connection"), message: nil, dismissButton: .cancel())
                })
            
                // Alert with Error message
                    .alert(RegisterVM.errorMsg, isPresented: $RegisterVM.isError) {
                                        Button("OK", role: .cancel) { }
                }
//        }
////        .navigationBarHidden(true)
//            .navigationBarBackButtonHidden(true)
         
            .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                          BackButtonView()
                        }
                    }

     
    }
    
       
    }


struct ViewSignUp_Previews: PreviewProvider {
    static var previews: some View {
        ViewSignUp(ispresented: .constant(false), quickSignup: .constant(false))
    }
}

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

struct SecureInputArabicView: View {
    
    @Binding private var text: String
    @State private var isSecured: Bool = true
    private var title: String
    let screenWidth = UIScreen.main.bounds.size.width - 50
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            if isSecured {
             //   PasswordView(text: text, placeHolder: title)
                SecureField(title, text: $text)
                    .autocapitalization(.none)
                    .multilineTextAlignment(.trailing)
                    .frame(width: screenWidth, height: 30)
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
                    .multilineTextAlignment(.trailing)
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
struct InputTextField1: View {
    @State var text: String
    var title : String
    let screenWidth = UIScreen.main.bounds.size.width - 50
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
struct InputTextField2: View {
    @Binding var text: String
    var title : String
    let screenWidth = UIScreen.main.bounds.size.width - 70
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
        .frame(width: 300, height: 30)
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
struct InputTextFieldArabic: View {
    @Binding var text: String
    var title : String
    let screenWidth = UIScreen.main.bounds.size.width - 50
    var body: some View {
        ZStack (alignment:.trailing){
            
                Text(title)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .offset(y: text.isEmpty ? 0 : -20)
                    .scaleEffect(text.isEmpty ? 1 : 0.8, anchor: .trailing)
            
            
            TextField("",text:$text)
                .autocapitalization(.none)
                .textInputAutocapitalization(.none)
                .multilineTextAlignment(.trailing)
     
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
struct EMRInputTextField: View {
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
//        .padding(12)
        .disableAutocorrection(true)
        .background(
            Color.white
        ).foregroundColor(Color("mainColor"))
            .cornerRadius(5)
            .shadow(color: Color.black.opacity(0.099), radius: 3)
        
    }
}
struct EMRInputTextField1: View {
    @State var text: String
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
//        .padding(12)
        .disableAutocorrection(true)
        .background(
            Color.white
        ).foregroundColor(Color("mainColor"))
            .cornerRadius(5)
            .shadow(color: Color.black.opacity(0.099), radius: 3)
        
    }
}

