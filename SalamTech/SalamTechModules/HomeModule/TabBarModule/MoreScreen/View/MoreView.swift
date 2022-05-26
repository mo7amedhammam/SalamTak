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
    @State var goingToNew = false
    
    @State var aboutApp = false
    @State var CallUs = false
    @State var TermsAndConditions = false

    @State private var image = UIImage()
    let screenWidth = UIScreen.main.bounds.size.width - 50
    @State var lang = 1
    @StateObject  var patientCreatedVM = ViewModelCreatePatientProfile()
  

    
    @AppStorage("language")
    var language = LocalizationService.shared.language

    var body: some View {
        NavigationView {
            VStack{
                
                ZStack{

                    AppBarView(Title:"")
                    Spacer().frame( height: 30)

                    ZStack {
                        Button(action: {
                            print("\(Helper.getUserimage())")
                        }, label: {
                            AsyncImage(url: URL(string:  Helper.getUserimage())) { image in
                                image.resizable()
                            } placeholder: {
                                Color("lightGray").opacity(0.2)
                            }
                            .onTapGesture(perform: {
                                print("\(Helper.getUserimage())")
                            })
                        })
                            .clipShape(Rectangle())
                            .frame(width: 60, height: 60, alignment: .center)
                            .cornerRadius(10)
                            .padding()

                    }
                    
                }
                Spacer().frame( height: 30)
                VStack{
                    Text("More_Screen_updateProfile".localized(language))
                        .foregroundColor(Color("lightGray"))
                        .font(Font.SalamtechFonts.Reg16)
                }
                
                Spacer().frame( height: 20)
                ScrollView( showsIndicators: false){
                    VStack(alignment: .leading){
                        Button(action: {
                            self.goingToPatientUpdate.toggle()
                            print(goingToPatientUpdate)
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
                                
                            }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                            .frame(width: screenWidth, height: 40)
                            .font(.system(size: 13))
                            .padding(12)
                            .disableAutocorrection(true)
                            .background(
                                Color.white
                            ).foregroundColor(Color("blueColor"))
                                .cornerRadius(5)
                                .shadow(color: Color.black.opacity(0.099), radius: 3)
                        })

                        Button(action: {
                            self.goingToResetPassword.toggle()
                            print(goingToResetPassword)
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
                                
                            }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                            .frame(width: screenWidth, height: 40)
                            .font(.system(size: 13))
                            .padding(12)
                            .disableAutocorrection(true)
                            .background(
                                Color.white
                            ).foregroundColor(Color("blueColor"))
                                .cornerRadius(5)
                                .shadow(color: Color.black.opacity(0.099), radius: 3)
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
                                
                            }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                            .frame(width: screenWidth, height: 40)
                            .font(.system(size: 13))
                            .padding(12)
                            .disableAutocorrection(true)
                            .background(
                                Color.white
                            ).foregroundColor(Color("blueColor"))
                                .cornerRadius(5)
                                .shadow(color: Color.black.opacity(0.099), radius: 3)
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
                                
                            }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                            .frame(width: screenWidth, height: 40)
                            .font(.system(size: 13))
                            .padding(12)
                            .disableAutocorrection(true)
                            .background(
                                Color.white
                            ).foregroundColor(Color("blueColor"))
                                .cornerRadius(5)
                                .shadow(color: Color.black.opacity(0.099), radius: 3)
                        })
                        Button(action: {
//                            CallUs = true
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
                                
                            }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                            .frame(width: screenWidth, height: 40)
                            .font(.system(size: 13))
                            .padding(12)
                            .disableAutocorrection(true)
                            .background(
                                Color.white
                            ).foregroundColor(Color("blueColor"))
                                .cornerRadius(5)
                                .shadow(color: Color.black.opacity(0.099), radius: 3)
                        })
                        Spacer().frame(height: 20)
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
                        .frame(width: screenWidth, height: 80)
                        .font(.system(size: 13))
                        .padding(12)
                        .disableAutocorrection(true)
                        .background(
                            Color.white
                        ).foregroundColor(Color("blueColor"))
                            .cornerRadius(5)
                            .shadow(color: Color.black.opacity(0.099), radius: 3)
                       
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
                                
                            }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                            .frame(width: screenWidth, height: 40)
                            .font(.system(size: 13))
                            .padding(12)
                            .disableAutocorrection(true)
                            .background(
                                Color.white
                            ).foregroundColor(Color("blueColor"))
                                .cornerRadius(5)
                                .shadow(color: Color.black.opacity(0.099), radius: 3)
                        })
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                }
            }
            .edgesIgnoringSafeArea(.vertical)
            .background(Color("CLVBG"))
           
        }
        .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
       
        NavigationLink(destination: PatientProfile(),isActive:$goingToPatientUpdate , label: {
        })
        NavigationLink(destination: ResetPasswordView(ispresented: .constant(false)),isActive:$goingToResetPassword , label: {
        })

        NavigationLink(destination: WelcomeScreenView().navigationBarBackButtonHidden(true),isActive:$goToLogin , label: {
        })
            .navigationViewStyle(StackNavigationViewStyle())

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
            //                .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing))
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
