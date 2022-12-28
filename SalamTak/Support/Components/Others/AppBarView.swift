//
//  AppBarView.swift
//  Salamtech-Dr
//
//  Created by wecancity agency on 12/27/21.
//

import SwiftUI

enum tapbarColor {
case blue,clear,dark
}

struct AppBarView: View {
    @State var Title: String
    @State var imageName: String = ""

    @State var backColor: tapbarColor = .clear
    @State var withbackButton: Bool  = false

    var body: some View{
        ZStack{
        if backColor == .blue{
        CurvedSideRectangleView()
            .fill(Color("blueColor"))
            .frame(height: 120)
            .shadow(radius: 8)
        }else{
            ZStack{
                Color.clear
            }
            .frame(height: 120)

        }
        }
            .overlay(
                HStack {
                    Spacer()
                    if imageName != ""{
                    Spacer()
                    .frame(width: 50, height: 50)
                    }
                    Text(Title)
                        .font(.salamtakBold(of: 24))
                        .fontWeight(.semibold)
                        .foregroundColor(backColor == .blue ? .white:backColor == .dark ? Color("blueColor") : Color("blueColor"))
                        .frame( alignment: .center)
                        .multilineTextAlignment(.center)
                    //BackButtonView()
                    if imageName != ""{
                        numberedImage(text:imageName)
//                    Image(imageName)
                        .frame(width: 50, height: 50)
//                        .padding(.horizontal)
                    }
                    Spacer()
                }
                    .overlay(
                        HStack{
                            if withbackButton{
                            BackButtonView()
                            Spacer()
                            }
                        }.frame(height:60)
                    )
                    .padding(.bottom,-30)
                
            )
    }
}

struct AppBarView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            AppBarView(Title: "Sign Up", imageName: "1-3")
                .edgesIgnoringSafeArea(.all)
            Spacer()
        }
    }
}

struct numberedImage: View {
    var text:String=""
    var body: some View {
        Image("numberedimage")
            .resizable()
        //            .frame(width: 80, height: 80)
            .overlay(
                Text(text)
                    .foregroundColor(.white)
                //                    .font(Font.system(size: 25))
                    .bold()
            )
    }
}

struct AppBarLogoView: View {
    @State var imageName: String
    var body: some View{
        
        CurvedSideRectangleView()
            .fill(Color("mainColor"))
            .frame(height: 100)
            .shadow(radius: 8)
            .overlay(
                HStack {
                    
                    Spacer()
                    Image("\(imageName)")
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .frame(width:140 )

                    
                    Spacer()
                    //BackButtonView()
                    
                    
                }
                    .padding(.bottom,-40)
            )
        
    }
}

struct AppBarLogoView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            AppBarLogoView(imageName: "barlogo")
                .edgesIgnoringSafeArea(.all)
            Spacer()
        }
    }
}

