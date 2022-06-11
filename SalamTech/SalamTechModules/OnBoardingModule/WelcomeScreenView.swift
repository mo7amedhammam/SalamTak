//
//  WelcomeScreenView.swift
//  SalamTech
//
//  Created by wecancity agency on 3/29/22.
//
import SwiftUI
import FlagKit

struct WelcomeScreenView: View {
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    @State private var lang = URLs()
    @State var isLogin  : Bool = false
    @State var isSignup : Bool = false
    
    var body: some View {
//        NavigationView{
        VStack {
            
                VStack (alignment:.leading){
                    HStack {
                        
                        Menu {
                            Button {
                                
                                LocalizationService.shared.language = .arabic
                                Helper.setLanguage(currentLanguage: "ar")
                                print(Helper.getLanguage())
                            } label: {
                                Text("العربية")
                                flagBy(countryCode: "EG")
                            }
                            
                            Button {
                                
                                LocalizationService.shared.language = .english_us
    //                            URLs.add(lang: "en")
                                Helper.setLanguage(currentLanguage: "en")
                                print(Helper.getLanguage())
                                
    //                            print(URLs.language)
                            } label: {
                                Text("English (US)")
                                flagBy(countryCode: "US")
                            }
                            
                        } label: {
                            Spacer()
                            flagBy(countryCode: language.userSymbol.uppercased())
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                        .padding()
                        
                    }
                    
                    //Spacer()
                }
//
            Spacer()
            VStack{
                Image("logo")
                        .resizable()
                        .frame(width: 180, height: 180, alignment: .center)
                        .padding(.top, 50)
                
                Text("welcome_screen_title".localized(language))
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(Color("mainColor"))
                    .bold()
                    
                    
                Text("Welcome_Screen_subtitle".localized(language))
                    .font(.custom("SFUIText", size: 16))
                    .fontWeight(.semibold)
                    .foregroundColor(Color("subTitle"))
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .offset( y: -80)
                
            Spacer()
            
         
                        ButtonView(text: "SignIn_Button".localized(language)){
                               self.isLogin = true
                           }

                       
                       ButtonView(text: "SignUp_Button".localized(language), backgroundColor: .white){
                               self.isSignup = true
                       }
                           
                           .border(Color("mainColor"), width: 2)
                           .cornerRadius(4)
                           .padding(.bottom,10)
  
        }

        .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        
            // go to complete Certs after completing first view
        NavigationLink(destination: ViewLogin(ispresented: .constant(false), QuickLogin: .constant(false)),isActive: $isLogin , label: {
            })

            // go to complete Certs after completing first view
        NavigationLink(destination: ViewSignUp(ispresented: .constant(false), quickSignup: .constant(false)),isActive: $isSignup , label: {
            })
            .navigationViewStyle(StackNavigationViewStyle())


    }
    
}
private extension WelcomeScreenView {
    
    func flagBy(countryCode: String) -> Image {
        guard let flag = Flag(countryCode: countryCode) else {
            return Image(systemName: "questionmark.circle")
        }
        return Image(uiImage: flag.image(style: .roundedRect))
    }
}

struct WelcomeScreenView_Previews: PreviewProvider {
    static var previews: some View {

            WelcomeScreenView()
        .edgesIgnoringSafeArea(.top)

        
        
    }
}

