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
//                Person1alDataView()
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
