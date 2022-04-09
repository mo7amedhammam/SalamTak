//
//  ChangePasswordView.swift
//  SalamTech-DR
//
//  Created by Mostafa Morsy on 03/03/2022.
//

import SwiftUI

struct ChangePasswordView: View {
    var language = LocalizationService.shared.language
    @StateObject private var UpdatePassVM = ViewModelUpdatePassword()
    @State private var haveAccount = false
    @Binding var userId: Int
    @Binding var ispresented: Bool
    @FocusState private var isfocused : Bool
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
            ZStack {
                VStack{
                    ScrollView(showsIndicators: false) {
                    VStack {
                        AppBarView(Title: "ChangePass_Screen_title".localized(language))
                            .navigationBarItems(leading: BackButtonView())
                            .navigationBarBackButtonHidden(true)
                        Image("logo")
                                .resizable()
                                .frame(width: 110, height: 110, alignment: .center)
                                .padding(.top, 30)

                        VStack (spacing: 15){
                            if language.rawValue == "en" {
                                SecureInputView("ChangePass_Screen_enter_pass".localized(language), text: $UpdatePassVM.password)
                                    .focused($isfocused)
                                    .textInputAutocapitalization(.never)
                                
                                SecureInputView("ChangePass_Screen_confirm_pass".localized(language), text: $UpdatePassVM.password1)
                                    .focused($isfocused)
                                    .textInputAutocapitalization(.never)
                            } else if language.rawValue == "ar" {
                                SecureInputArabicView("ChangePass_Screen_enter_pass".localized(language), text: $UpdatePassVM.password)
                                    .focused($isfocused)
                                    .textInputAutocapitalization(.never)
                                
                                SecureInputArabicView("ChangePass_Screen_enter_pass".localized(language), text: $UpdatePassVM.password1)
                                    .focused($isfocused)
                                    .textInputAutocapitalization(.never)
                            }
                           
                          
                           
                            Text(UpdatePassVM.inlineErrorPassword)
                                .font(Font.SalamtechFonts.Reg14)

                                .foregroundColor(.red)
                            }
                        Spacer().frame(height: 50)
                        
                        
                        }
                        
                   

                        Spacer()
                        ButtonView(text: "ChangePass_Screen_confirm_pass_button".localized(language), backgroundColor:  UpdatePassVM.password != "" && UpdatePassVM.password1 == UpdatePassVM.password ? Color("blueColor") :  Color(uiColor: .lightGray)){
//                            RegisterVM.isLoading = true
                            UpdatePassVM.startFetchUpdatePassword(userId: userId, password: UpdatePassVM.password)
                        }.disabled(  UpdatePassVM.password == "" || UpdatePassVM.password1 != UpdatePassVM.password  )
                    
//                        HStack (spacing: -10){
//                            Text("Already Have Account?")
//                                .padding()
//                                .font(.system(size: 14))
//                                .foregroundColor(.gray)
//                            Button("Sign In") {
//                                print ("sign in ")
//
//                                //  present sign in
//                                if self.ispresented == true {
//                                    print ("sign in ")
////                                    ispresented = false
//                                    presentationMode.wrappedValue.dismiss()
//
//                                }else {
//                                    self.haveAccount = true
//                            }
//                            }
//
//                            .font(.system(size: 13, weight: .bold))
//                            .foregroundColor(Color("blueColor"))
//                        }.padding(.bottom,25)
                    
                    }

                }

                        
    //           Spacer()
                // showing loading indicator
                ActivityIndicatorView(isPresented: $UpdatePassVM.isLoading)
                
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
        
//        //phone verification
//            NavigationLink(destination: ViewLogin(ispresented: $haveAccount),isActive: $haveAccount, label: {
//            })
//

            
            // Alert with no internet connection
                .alert(isPresented: $UpdatePassVM.isNetworkError, content: {
            Alert(title: Text("Check Your Internet Connection"), message: nil, dismissButton: .cancel())
            })
        
            // Alert with Error message
                .alert(UpdatePassVM.errorMsg, isPresented: $UpdatePassVM.isError) {
                                    Button("OK", role: .cancel) { }
            }
            
            
        

        //phone verification
            NavigationLink(destination:  TabBarView(),isActive: $UpdatePassVM.isRegistered, label: {
            })
    }
    
       
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView(userId: .constant(0),ispresented: .constant(false))
    }
}
