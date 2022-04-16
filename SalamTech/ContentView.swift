//
//  ContentView.swift
//  SalamTech
//
//  Created by wecancity agency on 3/29/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.scenePhase) var scenePhase
    var body: some View {
        ZStack{
//            MedicalStateView()
            TabBarView()
//            PersonalDataView()
//            OnBoardingView()
//            PatientProfile()
            
        }
        .onAppear(perform: {
            Helper.setLanguage(currentLanguage: "en")
            Helper.setAccessToken(access_token: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjAxMTEwMDAwMDAwIiwibmFtZWlkIjoiMzU5MiIsImp0aSI6Ijc5NTVhYWVlLWEzMDktNDQ5Yy05ODEzLWNjMWFkYmFlMDUwZSIsImV4cCI6MTY1MDI3NzIyMSwiaXNzIjoiU2FsYW1UZWNoQDIwMjEiLCJhdWQiOiJTYWxhbVRlY2hAMjAyMSJ9.LLYFB_ozXmYFRVa5w_AkV0eHeEssHkHCFd5DgjAzR4M")
        })

        .onChange(of: scenePhase, perform: { newPhase in
                if newPhase == .active {
                    print("Active")
                } else if newPhase == .inactive {
                    print("InActive")
                } else if newPhase == .background {
                    print("BackGround")
                }
        })
        
        .ignoresSafeArea()
        .preferredColorScheme(.light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().navigationBarHidden(true)
    }
}
