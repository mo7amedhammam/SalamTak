//
//  ChangePasswordView.swift
//  SalamTech-DR
//
//  Created by Mostafa Morsy on 03/03/2022.
//

import SwiftUI

struct ChangePasswordView: View {
     var language = LocalizationService.shared.language
    @StateObject var UpdatePassVM = ViewModelUpdatePassword()
//    @Binding var userId: Int
    @FocusState private var isfocused : Bool
    @Environment(\.presentationMode) var presentationMode
    @State var isChangingInside = false

    var body: some View {
        ZStack {
            VStack{
                AppBarView(Title: "ChangePass_Screen_title".localized(language),withbackButton: !isChangingInside)
                    .navigationBarItems(leading: BackButtonView())
                    .navigationBarBackButtonHidden(true)
                ScrollView(showsIndicators: false) {
                VStack {
                  
                    Image("new-lock")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60, alignment: .center)
//                                .padding(.top, 30)
                    
                    Text("Please enter the new password\nand remember that it needs to be\ndifferent from the last one")
                        .font(.salamtakBold(of: 14))
                        .bold()
                        .foregroundColor(Color("blueColor"))
                        .multilineTextAlignment(.center)
                        .padding(.bottom,hasNotch ? 40:20)

                    VStack (spacing: 10){
                        
                        if isChangingInside {
                            SecureInputView( text: $UpdatePassVM.OldPassword, title: "ChangePass_Screen_enter_Current_pass".localized(language),placholdercolor: Color("blueColor"),backgroundColor: .clear,isBorderd: true)
                                .focused($isfocused)
                                .padding(.horizontal,40)
                                .autocapitalization(.none)
                                .textInputAutocapitalization(.never)

                        }
                            SecureInputView( text: $UpdatePassVM.password, title: "ChangePass_Screen_enter_pass".localized(language),placholdercolor: Color("blueColor"),backgroundColor: .clear,isBorderd: true)
                                .focused($isfocused)
                                .padding(.horizontal,40)
                                .autocapitalization(.none)
                                .textInputAutocapitalization(.never)
                            
                            SecureInputView( text: $UpdatePassVM.password1, title: "ChangePass_Screen_confirm_pass".localized(language),placholdercolor: Color("blueColor"),backgroundColor: .clear,isBorderd: true)
                                .focused($isfocused)
                                .padding(.horizontal,40)
                                .autocapitalization(.none)
                                .textInputAutocapitalization(.never)
                       
                        Text(UpdatePassVM.inlineErrorPassword)
                            .font(.salamtakBold(of: 14))
                            .foregroundColor(.red)
                        }

                    Spacer()
                        .frame(height: hasNotch ? 50:30)
                    }
//                        Spacer()
                    ButtonView(text: "ChangePass_Screen_confirm_pass_button".localized(language), backgroundColor:.clear,forgroundColor:Color("blueColor").opacity(0.5),fontSize: .salamtakBold(of: 18)){
                        if isChangingInside {
                            UpdatePassVM.isChangingInside = true
                        }
                        UpdatePassVM.startFetchUpdatePassword()
                    }.disabled( (isChangingInside && UpdatePassVM.OldPassword == "") || UpdatePassVM.password == "" || UpdatePassVM.password1 != UpdatePassVM.password  )
                        .background(
                            RoundedRectangle(cornerRadius: 25,style: .continuous)
                                .stroke((isChangingInside && UpdatePassVM.OldPassword == "") || UpdatePassVM.password == "" || UpdatePassVM.password1 != UpdatePassVM.password ? Color("blueColor").opacity(0.5):Color("blueColor"), lineWidth: 3)
                        )
                            .padding(.horizontal,80)
                }
            }

            // showing loading indicator
            ActivityIndicatorView(isPresented: $UpdatePassVM.isLoading)
            NavigationLink(destination:  ViewLogin(ispresented: .constant(false)),isActive: $UpdatePassVM.isUpdated, label: {
                })
                .onChange(of: UpdatePassVM.isUpdated, perform: {newval in
                    if newval == true{
                        Helper.logout()
                        Helper.userLogedIn(value: false)
                    }
                })
        }
        .navigationBarHidden(true)
        .padding(.top,hasNotch ? -20:-40)
        .keyboardSpace()
        .background(
            newBackImage(backgroundcolor: .white, imageName: .image2)
        )
        .ignoresSafeArea(.keyboard)
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
            .overlay(content: {
                if !isChangingInside{
                SupportCall()
                }
            })
//                .sheet(isPresented: $haveAccount ,onDismiss: {
//                    print("dismiss")
//                }, content: {ViewLogin(ispresented: $haveAccount)})
    
//        //phone verification
//            NavigationLink(destination: ViewLogin(ispresented: $haveAccount),isActive: $haveAccount, label: {
//            })

    // Alert with no internet connection
        .alert(isPresented: $UpdatePassVM.isAlert, content: {
            Alert(title: Text(UpdatePassVM.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                UpdatePassVM.isAlert = false
                }))
        })
    //phone verification
}
}
struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ChangePasswordView()
        }
    }
}
