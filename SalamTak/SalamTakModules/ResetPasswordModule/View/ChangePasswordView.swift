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
    @Binding var userId: Int
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
                                SecureInputView("ChangePass_Screen_enter_pass".localized(language), text: $UpdatePassVM.password)
                                    .focused($isfocused)
                                    .textInputAutocapitalization(.never)
                                
                                SecureInputView("ChangePass_Screen_confirm_pass".localized(language), text: $UpdatePassVM.password1)
                                    .focused($isfocused)
                                    .textInputAutocapitalization(.never)
                           
                            Text(UpdatePassVM.inlineErrorPassword)
                                .font(Font.SalamtechFonts.Reg14)

                                .foregroundColor(.red)
                            }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                        Spacer().frame(height: 50)
                        }

                        Spacer()
                        ButtonView(text: "ChangePass_Screen_confirm_pass_button".localized(language), backgroundColor:  UpdatePassVM.password != "" && UpdatePassVM.password1 == UpdatePassVM.password ? Color("blueColor") :  Color(uiColor: .lightGray)){
                            UpdatePassVM.UserId = userId
                            UpdatePassVM.startFetchUpdatePassword()
                        }.disabled(  UpdatePassVM.password == "" || UpdatePassVM.password1 != UpdatePassVM.password  )
                    
                    }

                }
                // showing loading indicator
                ActivityIndicatorView(isPresented: $UpdatePassVM.isLoading)
                
            }
            .navigationViewStyle(StackNavigationViewStyle())
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

        //phone verification
        NavigationLink(destination: ViewLogin(ispresented: .constant(false), QuickLogin: .constant(false))  ,isActive: $UpdatePassVM.isUpdated, label: {
            })
        
    // Alert with no internet connection
        .alert(isPresented: $UpdatePassVM.isAlert, content: {
            Alert(title: Text(UpdatePassVM.message), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                UpdatePassVM.isAlert = false
                }))
        })


    }
}
struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ChangePasswordView( userId: .constant(0))
        }
    }
}
