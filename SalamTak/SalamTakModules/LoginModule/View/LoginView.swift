//
//  ViewLogin.swift
//  Salamtech-Dr
//
//  Created by Mohamed Hammam on 27/12/2021.
//

import SwiftUI

struct ViewLogin: View {
    
    @StateObject private var LoginVM = ViewModelLogin(limit: 11)
    @State private var dontHaveAccount = false
    
    @State private var resetPassword = false
    var language = LocalizationService.shared.language
    
    @FocusState private var isfocused : Bool
    @Binding var ispresented: Bool
    @Binding var QuickLogin: Bool
    @Environment(\.presentationMode) var presentationMode
    func editingChanged(_ value: String) {
        LoginVM.phoneNumber = String(value.prefix(LoginVM.characterLimit))
    }
    
    var body: some View {
        ZStack {
                VStack {
                    Spacer().frame(height:80)
                    ScrollView {
                    Image("logo")
                        .resizable()
                        .frame(width: 150, height: 130)
                        .foregroundColor(.black)
                    
                        VStack {
                            InputTextField(text: $LoginVM.phoneNumber, title:"SignIn_Screen_phoneNumber".localized(language))
                                .focused($isfocused)
                                .keyboardType(.numberPad)
                                .onChange(of: LoginVM.phoneNumber, perform: editingChanged)

                            if !LoginVM.phoneErrorMessage.isEmpty{
                                Text(LoginVM.phoneErrorMessage)
                                    .font(.system(size: 13))
                                    .padding(.horizontal,20)
                                    .foregroundColor(.red)
                                    .frame(maxWidth:.infinity, alignment: .leading)
                            }
                            
                            SecureInputView("SignIn_Screen_password".localized(language), text: $LoginVM.password)
                                .autocapitalization(.none)
                                .textInputAutocapitalization(.never)
                                .focused($isfocused)
                       
                            if QuickLogin == false{
                                Button("SignIn_Screen_forgetPassword".localized(language), action: {
                                    self.resetPassword.toggle()

                                }).frame( height: 45)
                                    .foregroundColor(Color("darkGreen"))
                            }
                        }
                        .padding(.horizontal)

                    }
                    .keyboardSpace()
                    
                    Spacer()
                    ButtonView(text: "SignIn_Button".localized(language),backgroundColor:  (LoginVM.phoneNumber != "" && LoginVM.password != "" && LoginVM.phoneErrorMessage == "") && !(LoginVM.isLoading ?? false) ? Color("mainColor") :                                 Color(uiColor: .lightGray) , action: {
                        LoginVM.startLoginApi()
                    }).disabled(LoginVM.phoneNumber == "" || LoginVM.password == "" || LoginVM.phoneErrorMessage != "" || (LoginVM.isLoading ?? false))
                    
                    if QuickLogin == false{
                        HStack {
                            Text("SignIn_Screen_dont_haveAccount".localized(language)).foregroundColor(Color("subTitle"))
                            
                            Button("SignUp_Button".localized(language)) {
                                if self.ispresented == true{
                                    presentationMode.wrappedValue.dismiss()
                                }else {
                                    self.dontHaveAccount = true
                                }
                            }
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(Color("mainColor"))
                            
                        }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                    }
                    

                }.padding(.vertical)
                    .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                
            

            AppBarView(Title: "SignIn_Screen_title".localized(language))
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)

            
            // showing loading indicator
            ActivityIndicatorView(isPresented: $LoginVM.isLoading)
            
            
            // go to verify account to resset
            NavigationLink(destination: ViewSignUp(ispresented: $dontHaveAccount, quickSignup: .constant(false)),isActive: $dontHaveAccount) {
            }
            //         go to verify account to resset
            NavigationLink(destination: ResetPasswordView(),isActive: $resetPassword) {
            }
            // go to complete profile after login
            NavigationLink(destination: LoginVM.destination ,isActive: $LoginVM.isLogedin, label: {
            })
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .background(Color("CLVBG"))
        .ignoresSafeArea()
        .onTapGesture(perform: {
            hideKeyboard()
        })
        .toolbar{
            ToolbarItemGroup(placement: .keyboard ){
                Spacer()
                Button("Done"){
                    isfocused = false
                }
            }
        }
        
        //Quick Login
        .onChange(of: LoginVM.isLogedin){newval in
            if newval==true{
                self.QuickLogin=false
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButtonView()
            }
        }
        // Alert with no internet connection
            .alert(isPresented: $LoginVM.isAlert, content: {
                Alert(title: Text(LoginVM.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                    LoginVM.isAlert = false
                    }))
            })

        
    }
}

struct ViewLogin_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ViewLogin(ispresented: .constant(false), QuickLogin: .constant(false))
        }
    }
}

