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
    @Binding var quickSignup: Bool
    @FocusState private var isfocused : Bool
    @Environment(\.presentationMode) var presentationMode
    func editingChanged(_ value: String) {
        RegisterVM.phoneNumber = String(value.prefix(RegisterVM.characterLimit))
    }
    
    @State var ShowPopup = false
    @State var TermsAndConditions = false
    @State var Approve = false
    @State var cancel = false
    @State var GotoPhoneVerification = false

    var body: some View {
        ZStack {
            VStack{
                Spacer().frame(height:90)
                ScrollView(showsIndicators: false) {
//                    VStack {
                        Image("logo")
                            .resizable()
                            .frame(width: 150, height: 120, alignment: .center)
                        
                        VStack (spacing: 15){
                                InputTextField( text: $RegisterVM.fullName,title: "SignUp_Screen_enterfullName".localized(language))
                                    .keyboardType(.namePhonePad)
                                    .textInputAutocapitalization(.never)
                                    .focused($isfocused)
                                    .padding(.horizontal)
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
                            Text(RegisterVM.inlineErrorPassword)
                                .foregroundColor(.red)
                        }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                    }
                .keyboardSpace()
                    Spacer()
                ButtonView(text: "SignUp_Button".localized(language), backgroundColor: (RegisterVM.fullName != "" && RegisterVM.email != "" && RegisterVM.phoneNumber != "" && (( RegisterVM.password != "" && RegisterVM.password1 == RegisterVM.password ) || quickSignup == true) && RegisterVM.emailErrorMessage == "" && RegisterVM.phoneErrorMessage == "" && RegisterVM.nameErrorMessage == "") && (RegisterVM.isLoading == false) ? Color("mainColor") :  Color(uiColor: .lightGray)){
                        if RegisterVM.isRegistered{
                            ShowPopup = true
                        }else{
                        RegisterVM.startFetchUserRegisteration()
                        }
                    }
                .disabled( (RegisterVM.fullName == "" || RegisterVM.email == "" || RegisterVM.phoneNumber == "" || (( RegisterVM.password == "" || RegisterVM.password1 != RegisterVM.password  ) && quickSignup == false ) || RegisterVM.emailErrorMessage != "" || RegisterVM.phoneErrorMessage != "" || RegisterVM.nameErrorMessage != "") || (RegisterVM.isLoading == true))
                    
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
                                    presentationMode.wrappedValue.dismiss()
                                }else {
                                    self.haveAccount = true
                                }
                            }
                            
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(Color("mainColor"))
                        }
                    }
            }
            
            AppBarView(Title: "SignUp_Screen_title".localized(language))
            //                                .navigationBarItems(leading: BackButtonView())
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
         
            // showing loading indicator
            ActivityIndicatorView(isPresented: $RegisterVM.isLoading)
            
            //            phone verification
            NavigationLink(destination: ViewLogin(ispresented: $haveAccount, QuickLogin: .constant(false)),isActive: $haveAccount, label: {
            })
            
            //phone verification
            NavigationLink(destination: PhoneVerificationView().environmentObject(RegisterVM),isActive: $Approve, label: {
            })
        }.disabled(ShowPopup)
        .navigationViewStyle(StackNavigationViewStyle())
        .background(Color("CLVBG"))
        .ignoresSafeArea()
        .onTapGesture(perform: {
            hideKeyboard()
        })
        
        //Quick Login
        .onChange(of: RegisterVM.isRegistered ){newval in
            if newval==true{
                ShowPopup = true
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
        
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButtonView()
            }
        }
        // Alert with no internet connection
        .alert(isPresented: $RegisterVM.isAlert, content: {
            Alert(title: Text(RegisterVM.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                RegisterVM.isAlert = false
                }))
        })
        
        .popup(isPresented: $ShowPopup){
            BottomPopupView{
                ApproveTermsPopUp(showPopUp: $ShowPopup,letsgo:$Approve,Skip:$cancel,TermsAndConditions:$TermsAndConditions, action: {
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
                            Text("OK".localized(language))
                                .fontWeight(.semibold)
                                .font(.title3)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(.green)
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                    })
                }
            }
        })
        
    }
}


struct ViewSignUp_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ViewSignUp(ispresented: .constant(false), quickSignup: .constant(false))
        }
    }
}






