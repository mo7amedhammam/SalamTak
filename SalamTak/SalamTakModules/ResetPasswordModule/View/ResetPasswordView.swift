//
//  ResetPasswordView.swift
//  SalamTech-DR
//
//  Created by Mostafa Morsy on 03/03/2022.
//

import SwiftUI

struct ResetPasswordView: View {
    var language = LocalizationService.shared.language
    @StateObject private var ResetVM = ViewModelResetPassword(limit: 11)
//    @State var ResetMethodId = 2 // 1:by email, 2:by phone
    @FocusState private var isfocused : Bool
    @Environment(\.presentationMode) var presentationMode
    
    func editingChanged(_ value: String) {
        ResetVM.phoneNumber = String(value.prefix(ResetVM.characterLimit))
    }
    
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
 
                          
                           
                            
                            InputTextField( text: ResetVM.ResetMethod == 1 ? $ResetVM.email:$ResetVM.phoneNumber ,title: ResetVM.ResetMethod == 1 ? "Reset_Screen_email".localized(language) : "Reset_Screen_phone".localized(language))
                                .keyboardType( ResetVM.ResetMethod == 1 ? .emailAddress:.numberPad)
                                .textInputAutocapitalization(.never)
                                .focused($isfocused)
                                .onChange(of: ResetVM.phoneNumber,perform: editingChanged)
                                .overlay(
                                    HStack{
                                        Spacer()
                                        Menu(content: {
                                            Button("Reset By Email") {
                                                ResetVM.ResetMethod = 1
                                            }
                                            Button("Reset By Phone") {
                                                ResetVM.ResetMethod = 2
                                            }
                                        }, label: {
                                            Image(systemName: "chevron.down")
                                                .padding(.trailing)
                                        })
                                    }
                                )
                            
                            if !ResetVM.emailErrorMessage.isEmpty || !ResetVM.phoneErrorMessage.isEmpty{
                                Text(ResetVM.ResetMethod == 1 ? ResetVM.emailErrorMessage:ResetVM.phoneErrorMessage)
                                    .font(.system(size: 13))
                                    .padding(.horizontal,20)
                                    .foregroundColor(.red)
                                    .frame(maxWidth:.infinity, alignment: .leading)
                            }
                            
                        }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                        Spacer().frame(height: 50)
                    }
                    Spacer()
                    ButtonView(text: ResetVM.ResetMethod == 1 ? "Reset_Screen_confirmEmail_Button".localized(language):"Reset_Screen_confirmPhone_Button".localized(language), backgroundColor:  ((ResetVM.email != "" &&  ResetVM.emailErrorMessage == "")||(ResetVM.phoneNumber != "" &&  ResetVM.phoneErrorMessage == ""))&&ResetVM.isLoading==false  ? Color("blueColor") :  Color(uiColor: .lightGray)){
                        ResetVM.startFetchResetPassword()
                    }.disabled(  ((ResetVM.email == "" && ResetVM.emailErrorMessage == "") && (ResetVM.phoneNumber == "" && ResetVM.phoneErrorMessage == ""))||ResetVM.isLoading==true)
                }.keyboardSpace()
            }
            // showing loading indicator
            ActivityIndicatorView(isPresented: $ResetVM.isLoading)
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
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
        
        
        //phone verification
        NavigationLink(destination: PhoneVerificationResetView().environmentObject(ResetVM),isActive: $ResetVM.isReset, label: {
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
