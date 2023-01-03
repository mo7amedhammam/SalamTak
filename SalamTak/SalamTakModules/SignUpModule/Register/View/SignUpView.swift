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
    @StateObject var RegisterVM = ViewModelRegister(limit: 11)
    @State var haveAccount = false
    
    @Binding var ispresented: Bool
//    @Binding var quickSignup: Bool
    @FocusState private var isfocused : Bool
    @Environment(\.presentationMode) var presentationMode
    
    func editingChanged(_ value: String) {
        RegisterVM.phoneNumber = String(value.prefix(RegisterVM.characterLimit))
    }
    
    @State var TermsAndConditions = false
    @State var Approve = false
    @State var cancel = false
    @State var GotoPhoneVerification = false
    @State var showPopUp = false

    var body: some View {
        ZStack{
            newBackImage(backgroundcolor: .white,imageName: .image2)

            VStack(spacing:0){
                AppBarView(Title: "SignUp_Screen_title".localized(language),backColor: .clear)
                    .navigationBarItems(leading: BackButtonView())
                    .navigationBarBackButtonHidden(true)
                    .frame(height:50)
//                    .padding(.top, hasNotch ? 10:-10)

                ScrollView(showsIndicators: false) {

                    VStack {
//                        Spacer().frame(height:80)

                        Image("newlogo")
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame( height: 80, alignment: .center)
                            .padding(.horizontal,70)
                            .background(Color.clear)
                            .foregroundColor(.black)
                            .padding(.top)
                        
                        VStack (spacing: 5){
                            Group{
                                InputTextField( text: $RegisterVM.fullName, errorMsg: $RegisterVM.nameErrorMessage,title: "SignUp_Screen_enterfullName".localized(language),titleColor: Color("blueColor"),backgroundColor: .clear,isBorderd: true)
                                    .keyboardType(.namePhonePad)
                                    .textInputAutocapitalization(.never)
                                    .focused($isfocused)
                                    .padding(.top)
                                    
//                                    .onChange(of: RegisterVM.fullName, perform: {newval in
//                                        if newval.last == " " && RegisterVM.fullName == "" {
//                                            RegisterVM.fullName = "\(newval.dropLast())"
//                                        } else if newval.contains("  "){
//                                            RegisterVM.fullName = newval.replacingOccurrences(of: "  ", with: " ")
//                                        }else{
//                                        let ArChars = "د ج ح خ ه ع غ ف ق ث ص ض ذ ط ك م ن ت ا ل ب ي س ش ظ ز و ة ى لا ر ؤ ء ئ ألأ ١ ٢ ٣ ٤ ٥ ٦ ٧ ٨ ٩ ٠ , ٫ + - * /=_)(&%$@!?"
//                                        if ArChars.contains("\(newval.last ?? " ")") && "\(newval.last ?? " ")" != " "{
//    //                                        vm.phoneNumber = newval
//                                            RegisterVM.fullName = "\(newval.dropLast())"
//
//                                            RegisterVM.nameErrorMessage = "english_text_only".localized(language)
//
//                                            print(newval)
//                                        }else{
//    //                                        vm.phoneNumber = "\(newval.dropLast())"
//                                            RegisterVM.nameErrorMessage = "".localized(language)
//                                            RegisterVM.fullName = "\(newval)"
//                                            print(newval)
//                                        }
//                                        }
//                                    })
                                
//                                if !RegisterVM.nameErrorMessage.isEmpty{
//                                    Text(RegisterVM.nameErrorMessage)
//                                        .font(.system(size: 13))
//                                        .padding(.horizontal,20)
//                                        .foregroundColor(.red)
//                                        .frame(maxWidth:.infinity, alignment: .leading)
//                                }
                            }
                            Group{
                                InputTextField( text: $RegisterVM.phoneNumber, MaxLength: 11 ,errorMsg: $RegisterVM.phoneErrorMessage,title: "SignUp_Screen_enterPhone".localized(language),titleColor: Color("blueColor"),backgroundColor: .clear,isBorderd: true)
                                    .keyboardType(.asciiCapableNumberPad)
                                .textInputAutocapitalization(.never)
                                .focused($isfocused)
//                                .onChange(of: RegisterVM.phoneNumber, perform: editingChanged)
                                
//                            if !RegisterVM.phoneErrorMessage.isEmpty{
//                                Text(RegisterVM.phoneErrorMessage)
//                                    .font(.system(size: 13))
//                                    .padding(.horizontal,20)
//                                    .foregroundColor(.red)
//                                    .frame(maxWidth:.infinity, alignment: .leading)
//                            }
                            }
                            Group{
                                InputTextField( text: $RegisterVM.email, errorMsg: $RegisterVM.emailErrorMessage,title: "SignUp_Screen_enterEmail".localized(language),titleColor: Color("blueColor"),backgroundColor: .clear,isBorderd: true)
                                    .keyboardType(.emailAddress)
                                    .textInputAutocapitalization(.never)
                                    .focused($isfocused)
//                                    .onChange(of: RegisterVM.email, perform: {newval in
//                                        if newval.last == " "{
//                                            RegisterVM.email = "\(newval.dropLast())"
//                                        }else{
//                                        let ArChars = "د ج ح خ ه ع غ ف ق ث ص ض ذ ط ك م ن ت ا ل ب ي س ش ظ ز و ة ى لا ر ؤ ء ئ ألأ ١ ٢ ٣ ٤ ٥ ٦ ٧ ٨ ٩ ٠ , ٫ "
//                                        if ArChars.contains("\(newval.last ?? " ")") {
//    //                                        vm.phoneNumber = newval
//                                            RegisterVM.email = "\(newval.dropLast())"
//                                            print(newval)
//                                        }else{
//    //                                        vm.phoneNumber = "\(newval.dropLast())"
//                                            RegisterVM.email = "\(newval)"
//                                            print(newval)
//                                        }
//                                        }
//                                    })
//                                if !RegisterVM.emailErrorMessage.isEmpty{
//                                    Text(RegisterVM.emailErrorMessage)
//                                        .font(.system(size: 13))
//                                        .padding(.horizontal,20)
//                                        .foregroundColor(.red)
//                                        .frame(maxWidth:.infinity, alignment: .leading)
//                                }
                            }
                            Group{
                                SecureInputView( text: $RegisterVM.password,MaxLength: 32,errorMsg: $RegisterVM.passwordErrorMessage,title: "SignUp_Screen_enterPassword".localized(language),placholdercolor: Color("blueColor"),backgroundColor: .clear,isBorderd: true)
                                    .focused($isfocused)
                                    .textInputAutocapitalization(.never)
                                
                                SecureInputView( text: $RegisterVM.password1,MaxLength: 32 ,errorMsg: $RegisterVM.confirmPasswordErrorMessage,title: "SignUp_Screen_enterconfirmPassword".localized(language),placholdercolor: Color("blueColor"),backgroundColor: .clear,isBorderd: true)
                                    .focused($isfocused)
                                    .textInputAutocapitalization(.never)
                            
                            
//                            if RegisterVM.inlineErrorPassword != ""{
//                            Text(RegisterVM.inlineErrorPassword)
//                                .foregroundColor(.red)
//                            }
                            }
                            Group{
                            HStack{
                                Image(systemName: RegisterVM.IsTermsAgreed ?  "checkmark.square.fill":"square")
                                    .font(.system(size: 17))
                                    .foregroundColor(Color("newWelcome"))
                                    .onTapGesture(perform: {
                                        RegisterVM.IsTermsAgreed.toggle()
                                    })
                                
                                Text("I_agree".localized(language))
                                    .font(.salamtakRegular(of: 15))

                                Button(action: {
                                    TermsAndConditions = true
                                    RegisterVM.termsErrorMessage = ""
                                }, label: {
                                    Text("Terms_&_Conditions".localized(language))
                                        .font(.salamtakRegular(of: 15))
                                        .underline()
                                        .foregroundColor(Color("newWelcome"))
                                })
                                Spacer()
                            }
                            .padding(language.rawValue == "en" ? .leading:.trailing)
                            if RegisterVM.termsErrorMessage != ""{
                            Text(RegisterVM.termsErrorMessage)
                                    .font(.salamtakRegular(of: 12))
                                .foregroundColor(.red)
                            }
                            }
                            .padding(.top,-5)
                            Spacer().frame(height:25)
                        }
                        .padding(.horizontal,30)
                    Spacer()
                        BorderedButton(text:  "New_SignUp_Button".localized(language),font: .salamtakBold(of: 18),isActive:
                                            $RegisterVM.formIsValid
//                                            .constant((RegisterVM.fullName != "" && RegisterVM.email != "" && RegisterVM.phoneNumber != "" && RegisterVM.password != "" && RegisterVM.password1 == RegisterVM.password && RegisterVM.emailErrorMessage == "" && RegisterVM.phoneErrorMessage == "" && RegisterVM.nameErrorMessage == "") && RegisterVM.IsTermsAgreed==true)
                        ){
                            if RegisterVM.IsTermsAgreed == false{
                                RegisterVM.termsErrorMessage = "You_must_approve_terms_&_conditions".localized(language)
                            }else{
                                RegisterVM.termsErrorMessage = ""
                                RegisterVM.startFetchUserRegisteration()
                            }
                        }
                        
//                        ButtonView(text: "New_SignUp_Button".localized(language),backgroundColor: .clear, forgroundColor: RegisterVM.fullName != "" && RegisterVM.email != "" && RegisterVM.phoneNumber != "" && RegisterVM.password != "" && RegisterVM.password1 == RegisterVM.password && RegisterVM.emailErrorMessage == "" && RegisterVM.phoneErrorMessage == "" && RegisterVM.nameErrorMessage == "" ? Color("blueColor"):Color("blueColor").opacity(0.5),fontSize:.salamtakBold(of: 18)){
//
//                        if RegisterVM.IsTermsAgreed == false{
//                            RegisterVM.termsErrorMessage = "You_must_approve_terms_&_conditions".localized(language)
//                        }else{
//                            RegisterVM.startFetchUserRegisteration()
//                        }
//                    }
//                    .disabled((RegisterVM.fullName == "" || RegisterVM.email == "" || RegisterVM.phoneNumber == "" || RegisterVM.password == "" || RegisterVM.password1 != RegisterVM.password  || RegisterVM.emailErrorMessage != "" || RegisterVM.phoneErrorMessage != "" || RegisterVM.nameErrorMessage != "") || RegisterVM.IsTermsAgreed == false)
//                    .overlay(
//                                   RoundedRectangle(cornerRadius: 25)
//                                    .stroke((RegisterVM.fullName != "" && RegisterVM.email != "" && RegisterVM.phoneNumber != "" && RegisterVM.password != "" && RegisterVM.password1 == RegisterVM.password && RegisterVM.emailErrorMessage == "" && RegisterVM.phoneErrorMessage == "" && RegisterVM.nameErrorMessage == "") && RegisterVM.IsTermsAgreed==true ? Color("blueColor"):Color("blueColor").opacity(0.5), lineWidth: 3)
//                           )
                    .padding(.horizontal,80)
//                    .padding(.top)
                    HStack (spacing: -10){
                        Text("SignUp_Screen_haveAccount".localized(language))
                            .padding()
                            .font(.system(size: 14))
                            .foregroundColor( Color("blueColor"))
                        Button("SignIn_Button".localized(language)) {
                            //  present sign in
                            if self.ispresented == true {
                                presentationMode.wrappedValue.dismiss()
                            }else {
                                self.haveAccount = true
                            }
                        }
                        .font(.system(size: 13, weight: .bold))
                        .foregroundColor(Color("darkGreen"))
                    }
//                    .padding(.bottom,25)
                        
                        
                        
                    }
                    .padding(.bottom,70)

//                    .ignoresSafeArea(.keyboard)
            
                
//                    SupportCall()
//                            .frame( height: 55)
                }
                }
            .padding(.top)
                .frame( height: UIScreen.main.bounds.height)

            
//                .padding(.top)
//                                    .padding(.bottom,50)

//                VStack{
//                    AppBarView(Title: "SignUp_Screen_title".localized(language),backColor: .clear)
//                        .navigationBarItems(leading: BackButtonView())
//                        .navigationBarBackButtonHidden(true)
//                    Spacer()
//                }
//                .padding(.top, hasNotch ? 0:30)
    //            .edgesIgnoringSafeArea(.top)
                
                // showing loading indicator
                ActivityIndicatorView(isPresented: $RegisterVM.isLoading)

//                SupportCall()
//                    .frame(height:55)
         
//            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)

//            .padding(.top,-80)
            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    //        .background(Color("CLVBG"))
            .toolbar{
                ToolbarItemGroup(placement: .keyboard ){
                    Spacer()
                    Button("Done"){
                        isfocused = false
                        hideKeyboard()
                    }
                }
            }
            
            .popup(isPresented: $showPopUp){
                BottomPopupView{
                    ApproveTermsPopUp(showPopUp: $showPopUp,letsgo:$Approve,Skip:$cancel,TermsAndConditions:$TermsAndConditions, action: {
                        RegisterVM.startFetchUserRegisteration()
                    }
                    )
                }
            }
            .sheet(isPresented: $TermsAndConditions , content: {
                ZStack {
                    SalamtakWebView(url: URL(string: URLs().TermsAndConditionsURL )!   , isPresented: $TermsAndConditions)
                    VStack {
                        Spacer()
                        Button(action: {
                            // add review
                            TermsAndConditions = false
                        }, label: {
                            HStack {
                                Text("Ok")
                                    .fontWeight(.semibold)
                                    .font(.title3)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(.green)
                            //                .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(12)
                            .padding(.horizontal, 20)
                        })
                    }
                    
                }
    //            .onAppear(perform: {
    //                print("url :: \(URLs().TermsAndConditionsURL)")
    //            })
    //                .onChange(of: URLs().TermsAndConditionsURL){newval in
    //                    print(newval)
    //                }
        })
            
        }
        .navigationBarHidden(true)
        .onTapGesture(perform: {
            hideKeyboard()
        })

//        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
        .overlay(content: {
            SupportCall()
                .padding(.bottom, hasNotch ? 6:10)
        })
        
        //phone verification
        NavigationLink(destination: ViewLogin(ispresented: $haveAccount),isActive: $haveAccount, label: {
        })
        
        //phone verification
        NavigationLink(destination: PhoneVerificationView()
                        .environmentObject(RegisterVM)
//                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true)
                       ,isActive: $RegisterVM.isRegistered, label: {
        })
        
        // Alert with no internet connection
            .alert(isPresented: $RegisterVM.isAlert, content: {
                Alert(title: Text(RegisterVM.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                    RegisterVM.isAlert = false
                }))
            })
    }
}


struct ViewSignUp_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ViewSignUp(ispresented: .constant(false))
        }
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro Max"))

        ZStack {
            ViewSignUp(ispresented: .constant(false))
        }
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))

    }
}






