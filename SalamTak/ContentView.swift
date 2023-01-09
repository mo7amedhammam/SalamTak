////
////  ContentView.swift
////  SalamTech
////
////  Created by wecancity agency on 3/29/22.
////


import SwiftUI

struct ContentView: View {
    @State var displayedView = AnyView(SplashView())
    @AppStorage("language") // the key you stored language in
    var language = LocalizationService.shared.language

    @Environment(\.presentationMode) var presentationMode
    @Environment(\.scenePhase) var scenePhase
    @State private var loggedin = true
//    @EnvironmentObject var environments:EnvironmentsVM
    @StateObject  var infoProfileVM = PatientInfoViewModel()
    @StateObject  var medicalProfileVM = PatientMedicalInfoViewModel()

    var body: some View {
//        NavigationView {
            ZStack{
                displayedView
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
//                    .environmentObject(environments)
//                    .environmentObject(infoProfileVM)
//                    .environmentObject(medicalProfileVM)


            }
                .onChange(of: scenePhase, perform: { newPhase in
                        if newPhase == .active {
                            print("Active")
                        } else if newPhase == .inactive {
                            print("InActive")
                        } else if newPhase == .background {
                            print("BackGround")
                        }
                })
//            .ignoresSafeArea()
                .navigationViewStyle(StackNavigationViewStyle())
                .preferredColorScheme(.light)
                .onAppear(perform: {
                    Helper.setLanguage(currentLanguage: language.rawValue)
                    delaySegue()
//                    if Helper.userExist() {
//                        loggedin = true
//                    }else{
//                        loggedin = false
//                    }
                    
                    setNavigationAppearance()
            })
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
       
    }
    
    private func delaySegue() {
        // Delay of 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            // first check in its the first time
            guard Helper.checkLanguageSet() else {
//                withAnimation{
                    displayedView = AnyView(newLanguagesView())
//                }
                return
            }
            
            guard Helper.checkOnBoard() else {
//                withAnimation{
                    displayedView = AnyView(OnBoardingView())
//                }
                return
            }
            
            // second check if user is logedin or not
            guard Helper.checkIfLogedIn() else{
//                withAnimation{
                    displayedView = AnyView(WelcomeScreenView())
//                }
                return
            }
            
            // finally
//            withAnimation{
//                if loggedin {
                    displayedView = AnyView(
//                        TabBarGenericView(clinicId: Helper.getClinicId())
                        TabBarView()
                    )

                
//                } else {
//                    displayedView = AnyView(WelcomeScreenView())
//                }
//            }
        }
    }
    
    private func setNavigationAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear

        let attrs: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.monospacedSystemFont(ofSize: 56, weight: .black)
        ]
        appearance.largeTitleTextAttributes = attrs
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().navigationBarHidden(true).environmentObject(EnvironmentsVM())
    }
}


