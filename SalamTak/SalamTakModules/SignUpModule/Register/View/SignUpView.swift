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
    
    @State var TermsAndConditions = false
    @State var Approve = false
    @State var cancel = false
    @State var GotoPhoneVerification = false
    @State var showPopUp = false
//    @EnvironmentObject  var infoProfileVM : PatientInfoViewModel
//    @EnvironmentObject  var medicalProfileVM : PatientMedicalInfoViewModel
    @EnvironmentObject var environments:EnvironmentsVM

    var body: some View {
        ZStack{
            newBackImage(backgroundcolor: .white,imageName: .image2)

            VStack(spacing:0){
                AppBarView(Title: "SignUp_Screen_title".localized(language),backColor: .clear)
                    .navigationBarItems(leading: BackButtonView())
                    .navigationBarBackButtonHidden(true)
                    .frame(height:50)
                ScrollView(showsIndicators: false) {
                    VStack {
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
                                    
                            }
                            Group{
                                InputTextField( text: $RegisterVM.phoneNumber, MaxLength: 11 ,errorMsg: $RegisterVM.phoneErrorMessage,title: "SignUp_Screen_enterPhone".localized(language),titleColor: Color("blueColor"),backgroundColor: .clear,isBorderd: true)
                                    .keyboardType(.asciiCapableNumberPad)
                                .textInputAutocapitalization(.never)
                                .focused($isfocused)
                            }
                            Group{
                                InputTextField( text: $RegisterVM.email, errorMsg: $RegisterVM.emailErrorMessage,title: "SignUp_Screen_enterEmail".localized(language),titleColor: Color("blueColor"),backgroundColor: .clear,isBorderd: true)
                                    .keyboardType(.emailAddress)
                                    .textInputAutocapitalization(.never)
                                    .focused($isfocused)
                            }
                            Group{
                                SecureInputView( text: $RegisterVM.password,MaxLength: 32,errorMsg: $RegisterVM.passwordErrorMessage,title: "SignUp_Screen_enterPassword".localized(language),placholdercolor: Color("blueColor"),backgroundColor: .clear,isBorderd: true)
                                    .focused($isfocused)
                                    .textInputAutocapitalization(.never)
                                
                                SecureInputView( text: $RegisterVM.password1,MaxLength: 32 ,errorMsg: $RegisterVM.confirmPasswordErrorMessage,title: "SignUp_Screen_enterconfirmPassword".localized(language),placholdercolor: Color("blueColor"),backgroundColor: .clear,isBorderd: true)
                                    .focused($isfocused)
                                    .textInputAutocapitalization(.never)
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
                        BorderedButton(text:  "New_SignUp_Button".localized(language),font: .salamtakBold(of: 20),isActive:
                                            $RegisterVM.formIsValid
                        ){
                            if RegisterVM.IsTermsAgreed == false{
                                RegisterVM.termsErrorMessage = "You_must_approve_terms_&_conditions".localized(language)
                            }else{
                                RegisterVM.termsErrorMessage = ""
                                RegisterVM.startFetchUserRegisteration()
                            }
                        }
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
                    }
                    .padding(.bottom,70)
                }
                }
            .padding(.top)
                .frame( height: UIScreen.main.bounds.height)
                
                // showing loading indicator
                ActivityIndicatorView(isPresented: $RegisterVM.isLoading)
            .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
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

        .overlay(content: {
            SupportCall()
                .padding(.bottom, hasNotch ? 6:10)
        })
        
        //phone verification
        NavigationLink(destination: ViewLogin(ispresented: $haveAccount)
                        .environmentObject(environments)
                       ,isActive: $haveAccount, label: {
        })
        
        //phone verification
        NavigationLink(destination: PhoneVerificationView()
                        .environmentObject(RegisterVM)
                        .environmentObject(environments)
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






