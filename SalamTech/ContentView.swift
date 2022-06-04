//
//  ContentView.swift
//  SalamTech
//
//  Created by wecancity agency on 3/29/22.
//

import SwiftUI
import MapKit
import ImageViewerRemote

struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        ZStack{
            TabBarView()
     
        }
        .onAppear(perform: {
//            Helper.setUserData(Id: 25, PhoneNumber: "01101201322", patientName: "mohamed hammam")
//            Helper.setLanguage(currentLanguage: "en")
//            Helper.setAccessToken(access_token: "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjAxMTEwMDAwMDAwIiwibmFtZWlkIjoiMzU5MiIsImp0aSI6IjU2NDQ4YmM5LThkMzEtNDQwZi05Y2NiLWFlNzBhZjVhZjM1OCIsImV4cCI6MTY1MzU1NjA5MiwiaXNzIjoiU2FsYW1UZWNoQDIwMjEiLCJhdWQiOiJTYWxhbVRlY2hAMjAyMSJ9.RX0wAj9YvuxXsmwwFoR3o5wBhrmuV4_7mC6V1_IBwkU")
            
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


@MainActor class imagView: ObservableObject {
    @Published var ShowImage: Bool
    @Published var ImageURL: String
    
    init(){
        ShowImage = false
        ImageURL = ""
    }
}
