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
//        .onAppear(perform: {
//            Helper.setLanguage(currentLanguage: "en")
//            Helper.setAccessToken(access_token: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjAxMTk5ODg3NzY2IiwibmFtZWlkIjoiMzY0NSIsImp0aSI6IjU1ZGYxOTZhLTE0NTEtNGRjMi1iNTdiLWRjY2MwY2FjNWYyMyIsImV4cCI6MTY0OTQ5NjM2MywiaXNzIjoiU2FsYW1UZWNoQDIwMjEiLCJhdWQiOiJTYWxhbVRlY2hAMjAyMSJ9.6VVZmZC7RheuztFliG-WexIree587vdmS3AWKryZNPk")
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
