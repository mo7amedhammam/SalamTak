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
            OnBoardingView()
//            TabBarView()
//            PersonalDataView()
            
        }
//        .onAppear(perform: {
//            Helper.setLanguage(currentLanguage: "en")
//            Helper.setAccessToken(access_token: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjAxMjQzMzQ2NDQ0IiwibmFtZWlkIjoiMzU4NyIsImp0aSI6IjBjZjAwNDg4LWRlZjItNDExOC05ZTUyLWRjZTZkZDYwYTU2ZiIsImV4cCI6MTY0OTI0MzY5NiwiaXNzIjoiU2FsYW1UZWNoQDIwMjEiLCJhdWQiOiJTYWxhbVRlY2hAMjAyMSJ9.r2jZSvwBIlzqr2hjum7WlEEVFe1GmTa85T_xiofvEqw")
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
