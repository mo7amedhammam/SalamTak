//
//  WelcomeView.swift
//  Salamtak-Dr
//
//  Created by wecancity agency on 12/26/21.
//

import SwiftUI
//import FlagKit

struct WelcomeScreenView: View {
//    @AppStorage("languageKey") // the key you stored language in
//    var language = LocalizationService.shared.language
//    @State private var lang = URLs()
    @State var isLogin  : Bool = false
    @State var isSignup : Bool = false
    
    var body: some View {
//        NavigationView{
        ZStack {
            newBackImage(backgroundcolor: .white)
            VStack {
//                    VStack (alignment:.leading){
//                        HStack {
//
//                            Menu {
//                                Button {
//
//                                    LocalizationService.shared.language = .arabic
//                                    Helper.setLanguage(currentLanguage: "ar")
//                                    print(Helper.getLanguage())
//                                    print(LocalizationService.shared.language)
//                                    print(language)
//                                } label: {
//                                    Text("العربية")
//                                    flagBy(countryCode: "EG")
//                                }
//
//                                Button {
//
//                                    LocalizationService.shared.language = .english_us
//                                    Helper.setLanguage(currentLanguage: "en")
//                                    print(Helper.getLanguage())
//                                    print(LocalizationService.shared.language)
//                                    print(language)
//                                } label: {
//                                    Text("English (US)")
//                                    flagBy(countryCode: "US")
//                                }
//
//                            } label: {
//                                Spacer()
//                                flagBy(countryCode: language.userSymbol.uppercased())
//                                    .resizable()
//                                    .frame(width: 40, height: 40)
//                            }
//                            .padding()
//
//                        }
//
//                        //Spacer()
//                    }

//                Spacer()
                VStack(spacing:30){
                    Image("newlogo")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal,100)
                        .padding(.top,80)
                    
//                    Spacer().frame(maxHeight:50)
                    Text("welcome_screen_title".localized(language))
                        .font(.system(size: 50, weight: .bold))
                        .foregroundColor(Color("newWelcome"))
                        .bold()
                        .padding(.top,30)

                        
//                    Spacer().frame(maxHeight:50)
                    Text("Welcome_Screen_subtitle".localized(language))
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color("blueColor"))
                        .multilineTextAlignment(.center)
                        .padding()
//                    Spacer()
                }
//                .offset( y: -80)
                Spacer()
                ButtonView(text: "SignIn_Button".localized(language),backgroundColor: .clear, forgroundColor:Color("blueColor"),fontSize: Font.salamtakBold(of: 22)){
                                   self.isLogin = true
                               }
                .frame(height:40)
                .overlay(
                               RoundedRectangle(cornerRadius: 25)
                                   .stroke(Color("blueColor"), lineWidth: 2)
                       )
                .padding(.horizontal,80)

                           ButtonView(text: "New_SignUp_Button".localized(language), backgroundColor: .clear,forgroundColor:Color("blueColor"),fontSize: Font.salamtakBold(of: 22)){
                                   self.isSignup = true
                           }
                           .frame(height:40)
                           .overlay(
                                          RoundedRectangle(cornerRadius: 25)
                                              .stroke(Color("blueColor"), lineWidth: 2)
                                  )
                           .padding(.horizontal,80)
                               .padding(.vertical,10)
                               .padding(.bottom,hasNotch ? 80:90)
            }
    //        .edgesIgnoringSafeArea(.top)
    //        }
            .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        }
        
            // go to complete Certs after completing first view
        NavigationLink(destination: ViewLogin(ispresented: .constant(false)),isActive: $isLogin , label: {
            })

            // go to complete Certs after completing first view
        NavigationLink(destination: ViewSignUp(ispresented: .constant(false)),isActive: $isSignup , label: {
            })
    }
    
}
//private extension WelcomeScreenView {
//    func flagBy(countryCode: String) -> Image {
//        guard let flag = Flag(countryCode: countryCode) else {
//            return Image(systemName: "questionmark.circle")
//        }
//        return Image(uiImage: flag.image(style: .roundedRect))
//    }
//}

struct WelcomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
//        NavigationView {
            WelcomeScreenView()
        .edgesIgnoringSafeArea(.top)
//        .navigationBarTitle("")
//        .navigationBarHidden(true)
//        .navigationBarBackButtonHidden(true)
        .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        
    }
}

