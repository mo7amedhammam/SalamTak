//
//  OnBoardingView.swift
//  Salamtak-Dr
//
//  Created by wecancity agency on 12/26/21.
//

import SwiftUI
import Foundation
//import UIKit

struct OnBoardingView: View {
//    @AppStorage("languageKey") // the key you stored language in
//    var language = LocalizationService.shared.language
    @State private var currentStep = 0
    @State private var isGetStarted = false
    
    init(){
        UIScrollView.appearance().bounces = false
    }
    var body: some View {
//        NavigationView{
        ZStack {
            VStack {
                    TabView(selection: $currentStep) {
                        ForEach(0 ..< OnBoardingSteps.count) { on in
                            VStack(spacing:2) {
                                Image(OnBoardingSteps[on].image)
                                    .resizable()

//                                    .aspectRatio( contentMode: .scaleToFill)
                                    .frame(height: hasNotch ? UIScreen.main.bounds.height/2 + 60 : UIScreen.main.bounds.height/2 - 40)
                                                                    .scaledToFit()
//                                                                    .ignoresSafeArea(.top)
//                                    .aspectRatio( contentMode: .aspectFill())
//                                    .aspectFill()
                                //                                .frame(width: 300, height: 300, alignment: .center)
                                Spacer()
//                                    .frame(maxHeight:30)

                                HStack {
                                    Text(OnBoardingSteps[on].title.localized(language))
                                        .font(.system(size: 25, weight: .bold))
                                        .foregroundColor(Color("newWelcome"))
                                    Spacer()
                                }
//                                .padding(.top)
                                .frame(height:50)
                                .padding(.horizontal)
//                                .background(
//                                    LinearGradient(colors: [.black.opacity(0.05),.black.opacity(0.01)], startPoint: .top, endPoint: .bottom)
//                                )

                                Text(OnBoardingSteps[on].description.localized(language))
                                    .font(.subheadline)
                                    .multilineTextAlignment(language.rawValue == "en" ? .leading:.trailing)
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(Color("subText"))
                                    .padding(.horizontal, 30)
                                    .padding(.bottom,-20)
                            
                                Spacer()
                            }
//                            .frame(height:UIScreen.main.bounds.height)
                            .tag(on)
                        }
//                        .padding(.bottom)
                        
                    }

                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    HStack{
                        ForEach(0 ..< OnBoardingSteps.count){ it in
                            if it == currentStep {
                                Circle()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(Color("blueColor"))
                            } else {
                                Circle()
                                    .frame(width: 10, height: 10)
                                    .foregroundColor(Color("blueColor"))
                            }
                        }
                    }
                    HStack {
                        Button(action: {
    //                        self.isGetStarted = true
    //                        if self.currentStep < OnBoardingSteps.count - 1 {
    //                            self.currentStep += 1
    //                        } else {
                                isGetStarted = true
                                Helper.onBoardOpened()
    //                        }
                        }, label: {
    //                        Text("onBoarding_Skip_Button".localized(language))
                            Text(currentStep < OnBoardingSteps.count - 1 ? "onBoarding_Skip_Button".localized(language) : "onBoarding_GetStarted_Button".localized(language))
                                .fontWeight(.semibold)
                                .padding(16)
                                .foregroundColor(Color("blueButton"))
                        })
                    }
                    
    //                Button(action: {
    //                    if self.currentStep < OnBoardingSteps.count - 1 {
    //                        self.currentStep += 1
    //                    } else {
    //                        isGetStarted = true
    //                        Helper.onBoardOpened()
    //                    }
    //                }, label: {
    //                    Text(currentStep < OnBoardingSteps.count - 1 ? "onBoarding_Next_Button".localized(language) : "onBoarding_GetStarted_Button".localized(language))
    //                        .padding()
    //                        .frame(maxWidth: .infinity)
    //                        .background(Color("blueColor"))
    //                        .cornerRadius(8)
    //                        .padding(.horizontal, 16)
    //                        .foregroundColor(.white)
    //                        .font(.custom("SFUIText", size: 18))
    //                }).padding(.bottom, 10)
    //                    .buttonStyle(PlainButtonStyle())
//                Spacer()
                    // go to complete Certs after completing first view
                    NavigationLink(destination: WelcomeScreenView(),isActive: $isGetStarted , label: {
                    })
                }
            .padding(.top,hasNotch ? -100:0)
            .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        }
//        .edgesIgnoringSafeArea(.top)
//        .frame(width:UIScreen.main.bounds.width,height:UIScreen.main.bounds.height)
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        OnBoardingView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
    }
}

struct OnBoardingStep {
    let image: String
    let title: String
    let description: String
}

private let OnBoardingSteps = [
    OnBoardingStep(image: "onboardimg1", title: "OnBoarding_Screen1_title", description: "OnBoarding_Screen1_subtitle"),
    OnBoardingStep(image: "onboardimg2", title: "OnBoarding_Screen2_title", description: "OnBoarding_Screen2_subtitle"),
    OnBoardingStep(image: "onboardimg3", title: "OnBoarding_Screen3_title", description: "OnBoarding_Screen3_subtitle")
]
