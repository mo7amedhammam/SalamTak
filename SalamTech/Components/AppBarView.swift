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
        
        CurvedSideRectangleView()
            .fill(Color("mainColor"))
            .frame(height: 100)
            .shadow(radius: 8)
            .overlay(
                HStack {
                    
                    //                            BackButtonView()
                    Spacer()
                    Text(Title)
//                        .font(.system(size: 24))
                        .font(Font.SalamtechFonts.Reg24)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame( alignment: .center)
                        .padding(.bottom, 15)
                    
                    
                    Spacer()
                    //BackButtonView()
                    
                    
                }
                    .padding(.bottom,-50)
            )
        
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



struct BackButtonView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.backward")
                .renderingMode(.original)
                .foregroundColor(.white)
                .padding()
                .font(.system(size: 22, weight: .bold))
                .background(
                    Rectangle()
                        .fill(LinearGradient(gradient:Gradient(colors: [Color.gray, Color.gray ]),startPoint: .center,endPoint: .trailing)
                              
                             )
                        .frame(width: 40, height: 40)
                        .cornerRadius(15)
                        .opacity(0.3)
                        .shadow(color: .white, radius: 3, x: 2, y: 2)
                )
        })
    }
}


struct FilterButtonView: View {
    var imagename = ""
    var action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }, label: {
            Image(imagename)
                .renderingMode(.original)
                .foregroundColor(.white)
                .padding()
                .font(.system(size: 22, weight: .bold))
                .background(
                    Rectangle()
                        .fill(LinearGradient(gradient:Gradient(colors: [Color.gray, Color.gray ]),startPoint: .center,endPoint: .trailing)
                              
                             )
                        .frame(width: 40, height: 40)
                        .cornerRadius(15)
                        .opacity(0.3)
                        .shadow(color: .white, radius: 3, x: 2, y: 2)
                )
        })
    }
}
