//
//  ViewLogin.swift
//  Salamtech-Dr
//
//  Created by wecancity on 27/12/2021.
//

import SwiftUI

struct ViewLogin: View {
//    @State private var phone : String = ""
//    @State private var password : String = ""
    
//    @ObservedObject private var apiService = ApiService()
//    @State private var reponse : Response?
//    @ObservedObject private var items: Response
//    @State private var response: Response?
   // let response =
//    private var language = LocalizationService.shared.language
    
    @StateObject private var LoginVM = ViewModelLogin(limit: 11)
       @State private var dontHaveAccount = false

       @State private var resetPassword = false
       @State private var isPressed = false
     var language = LocalizationService.shared.language
    
    @FocusState private var isfocused : Bool
   @Binding var ispresented: Bool
    @Binding var QuickLogin: Bool

    @Environment(\.presentationMode) var presentationMode
    func editingChanged(_ value: String) {
        LoginVM.phoneNumber = String(value.prefix(LoginVM.characterLimit))
       }

    var body: some View {
        
//        NavigationView{
            ZStack {
             
                VStack {
                    AppBarView(Title: "SignIn_Screen_title".localized(language))
//                        .navigationBarItems(leading: BackButtonView())
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true)
                    Spacer()

                    Image("logoWelcome")
                            .foregroundColor(.black)

                    if language.rawValue == "en" {
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
                    } else if language.rawValue == "ar" {
                        InputTextFieldArabic(text: $LoginVM.phoneNumber, title:"SignIn_Screen_phoneNumber".localized(language))
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

                        SecureInputArabicView("SignIn_Screen_password".localized(language), text: $LoginVM.password)
                            .autocapitalization(.none)
                            .textInputAutocapitalization(.never)
                            .focused($isfocused)
                    }
            
                    if QuickLogin == false{
                    Button("SignIn_Screen_forgetPassword".localized(language), action: {
                            print("password reset")
                            self.resetPassword.toggle()
                                // forget password action

                            
                        }).frame( height: 45)
                            .foregroundColor(Color("darkGreen"))
                    }
                        
                        
                        Spacer()
                    
                     
                    ButtonView(text: "SignIn_Button".localized(language),backgroundColor:  LoginVM.phoneNumber != "" && LoginVM.password != "" && LoginVM.phoneErrorMessage == "" ? Color("mainColor") :                                 Color(uiColor: .lightGray) , action: {
//                                               LoginVM.isLoading = true
                                               LoginVM.startLoginApi(phone: LoginVM.phoneNumber , password: LoginVM.password)

                    }).disabled(LoginVM.phoneNumber == "" || LoginVM.password == "" || LoginVM.phoneErrorMessage != "")

                    if QuickLogin == false{
                        HStack {
                            Text("SignIn_Screen_dont_haveAccount".localized(language)).foregroundColor(Color("subTitle"))
                            
                            Button("SignUp_Button".localized(language)) {
                                if self.ispresented == true{
//                                    ispresented = false
                                    presentationMode.wrappedValue.dismiss()
                                }else {
                                    self.dontHaveAccount = true
                            }
                            }
                            .font(.system(size: 13, weight: .bold))
                            .foregroundColor(Color("mainColor"))
                                
                        }
                        }
    
                    Spacer().frame(height:25)
                    }
                .adaptsToKeyboard()
                  
                // showing loading indicator
                ActivityIndicatorView(isPresented: $LoginVM.isLoading)
                
                Spacer()
                
                // go to verify account to resset
                  NavigationLink(destination: ViewSignUp(ispresented: $dontHaveAccount, quickSignup: .constant(false)),isActive: $dontHaveAccount) {
                                }
        //         go to verify account to resset
                NavigationLink(destination: ResetPasswordView(ispresented: .constant(false)),isActive: $resetPassword) {
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
   

            
            
            
//        }
//        .navigationBarHidden(true)
//            .navigationBarBackButtonHidden(true)

            .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                          BackButtonView()
                        }
                    }

            
        
//            .sheet(isPresented: $dontHaveAccount,onDismiss: {
//                print("dismiss")
//            }, content: {ViewSignUp(ispresented: $dontHaveAccount)})
        
      

        
        // alert with no ierror message
            .alert(LoginVM.errorMsg, isPresented: $LoginVM.isError) {
                                        Button("OK", role: .cancel) { }
                                    }
     
        // Alert with no internet connection
            .alert(isPresented: $LoginVM.isNetworkError, content: {
        Alert(title: Text("Check Your Internet Connection"), message: nil, dismissButton: .cancel())
        })
          
                        
                     

            }
    
    }
    
    


struct ViewLogin_Previews: PreviewProvider {
    static var previews: some View {
   
        ViewLogin(ispresented: .constant(false), QuickLogin: .constant(false))
       
    }
}

