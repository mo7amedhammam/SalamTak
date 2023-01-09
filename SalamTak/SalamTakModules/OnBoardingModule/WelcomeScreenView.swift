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
    
//    @StateObject var infoProfileVM : PatientInfoViewModel
//    @StateObject var medicalProfileVM : PatientMedicalInfoViewModel
    @StateObject var environments = EnvironmentsVM()

    var body: some View {
//        NavigationView{
        ZStack {
            newBackImage(backgroundcolor: .white)
            VStack {

                VStack(spacing:30){
                    Image("newlogo")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal,100)
                        .padding(.top,80)
                    
                    Text("welcome_screen_title".localized(language))
                        .font(.salamtakBold(of: 50))
                        .foregroundColor(.salamtackWelcome)
                        .bold()
                        .padding(.top,30)

                    Text("Welcome_Screen_subtitle".localized(language))
                        .font(.salamtakBold(of: 18))
                        .foregroundColor(.salamtackBlue)
                        .multilineTextAlignment(.center)
                        .padding()
                }
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
        NavigationLink(destination: ViewLogin(ispresented: .constant(false))
//                        .environmentObject(infoProfileVM)
//                        .environmentObject(medicalProfileVM)
                        .environmentObject(environments)
                       ,isActive: $isLogin , label: {
            })

            // go to complete Certs after completing first view
        NavigationLink(destination: ViewSignUp(ispresented: .constant(false))
//                        .environmentObject(infoProfileVM)
//                        .environmentObject(medicalProfileVM)
                        .environmentObject(environments)
                       ,isActive: $isSignup , label: {
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

