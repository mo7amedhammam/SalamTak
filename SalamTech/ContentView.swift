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
            
        }
//        .onAppear(perform: {
//            Helper.setLanguage(currentLanguage: "en")
//            Helper.setAccessToken(access_token: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjAxMjQ1MzM0NjQ2IiwibmFtZWlkIjoiMzYyNyIsImp0aSI6ImZmZGM0NWM4LWM3NjYtNDY5Mi1hYTMzLWI4NmFmZWU5MTI4MyIsImV4cCI6MTY0OTM0MjkzOCwiaXNzIjoiU2FsYW1UZWNoQDIwMjEiLCJhdWQiOiJTYWxhbVRlY2hAMjAyMSJ9.ejAbw_jS7ePDabkUBXsZDC6aXk_I54KlBRcLISQIDDI")
//        })

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
