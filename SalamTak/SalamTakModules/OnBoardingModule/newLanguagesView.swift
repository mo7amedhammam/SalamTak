//
//  newLanguagesView.swift
//  SalamTak
//
//  Created by wecancity on 12/12/2022.
//

import SwiftUI

struct newLanguagesView: View {
//    @AppStorage("languageKey") // the key you stored language in
    var language = LocalizationService.shared.language
//    @AppStorage("languageKey") // the key you stored language in var language: String = "en"

    @State var active  : Bool = false
    @State var destination  = AnyView(WelcomeScreenView())
    @State var innerChange  : Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        ZStack{
            newBackImage(backgroundcolor: .white)
            VStack{

                Image("newlogo")
                    .resizable()
                    .padding(.horizontal,60)
                    .scaledToFit()
                    .padding(.top,100)
                Spacer()
                HStack{
                    Button(action: {
                        DispatchQueue.main.async {
                            LocalizationService.shared.language = .english_us
                            Helper.setLanguage(currentLanguage: "en")
                            Helper.languageIsSet()
                        }
                        if innerChange{
                            self.presentationMode.wrappedValue.dismiss()
                        } else{
                            if Helper.checkOnBoard(){
                                destination = AnyView(WelcomeScreenView())
                            }else{
                                destination = AnyView(OnBoardingView())
                            }
                            active.toggle()
                        }
                    }, label: {
                        Image("new-english")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120)
                    })
                        Spacer()
                    Button(action: {
                        DispatchQueue.main.async {
                            LocalizationService.shared.language = .arabic
                            Helper.setLanguage(currentLanguage: "ar")
                            Helper.languageIsSet()
                        }

                        if innerChange{
                            self.presentationMode.wrappedValue.dismiss()
                        } else{
                        if Helper.checkOnBoard(){
                            destination = AnyView(WelcomeScreenView())
                           }else{
                            destination = AnyView(OnBoardingView())
                           }
                        active.toggle()
                        }
                    }, label: {
                        Image("new-arabic")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120)
                    })
                    
                }.padding(.horizontal,40)
                Spacer()
            }
        }

        .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)

        // go to complete Certs after completing first view
        NavigationLink(destination: destination,isActive: $active , label: {
        })

    }
}

struct newLanguagesView_Previews: PreviewProvider {
    static var previews: some View {
        newLanguagesView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        newLanguagesView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
    }
}
