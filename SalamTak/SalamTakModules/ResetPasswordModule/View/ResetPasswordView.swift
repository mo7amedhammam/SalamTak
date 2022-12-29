//
//  ResetPasswordView.swift
//  SalamTech-DR
//
//  Created by Mohamed hammam on 03/03/2022.
//

import SwiftUI

struct ResetPasswordView: View {
    var language = LocalizationService.shared.language
    @ObservedObject var ResetVM = ViewModelResetPassword()
    @FocusState var isfocused : Bool
    @Environment(\.presentationMode) var presentationMode
    func editingChanged(_ value: String) {
        ResetVM.phoneNumber = String(value.prefix(ResetVM.characterLimit))
    }
    var body: some View {
        ZStack {
            VStack{
                ScrollView(showsIndicators: false) {
                    VStack {
                        AppBarView(Title: "New_Forget_Screen_title".localized(language),withbackButton: true)
                            .navigationBarItems(leading: BackButtonView())
                            .navigationBarBackButtonHidden(true)
                            .frame(height:80)
                        
                        Image("newLock")
                            .resizable()
                            .frame(width: 110, height: 110, alignment: .center)
//                            .padding(.top, 30)
                        
                        VStack (spacing:20){
                            Button(action: {
                                ResetVM.ResetMethod = 1
                                ResetVM.phoneNumber = ""
                                ResetVM.phoneErrorMessage = ""
                            }, label: {
                                HStack{
                                    Image(systemName:ResetVM.ResetMethod == 1 ? "circle.fill":"circle")
                                        .foregroundColor(Color("newWelcome"))

                                    Text("By_E-mail".localized(language))
                                    Spacer()
                                }
                                .padding(.horizontal)
                                    .foregroundColor(Color("blueColor"))
//                                    .opacity(ResetVM.ResetMethod == 1 ? 0.7:0.3))
                            })
                            
                            Button(action: {
                                ResetVM.ResetMethod = 2
                                ResetVM.email = ""
                                ResetVM.emailErrorMessage = ""

                            }, label: {
                                HStack{
                                    Image(systemName:ResetVM.ResetMethod == 2 ? "circle.fill":"circle")
                                        .foregroundColor(Color("newWelcome"))
                                    
                                    Text("By_Phone".localized(language))
                                    Spacer()
                                }
                                .padding(.horizontal)
                                    .foregroundColor(Color("blueColor"))
//                                                        .opacity(ResetVM.ResetMethod == 2 ? 0.7:0.3))
                            })
                            
//                            Spacer().frame(height: 10)
                            InputTextField( text: ResetVM.ResetMethod == 1 ? $ResetVM.email:$ResetVM.phoneNumber, errorMsg: "" ,title: ResetVM.ResetMethod == 1 ? "Reset_Screen_email".localized(language) : "Reset_Screen_phone".localized(language),titleColor: Color("blueColor"),backgroundColor: .clear,isBorderd: true)
                                .keyboardType( ResetVM.ResetMethod == 1 ? .emailAddress:.numberPad)
                                .textInputAutocapitalization(.never)
                                .focused($isfocused)
                                .onChange(of: ResetVM.phoneNumber,perform: editingChanged)
                            
                            if !ResetVM.emailErrorMessage.isEmpty || !ResetVM.phoneErrorMessage.isEmpty{
                                Text(ResetVM.ResetMethod == 1 ? ResetVM.emailErrorMessage:ResetVM.phoneErrorMessage)
                                    .font(.system(size: 13))
                                    .padding(.horizontal,20)
                                    .foregroundColor(.red)
                                    .frame(maxWidth:.infinity, alignment: .leading)
                            }
                            
                            Text("Now,\nYou will receive a verification code.")
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                        .padding(.horizontal)
                        Spacer().frame(height: 50)
                      
                    }
                    
                    Spacer()
                    ButtonView(text: ResetVM.ResetMethod == 1 ? "Reset_Screen_confirmEmail_Button".localized(language):"Reset_Screen_confirmPhone_Button".localized(language), backgroundColor: .clear,forgroundColor: ((ResetVM.email != "" && ResetVM.emailErrorMessage == "") || (ResetVM.phoneNumber != "" && ResetVM.phoneErrorMessage == "")) ? .white:Color("blueColor").opacity(0.5),fontSize: .salamtakBold(of: 20)){
                        ResetVM.startFetchResetPassword()
                    }
                    .disabled(
                        ((ResetVM.email == "" && ResetVM.phoneNumber == "" ) || (ResetVM.emailErrorMessage != "" || ResetVM.phoneErrorMessage != ""))||ResetVM.isLoading==true
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 25,style: .continuous)
                            .stroke(((ResetVM.email != "" && ResetVM.emailErrorMessage == "") || (ResetVM.phoneNumber != "" && ResetVM.phoneErrorMessage == "")) ? Color("blueColor"):Color("blueColor").opacity(0.5), lineWidth: 3)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 25,style: .continuous)
//                                    .fill(((ResetVM.email != "" && ResetVM.emailErrorMessage == "") || (ResetVM.phoneNumber != "" && ResetVM.phoneErrorMessage == "")) ? Color("blueColor"):Color.clear)
//                            )
                    )
                        .padding(.horizontal,80)
                }
            }
            
            // showing loading indicator
            ActivityIndicatorView(isPresented: $ResetVM.isLoading)
            
            //phone verification
            NavigationLink(destination: PhoneVerificationResetView(passedmodel: ResetVM),isActive: $ResetVM.isReset, label: {
            })
            
            SupportCall()
        }
        .environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
        .navigationViewStyle(StackNavigationViewStyle())
        .background(
            newBackImage(backgroundcolor: .white, imageName: .image1)
        )
        .navigationBarHidden(true)
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
        
        ZStack {
            ResetPasswordView()
        }
        .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
    }
}
