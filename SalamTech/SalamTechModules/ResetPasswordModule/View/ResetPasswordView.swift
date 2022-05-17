//
//  ResetPasswordView.swift
//  SalamTech-DR
//
//  Created by Mostafa Morsy on 03/03/2022.
//

import SwiftUI

struct ResetPasswordView: View {
         var language = LocalizationService.shared.language
    //    @ObservedObject private var kGuardian = KeyboardGuardian(textFieldCount: 1)
        @ObservedObject private var ResetVM = ViewModelResetPassword()
        @State private var haveAccount = false
        
        @Binding var ispresented: Bool
        @FocusState private var isfocused : Bool
        @Environment(\.presentationMode) var presentationMode

        var body: some View {
                ZStack {
                    VStack{
                        ScrollView(showsIndicators: false) {
                        VStack {
                            AppBarView(Title: "Reset_Screen_title".localized(language))
                                .navigationBarItems(leading: BackButtonView())
                                .navigationBarBackButtonHidden(true)
                            Image("logo")
                                    .resizable()
                                    .frame(width: 110, height: 110, alignment: .center)
                                    .padding(.top, 30)

                            VStack (spacing: 15){
                                
                                if language.rawValue == "en"
                                {
                                    InputTextField( text: $ResetVM.email,title: "Reset_Screen_email".localized(language))
                                        .keyboardType(.emailAddress)
                                        .textInputAutocapitalization(.never)
                                        .focused($isfocused)
                                    if !ResetVM.emailErrorMessage.isEmpty{
                                        Text(ResetVM.emailErrorMessage)
                                            .font(.system(size: 13))
                                            .padding(.horizontal,20)
                                            .foregroundColor(.red)
                                            .frame(maxWidth:.infinity, alignment: .leading)
                                    }
                                    
                                } else if language.rawValue == "ar" {
                                    InputTextFieldArabic( text: $ResetVM.email,title: "Reset_Screen_email".localized(language))
                                        .keyboardType(.emailAddress)
                                        .textInputAutocapitalization(.never)
                                        .focused($isfocused)
                                    if !ResetVM.emailErrorMessage.isEmpty{
                                        Text(ResetVM.emailErrorMessage)
                                            .font(.system(size: 13))
                                            .padding(.horizontal,20)
                                            .foregroundColor(.red)
                                            .frame(maxWidth:.infinity, alignment: .leading)
                                    }
                                }
                                
                                
                                
                                
                               
                                }
                            Spacer().frame(height: 50)
                            
                            
                            }
                            
                       

                            Spacer()
                            ButtonView(text: "Reset_Screen_confirmEmail_Button".localized(language), backgroundColor:  ResetVM.email != "" &&  ResetVM.emailErrorMessage == ""  ? Color("blueColor") :  Color(uiColor: .lightGray)){
    //                            RegisterVM.isLoading = true
                                ResetVM.startFetchResetPassword( email: ResetVM.email)
                            }.disabled(  ResetVM.email == "" || ResetVM.emailErrorMessage != "" )
                        
//                            HStack (spacing: -10){
//                                Text("Already Have Account?")
//                                    .padding()
//                                    .font(.system(size: 14))
//                                    .foregroundColor(.gray)
//                                Button("Sign In") {
//                                    print ("sign in ")
//
//                                    //  present sign in
//                                    if self.ispresented == true {
//                                        print ("sign in ")
//    //                                    ispresented = false
//                                        presentationMode.wrappedValue.dismiss()
//
//                                    }else {
//                                        self.haveAccount = true
//                                }
//                                }
//
//                                .font(.system(size: 13, weight: .bold))
//                                .foregroundColor(Color("blueColor"))
//                            }.padding(.bottom,25)
                        
                        }

                    }

                            
        //           Spacer()
                    // showing loading indicator
                    ActivityIndicatorView(isPresented: $ResetVM.isLoading)
                    
                }
                .background(Color("CLVBG"))
            
                    .adaptsToKeyboard()
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

    //                .sheet(isPresented: $haveAccount ,onDismiss: {
    //                    print("dismiss")
    //                }, content: {ViewLogin(ispresented: $haveAccount)})
            
            //phone verification
            NavigationLink(destination: ViewLogin(ispresented: $haveAccount, QuickLogin: .constant(false)),isActive: $haveAccount, label: {
                })
               

                
                // Alert with no internet connection
                    .alert(isPresented: $ResetVM.isNetworkError, content: {
                Alert(title: Text("Check Your Internet Connection"), message: nil, dismissButton: .cancel())
                })
            
                // Alert with Error message
                    .alert(ResetVM.errorMsg, isPresented: $ResetVM.isError) {
                                        Button("OK", role: .cancel) { }
                }
                
                
            

            //phone verification
                NavigationLink(destination: PhoneVerificationResetView(passedmodel: ResetVM),isActive: $ResetVM.isRegistered, label: {
                })
        }
        
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordView(ispresented: .constant(false))
    }
}
