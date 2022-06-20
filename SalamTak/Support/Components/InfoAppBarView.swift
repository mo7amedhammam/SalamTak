//
//  InfoAppBarView.swift
//  Salamtech-Dr
//
//  Created by wecancity agency on 1/8/22.
//

import SwiftUI

struct InfoAppBarView: View {
    @State var Maintext: String?
    @State var text: String?
    @State var Nexttext: String?
    @State var image: String?
    @State var navBarHidden: Bool?

    var body: some View {
        ZStack{
            //Spacer()
            ZStack {
                Image("underappbar")
                    .resizable()
                    .frame(height: 150)
                    .padding(.bottom, -40)
                
                HStack( spacing: 20){
                    Image(image ?? "progress1")
                        .resizable()
                        .frame(width: 60, height: 60)
                    VStack( spacing: 2) {
                        Text(text ?? "").font(.title)
                        Text("Next: \(Nexttext ?? "")")
                            .font(.system(size: 14))
                            .foregroundColor(Color.gray)
                    }
                    Spacer()
                }.frame( height: 80)
                    .padding()
                    .offset(y: 25)
                
            }.offset(y: 90)
            AppBarView(Title: Maintext ?? "")
                .navigationBarItems(leading: BackButtonView())
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(navBarHidden ?? false)
//                .ignoresSafeArea()
            //Spacer()
        }.ignoresSafeArea()
    }
}


struct InfoAppBarView_Previews: PreviewProvider {
    static var previews: some View {
        InfoAppBarView(Maintext: "main Title", text: "current step", Nexttext: "next step")
    }
}
