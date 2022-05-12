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
    @Environment(\.presentationMode) var presentationMode
    func editingChanged(_ value: String) {
        LoginVM.phoneNumber = String(value.prefix(LoginVM.characterLimit))
       }

    var body: some View {
        
        NavigationView{
            ZStack {
             
                VStack {
                    ZStack {
                        
                        AppBarView(Title: "SignIn_Screen_title".localized(language))
                        HStack{
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()

                            }, label: {
                            Image("chevron.down.circle.fill")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .frame(width: 25, height: 25)
                            })
Spacer()
                        }
                    }
//                        .navigationBarItems(leading: BackButtonView())
//                        .navigationBarBackButtonHidden(true)
                    Spacer()

                    Image("logoWelcome")
//                    VStack( spacing: 15){
////                        Text(response?.Message ?? "")
//                        Text(apiService.response?.Message ?? "")
//                        Text("\(apiService.response?.Data?.ReSendCounter ?? 0)")
//                        }
                            .foregroundColor(.black)
//                        TextFieldView(text: LoginVM.phoneNumber, placeHolder:" Enter your phone number").textInputAutocapitalization(.never)
//                            .keyboardType(.numberPad)
//
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
      
                    Button("SignIn_Screen_forgetPassword".localized(language), action: {
                            print("password reset")
                            self.resetPassword.toggle()
                                // forget password action

                            
                        }).frame( height: 45)
                            .foregroundColor(Color("darkGreen"))
                        Spacer()
                        
                     
                    ButtonView(text: "SignIn_Button".localized(language),backgroundColor:  LoginVM.phoneNumber != "" && LoginVM.password != "" && LoginVM.phoneErrorMessage == "" ? Color("mainColor") :                                 Color(uiColor: .lightGray) , action: {
//                                               LoginVM.isLoading = true
                                               LoginVM.startLoginApi(phone: LoginVM.phoneNumber , password: LoginVM.password)

                    }).disabled(LoginVM.phoneNumber == "" || LoginVM.password == "" || LoginVM.phoneErrorMessage != "")

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
                                
                        }.padding(.bottom,25)
                        
    
                    }
                .adaptsToKeyboard()
                  
                // showing loading indicator
                ActivityIndicatorView(isPresented: $LoginVM.isLoading)
                
                Spacer()
                }
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
                    self.ispresented=false
                }
            }
            
            
            
        }
        .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)

            
        
//            .sheet(isPresented: $dontHaveAccount,onDismiss: {
//                print("dismiss")
//            }, content: {ViewSignUp(ispresented: $dontHaveAccount)})
        
      // go to verify account to resset
                      NavigationLink(destination: ViewSignUp(ispresented: $dontHaveAccount),isActive: $dontHaveAccount) {
                      }

        
        // alert with no ierror message
            .alert(LoginVM.errorMsg, isPresented: $LoginVM.isError) {
                                        Button("OK", role: .cancel) { }
                                    }
     
        // Alert with no internet connection
            .alert(isPresented: $LoginVM.isNetworkError, content: {
        Alert(title: Text("Check Your Internet Connection"), message: nil, dismissButton: .cancel())
        })
        
      

          
//         go to verify account to resset
        NavigationLink(destination: ResetPasswordView(ispresented: .constant(false)),isActive: $resetPassword) {
                        }
        // go to complete profile after login
        NavigationLink(destination: LoginVM.destination ,isActive: $LoginVM.isLogedin, label: {
                        })
                        
                     

            }
    
    }
    
    


struct ViewLogin_Previews: PreviewProvider {
    static var previews: some View {
   
        ViewLogin(ispresented: .constant(false))
       
    }
}

