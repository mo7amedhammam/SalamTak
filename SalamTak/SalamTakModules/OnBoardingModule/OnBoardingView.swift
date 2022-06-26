//
//  OnBoardingView.swift
//  SalamTech
//
//  Created by wecancity agency on 3/29/22.
//


import SwiftUI

struct OnBoardingView: View {
    private var language = LocalizationService.shared.language
    @State private var currentStep = 0
    @State private var isGetStarted = false
    
    init(){
        UIScrollView.appearance().bounces = false
    }
    var body: some View {
        NavigationView{
            VStack {
                
                TabView(selection: $currentStep) {
                    ForEach(0 ..< OnBoardingSteps.count) { item in
                        VStack {
                            Image(OnBoardingSteps[item].image)
                                .resizable()
                                .frame(width: 300, height: 300, alignment: .center)
                            Text(OnBoardingSteps[item].title.localized(language))
                                .font(.system(size: 30, weight: .bold))
                                .foregroundColor(Color("mainColor"))
                                .bold()
                            
                            Text(OnBoardingSteps[item].description.localized(language))
                                .font(.subheadline)
                                .multilineTextAlignment(.center)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Color("subTitle"))
                                .padding(20)
                            
                        }
                        .tag(item)
                    }
                    
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                HStack{
                    ForEach(0 ..< OnBoardingSteps.count){ item in
                        if item == currentStep {
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(Color("darkGreen"))
                        } else {
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(Color("lightGreen"))
                        }
                    }
                }
                HStack {
                    
                    Button(action: {
                        self.isGetStarted = true
                    }, label: {
                        Text("onBoarding_Skip_Button".localized(language))
                            .padding(16)
                            .foregroundColor(Color("mainColor"))
                    })
                }
                
                Button(action: {
                    if self.currentStep < OnBoardingSteps.count - 1 {
                        self.currentStep += 1
                    } else {
                        isGetStarted = true
                    }
                }, label: {
                    Text(currentStep < OnBoardingSteps.count - 1 ? "onBoarding_Next_Button".localized(language) : "onBoarding_GetStarted_Button".localized(language))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("mainColor"))
                        .cornerRadius(8)
                        .padding(.horizontal, 16)
                        .foregroundColor(.white)
                        .font(.custom("SFUIText", size: 18))
                }).padding(.bottom, 10)
                    .buttonStyle(PlainButtonStyle())
                
                // go to complete Certs after completing first view
                NavigationLink(destination: WelcomeScreenView(),isActive: $isGetStarted , label: {
                })
                
            }
        }.navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .navigationViewStyle(StackNavigationViewStyle())
    }
}


struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}

struct OnBoardingStep {
    let image: String
    let title: String
    let description: String
}

private let OnBoardingSteps = [
    
    OnBoardingStep(image: "onBoarding1", title: "OnBoarding_Screen1_title", description: "OnBoarding_Screen1_subtitle"),
    OnBoardingStep(image: "onBoarding2", title: "OnBoarding_Screen2_title", description: "OnBoarding_Screen2_subtitle"),
    OnBoardingStep(image: "onBoarding3", title: "OnBoarding_Screen3_title", description: "OnBoarding_Screen3_subtitle")
    
    
    
]

