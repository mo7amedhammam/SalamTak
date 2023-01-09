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
//    @Binding var QuickLogin: Bool
    @Environment(\.presentationMode) var presentationMode
//    @EnvironmentObject  var infoProfileVM : PatientInfoViewModel
//    @EnvironmentObject  var medicalProfileVM : PatientMedicalInfoViewModel
    @EnvironmentObject var environments:EnvironmentsVM

    var body: some View {
        ZStack {
            newBackImage(backgroundcolor: .white)
                    ScrollView(showsIndicators:false) {
                                VStack {
                                    AppBarView(Title: "SignIn_Screen_title".localized(language),backColor: .clear)
                                        .frame(height:50)
                                    Image("newlogo")
                                        .renderingMode(.original)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame( height: 100, alignment: .center)
                                        .padding(.horizontal,70)
                                        .background(Color.clear)
                                        .foregroundColor(.black)

                                    Spacer()
                                    Group{
                                        InputTextField(text: $LoginVM.phoneNumber,MaxLength: 11, errorMsg: $LoginVM.phoneErrorMessage, title:"SignIn_Screen_phoneNumber".localized(language),titleColor: Color("blueColor"),backgroundColor: .clear,isBorderd: true)
                                            .keyboardType(.asciiCapableNumberPad)

                                        SecureInputView( text: $LoginVM.password, errorMsg: $LoginVM.passwordErrorMessage,title: "SignIn_Screen_password".localized(language),placholdercolor: Color("blueColor"),backgroundColor: .clear,isBorderd: true)
                                            .autocapitalization(.none)
                                    }
                                    .focused($isfocused)
                                    .padding(.horizontal,40)
                                    .textInputAutocapitalization(.never)
                                    HStack {
                                        Spacer()
                                        Button("SignIn_Screen_forgetPassword".localized(language), action: {
                                            print("password reset")
                                            self.resetPassword.toggle()
                                        })
                                            .frame( height: 45)
                                            .foregroundColor(Color("blueColor"))
                                            .padding(.horizontal)
                                    }
                                    .padding(.horizontal)
                                    VStack{
                                        Spacer()
                                        
                                        BorderedButton(text: "SignIn_Button".localized(language),font: .salamtakBold(of: 20), isActive: $LoginVM.formIsValid){
                                            LoginVM.startLoginApi()
                                        }
                                        
                                        .padding(.horizontal,80)

                                    HStack {
                                        Text("SignIn_Screen_dont_haveAccount".localized(language))
                                            .font(.salamtakBold(of: 13))
                                            .foregroundColor(.salamtackBlue)

                                        Button("New_SignUp_Button".localized(language)) {
                                            if self.ispresented == true{
                                                presentationMode.wrappedValue.dismiss()
                                            }else {
                                                self.dontHaveAccount = true
                                            }
                                        }
                                        .font(.salamtakBold(of: 13))
                                        .foregroundColor(Color("darkGreen"))
                                    }
                                        
                                        Spacer()
                                }
  
                                    SupportCall()
                                    .frame( height: 55)

                            }
                                .frame( height: UIScreen.main.bounds.height-20)
                
        }
                        .frame( height: UIScreen.main.bounds.height-20)
                        .padding(.top)

                            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

                            .onTapGesture(perform: {
                                hideKeyboard()
                            })
                            .toolbar{
                                ToolbarItemGroup(placement: .keyboard ){
                                    Spacer()
                                    Button("Done".localized(language)){
                                        isfocused = false
                                    }
                                }
                            }
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true)
                    .navigationViewStyle(StackNavigationViewStyle())
                    .overlay(
                        ActivityIndicatorView(isPresented: $LoginVM.isLoading)
                    )

            // go to complete profile after login
            NavigationLink(destination: LoginVM.destination
                            .environmentObject(environments)
//                            .environmentObject(infoProfileVM)
//                            .environmentObject(medicalProfileVM)
                            .navigationBarHidden(true) ,isActive: $LoginVM.isLogedin, label: {
            })

        }
        .navigationBarHidden(true)
            // go to verify account to resset
                NavigationLink(destination: ViewSignUp(ispresented: $dontHaveAccount)
                                .environmentObject(environments)
//                                .environmentObject(infoProfileVM)
//                                .environmentObject(medicalProfileVM)
                               ,isActive: $dontHaveAccount) {
                }
                // go to verify account to resset
                NavigationLink(destination: ResetPasswordView(),isActive: $resetPassword) {
                }

                // Alert with no internet connection
                    .alert(isPresented: $LoginVM.isAlert, content: {
                        Alert(title: Text(LoginVM.message.localized(language)), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                            LoginVM.isAlert = false
                        }))
                    })
            }
}

struct ViewLogin_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ViewLogin(ispresented: .constant(false))
        }
    }
}


struct SupportCall: View {
    var language = LocalizationService.shared.language
    var body: some View {
        VStack{
            Spacer()
            HStack(spacing:20){
                Text("For_Support_call".localized(language))
                    .foregroundColor(.salamtackBlue)
                
                HStack{
                    Image("new-callIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:25)
                    
                    Text("17143")
                        .foregroundColor(.white)
                        .font(.system(size: 22))
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: 50, alignment: .center)
            .background(
                RoundedCornersShape(radius: 20, corners: [.topLeft,.topRight])
                    .fill(Color.salamtackWelcome)
                //                        .padding(.top, -5)
            )
        }
    }
}
struct SupportCall_Previews: PreviewProvider {
    static var previews: some View {
        SupportCall()
    }
}
