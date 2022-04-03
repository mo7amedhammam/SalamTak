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
//            OnBoardingView()
//            TabBarView()
            PersonalDataView()
            
        }
//        .onAppear(perform: {
//            Helper.setLanguage(currentLanguage: "en")
//            Helper.setAccessToken(access_token: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjAxMDExMTExMTExIiwibmFtZWlkIjoiMTc0IiwianRpIjoiNWYxYTIzZjctNjk5OS00OGIzLThkZjEtNmE5Njg5NGM2ZTFiIiwiZXhwIjoxNjQ5MDczOTMyLCJpc3MiOiJTYWxhbVRlY2hAMjAyMSIsImF1ZCI6IlNhbGFtVGVjaEAyMDIxIn0.wtL2LGYlxl5htHjxMpD346g8LXttWfYNlu2cCvt1x84")
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
