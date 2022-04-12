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
//            TabBarView()
//            PersonalDataView()
            OnBoardingView()
//            PatientProfile()
            
        }
        .onAppear(perform: {
            Helper.setLanguage(currentLanguage: "en")
            
            
//            Helper.setAccessToken(access_token: "Bearer yJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjAxMDMzMjU1NzAwIiwibmFtZWlkIjoiMzY1NiIsImp0aSI6IjMyMTk5YmEzLTg5NTUtNDRlZS04NWFmLTA5ZGU2MDkzY2I4MCIsImV4cCI6MTY0OTkzMDI3OCwiaXNzIjoiU2FsYW1UZWNoQDIwMjEiLCJhdWQiOiJTYWxhbVRlY2hAMjAyMSJ9.FqpnPFs_R__ig_w8q6QWAd2EI7CWjcWAE6pMwtnQ-L8")
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
