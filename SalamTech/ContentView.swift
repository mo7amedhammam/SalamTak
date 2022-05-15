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
            Helper.setUserData(Id: 24, PhoneNumber: "01101201322", patientName: "mohamed hammam")
            Helper.setLanguage(currentLanguage: "en")
            Helper.setAccessToken(access_token: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjAxMTEwMDAwMDAwIiwibmFtZWlkIjoiMzU5MiIsImp0aSI6ImYyOGI4OTlkLTM5ZjktNGJkOC1iYmE4LTc5OWE4NDdkNWYwOCIsImV4cCI6MTY1MjcwNjA3MiwiaXNzIjoiU2FsYW1UZWNoQDIwMjEiLCJhdWQiOiJTYWxhbVRlY2hAMjAyMSJ9.jg5mYwkeQXD3hYbiosrXheOD2NWui4NZtqhiJnVbUd8")
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
