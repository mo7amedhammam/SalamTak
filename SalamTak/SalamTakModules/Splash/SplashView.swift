//
//  SplashView.swift
//  SalamTak
//
//  Created by wecancity on 12/12/2022.
//

import SwiftUI

struct SplashView: View {
    var language = LocalizationService.shared.language

    var body: some View {
        ZStack{
            newBackImage(backgroundcolor: .white)
            VStack{
                Image("newlogo")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal,80)
                Spacer()
                Image("doc'sApp")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal,30)
                    .frame( width:250,height:150)
                Spacer()
                Text("Powered_By".localized(language))
                    .foregroundColor(Color("blueColor"))
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                    .padding(.bottom,-2)
                Image("korashi")
                    .resizable()
                    .frame(width: 150 , height: 150)
                    .scaledToFit()
            }
            .padding(.top,hasNotch ? 60:90)
            .padding(.bottom,hasNotch ? 30:90)
        
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
        SplashView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 Pro"))
    }
}

enum backColorCases{
    case white,opacity,gradient
}

enum newbackgrounds{
    case image1,image2,image3,whatsupback
}

struct newBackImage: View {
    var backgroundcolor:backColorCases = .white
    @State var imageName:newbackgrounds = .image1
    var body: some View {
        ZStack{
            Image(imageName == .image2 ? "newbackground2" : imageName == .image3 ? "newbackground3":imageName == .whatsupback ?  "whatsUpBackground":"newbackground")
            .resizable()
//            .padding(.vertical,0)
            .frame(height: UIScreen.main.bounds.height)
//            .padding(.top,hasNotch ? -14 : -20)
//            .padding(.bottom,0)
            
//            .scaledToFill()
    }
        .edgesIgnoringSafeArea(.top)
    .background(
        ZStack{
            if backgroundcolor == .white{
                Color.clear
            }else if backgroundcolor == .opacity{
            Color("newBackground")
                .blur(radius: 0.9)

        }else if backgroundcolor == .gradient{
            LinearGradient(gradient:Gradient(colors: [ Color("newBackground")
                                                       , Color.white]),startPoint: .top,endPoint: .center)
        }
        }
            .ignoresSafeArea()
    )

    }
}
struct newBackImage_Previews: PreviewProvider {
    static var previews: some View {
        newBackImage(backgroundcolor: .gradient)
        
    }
}
