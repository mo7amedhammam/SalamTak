//
//  AppBarView.swift
//  Salamtech-Dr
//
//  Created by wecancity agency on 12/27/21.
//

import SwiftUI

struct AppBarView: View {
    @State var Title: String
    var body: some View{
        VStack{
        CurvedSideRectangleView()
            .fill(Color("mainColor"))
            .frame(height: 100)
            .shadow(radius: 8)
            .overlay(
                HStack {
                    Spacer()
                    Text(Title)
                        .font(Font.SalamtechFonts.Reg24)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame( alignment: .center)
                        .padding(.bottom, 15)
                    Spacer()
                }
                    .padding(.bottom,-50)
            )
        Spacer()
        }
    }
}

struct AppBarView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            AppBarView(Title: "Sign Up")
                .edgesIgnoringSafeArea(.all)
            Spacer()
        }
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

