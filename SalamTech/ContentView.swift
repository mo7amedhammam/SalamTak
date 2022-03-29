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
        Text("Hello, world Mosrsy!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().navigationBarHidden(true)
    }
}
