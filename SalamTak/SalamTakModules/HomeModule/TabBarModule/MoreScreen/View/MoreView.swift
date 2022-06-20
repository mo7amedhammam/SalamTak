//
//  MoreView.swift
//  SalamTech-DR
//
//  Created by Mostafa Morsy on 24/02/2022.
//
import SwiftUI

struct MoreView: View {
    @State var islogout:Bool = false
    @State var goToLogin:Bool = false
    
    @State var goingToPatientUpdate = false
    @State var goingToResetPassword = false
    @State var aboutApp = false
    @State var TermsAndConditions = false

    @StateObject  var patientCreatedVM = ViewModelCreatePatientProfile()

    @AppStorage("language")
    var language = LocalizationService.shared.language

    var body: some View {
        NavigationView {
            VStack{
                ZStack{
                    AppBarView(Title:"")
                    ZStack (alignment: .bottom){
                        Spacer().frame( height: 100)
                        Button(action: {
                            // here if you want to preview image
                        }, label: {
                            AsyncImage(url: URL(string:  Helper.getUserimage())) { image in
                                image.resizable()
                            } placeholder: {
                                Color("lightGray").opacity(0.2)
                            }
                        })
                            .clipShape(Rectangle())
                            .frame(width: 66, height: 66, alignment: .center)
                            .cornerRadius(10)
                            .padding(.top)
                    }
                }
                Spacer().frame( height: 30)
                    Text("More_Screen_updateProfile".localized(language))
                        .foregroundColor(Color("lightGray"))
                        .font(Font.SalamtechFonts.Reg16)
                
                ScrollView( showsIndicators: false){
                    VStack(alignment: .leading){
                        Group{
                        Button(action: {
                            self.goingToPatientUpdate.toggle()
                        }, label: {
                            HStack(spacing: 10){
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .foregroundColor(Color("darkGreen"))
                                    .frame(width: 30, height: 30)
                                
                                Text("More_Screen_myprofile".localized(language))
                                    .font(Font.SalamtechFonts.Reg16)
                                    .foregroundColor(Color("lightGray"))
                                Spacer()
                            }
                        })

                        Button(action: {
                            self.goingToResetPassword.toggle()
                        }, label: {
                            HStack(spacing: 10){
                                Image(systemName: "lock.shield")
                                    .resizable()
                                    .foregroundColor(Color("darkGreen"))
                                    .frame(width: 30, height: 30)
                               
                                Text("More_Screen_resetPassword".localized(language))
                                    .font(Font.SalamtechFonts.Reg16)
                                    .foregroundColor(Color("lightGray"))
                                Spacer()
                                
                            }
                        })
                        Button(action: {
                            aboutApp = true
                        }, label: {
                            HStack(spacing: 10){
                                Image(systemName: "info.circle")
                                    .resizable()
                                    .foregroundColor(Color("darkGreen"))
                                    .frame(width: 30, height: 30)
                                
                                Text("More_Screen_aboutApp".localized(language))
                                    .font(Font.SalamtechFonts.Reg16)
                                    .foregroundColor(Color("lightGray"))
                                Spacer()
                                
                            }
                        })
                        
                        Button(action: {
                            TermsAndConditions = true
                        }, label: {
                            HStack(spacing: 10){
                                Image(systemName: "doc.circle")
                                    .resizable()
                                    .foregroundColor(Color("darkGreen"))
                                    .frame(width: 30, height: 30)
                                
                                Text("More_Screen_termsAndCondition".localized(language))
                                    .font(Font.SalamtechFonts.Reg16)
                                    .foregroundColor(Color("lightGray"))
                                Spacer()
                            }
                        })
                        Button(action: {
                            Helper.MakePhoneCall(PhoneNumber: "0221256299")
                        }, label: {
                            HStack(spacing: 10){
                                Image(systemName: "phone.circle")
                                    .resizable()
                                    .foregroundColor(Color("darkGreen"))
                                    .frame(width: 30, height: 30)
                                
                                Text("More_Screen_callUs".localized(language))
                                    .font(Font.SalamtechFonts.Reg16)
                                    .foregroundColor(Color("lightGray"))
                                Spacer()
                            }
                        })
                        VStack{
                            HStack(spacing: 10){
                                Image(systemName: "network")
                                    .resizable()
                                    .foregroundColor(Color("darkGreen"))
                                    .frame(width: 30, height: 30)
                                
                                Text("More_Screen_Language".localized(language))
                                    .font(Font.SalamtechFonts.Reg16)
                                    .foregroundColor(Color("lightGray"))
                                Spacer()
                                
                            }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                           
                            HStack{
                            LanguageView(selection: $patientCreatedVM.GenderId)
                                    
                            }
                        }
                        Button(action: {
                            if Helper.userExist(){
                            Helper.logout()
                                islogout = true
                            }else{
                                goToLogin = true
                            }
                        }, label: {
                            HStack(spacing: 10){
                                Image(systemName: "arrow.left.square.fill")
                                    .resizable()
                                    .foregroundColor(Color("darkGreen"))
                                    .frame(width: 30, height: 30)
                                
                                Text( Helper.userExist() ? "More_Screen_SignOut".localized(language):"SignIn_Button".localized(language))
                                    .font(Font.SalamtechFonts.Reg16)

                                    .foregroundColor(Color("lightGray"))
                                Spacer()
                                
                            }
                        })
                    }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                        .font(.system(size: 13))
                        .padding(12)
                        .disableAutocorrection(true)
                        .background(
                            Color.white
                        ).foregroundColor(Color("blueColor"))
                            .cornerRadius(5)
                            .shadow(color: Color.black.opacity(0.099), radius: 3)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                }
                .padding(.bottom,20)
            }
            .edgesIgnoringSafeArea(.vertical)
            .background(Color("CLVBG"))
           
        }
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())

        NavigationLink(destination: PatientProfile(),isActive:$goingToPatientUpdate , label: {
        })
        NavigationLink(destination: ResetPasswordView(),isActive:$goingToResetPassword , label: {
        })

        NavigationLink(destination: WelcomeScreenView().navigationBarBackButtonHidden(true),isActive:$goToLogin , label: {
        })

            .sheet(isPresented: $aboutApp, content: {
                AboutApp(isPresented: $aboutApp)
            })
        
            .sheet(isPresented: $TermsAndConditions , content: {
                ZStack{
                SalamtakWebView(url: URL(string: URLs().TermsAndConditionsURL )!   , isPresented: $TermsAndConditions)
                    VStack {
                        Spacer()
                        Button(action: {
                            // add review
                            TermsAndConditions = false
                        }, label: {
                            HStack {
                                Text("Ok".localized(language))
                                    .fontWeight(.semibold)
                                    .font(.title3)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(.green)
                            .cornerRadius(12)
                            .padding(.horizontal, 20)
                        })
                    }
                }
                    
            })

        
            .alert(isPresented: $islogout, content: {
                Alert(title: Text("you_signed_out".localized(language)), message: nil, dismissButton: Alert.Button.default(Text("OK".localized(language)), action: {
                  islogout = false

              }))
            })
       
        
    }
}

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView()
    }
}
