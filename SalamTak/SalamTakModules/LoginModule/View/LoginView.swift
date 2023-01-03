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
    func editingChanged(_ value: String) {
        LoginVM.phoneNumber = String(value.prefix(LoginVM.characterLimit))
    }
    
    var body: some View {
        
        
        //        ScrollView{
        //            ZStack {
        //                VStack{
        //    //                Spacer()
        //                    Text("welcome")
        //
        //                    Spacer()
        //                    TextField(text: $LoginVM.phoneNumber, prompt: Text("phone num"), label: { } )
        //                        .modifier(DetailedInfoTitleModifier())
        //
        //                }
        //                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-30, alignment: .center)
        //            }
        //        }
        //        .navigationBarHidden(true)
                
//                NavigationView{
        ZStack {
            newBackImage(backgroundcolor: .white)

//            VStack(spacing:0) {

                    ScrollView(showsIndicators:false) {
                                VStack {
                                    AppBarView(Title: "SignIn_Screen_title".localized(language),backColor: .clear)
                //                        .offset( y:hasNotch ? 0 : -20)
                                        .frame(height:50)

                                    
                                    //                        .navigationBarItems(leading: BackButtonView())
                                    //                        .navigationBarBackButtonHidden(true)

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
                        
                //                    .background(Color.clear)
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
                //                    Spacer(minLength: 60)
    //                                Spacer()
                                    VStack{
                                        Spacer()
                                        
                                        BorderedButton(text: "SignIn_Button".localized(language), isActive: $LoginVM.formIsValid){
                                            LoginVM.startLoginApi()
                                        }
                                        
//                                        ButtonView(text: "SignIn_Button".localized(language),backgroundColor:                                .clear,forgroundColor:LoginVM.phoneNumber != "" && LoginVM.password != "" && LoginVM.phoneErrorMessage == "" ? Color("blueColor"):Color("blueColor").opacity(0.5),fontSize: .salamtakBold(of: 18) , action: {
//                                        LoginVM.startLoginApi()
//                                    })
//                                        .disabled(LoginVM.phoneNumber == "" || LoginVM.password == "" || LoginVM.phoneErrorMessage != "")
//                                        .overlay(
//                                                       RoundedRectangle(cornerRadius: 25)
//                                                           .stroke(LoginVM.phoneNumber != "" && LoginVM.password != "" && LoginVM.phoneErrorMessage == "" ? Color("blueColor"):Color("blueColor").opacity(0.5), lineWidth: 3)
//                                               )
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
    //                                Spacer()
            //                            .padding(.bottom,hasNotch ? 25:80)
    //                                Spacer()
    //                                    .frame(height:30)
    //                            }
    //                            .frame( height: UIScreen.main.bounds.height-20)

            //                    .adaptsToKeyboard()

                                // showing loading indicator
            //                    Spacer()
                                    SupportCall()
                                    .frame( height: 55)

                            }
            //            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-20)
                                .frame( height: UIScreen.main.bounds.height-20)
                
                
                
        }
                        .frame( height: UIScreen.main.bounds.height-20)
                        .padding(.top)

    //                        .overlay(content: {
    //                                SupportCall()
    //        //                            .padding(.bottom, hasNotch ? -1:95)
    //                        })
                            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                            //            .background(Color("CLVBG"))
            //                .ignoresSafeArea()
            //                .padding(.top, hasNotch ? 0:30)

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
    //                }
                        
                        .navigationBarHidden(true)
                        .navigationBarBackButtonHidden(true)
                    .navigationViewStyle(StackNavigationViewStyle())
                    .overlay(
                        ActivityIndicatorView(isPresented: $LoginVM.isLoading)
                    )
    //                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-20)
            //        .padding()
            //        .edgesIgnoringSafeArea(.top)
            //        .ignoresSafeArea(.keyboard)
    //                }
        }
//        .padding(.top)
        .navigationBarHidden(true)
        
                // go to verify account to resset
                NavigationLink(destination: ViewSignUp(ispresented: $dontHaveAccount),isActive: $dontHaveAccount) {
                }

                // go to verify account to resset
                NavigationLink(destination: ResetPasswordView(),isActive: $resetPassword) {
                }
                // go to complete profile after login
                NavigationLink(destination: LoginVM.destination.navigationBarHidden(true) ,isActive: $LoginVM.isLogedin, label: {
                })


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
                    .foregroundColor(Color("blueColor"))
                
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
                    .fill(Color("newWelcome"))
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
