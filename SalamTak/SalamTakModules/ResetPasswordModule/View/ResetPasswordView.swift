//
//  ResetPasswordView.swift
//  SalamTech-DR
//
//  Created by Mostafa Morsy on 03/03/2022.
//

import SwiftUI

struct ResetPasswordView: View {
         var language = LocalizationService.shared.language
        @ObservedObject private var ResetVM = ViewModelResetPassword()
        @State private var haveAccount = false
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
                                    .frame(width: 150, height: 120, alignment: .center)

                            VStack (spacing: 15){

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
                                }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                            Spacer().frame(height: 50)
                            }
                            Spacer()
                            ButtonView(text: "Reset_Screen_confirmEmail_Button".localized(language), backgroundColor:  ResetVM.email != "" &&  ResetVM.emailErrorMessage == ""  ? Color("blueColor") :  Color(uiColor: .lightGray)){
                                ResetVM.startFetchResetPassword()
                            }.disabled(  ResetVM.email == "" || ResetVM.emailErrorMessage != "" )
                        }.keyboardSpace()
                    }
                    // showing loading indicator
                    ActivityIndicatorView(isPresented: $ResetVM.isLoading)
                    
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .background(Color("CLVBG"))
            
//                    .adaptsToKeyboard()
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
            
            //phone verification
            NavigationLink(destination: ViewLogin(ispresented: $haveAccount, QuickLogin: .constant(false)),isActive: $haveAccount, label: {
                })

            //phone verification
                NavigationLink(destination: PhoneVerificationResetView(passedmodel: ResetVM),isActive: $ResetVM.isReset, label: {
                })
            
            // Alert with no internet connection
                .alert(isPresented: $ResetVM.isAlert, content: {
                    Alert(title: Text(ResetVM.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                        ResetVM.isAlert = false
                        }))
                })

        }
}

struct ResetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ResetPasswordView()
        }
    }
}
