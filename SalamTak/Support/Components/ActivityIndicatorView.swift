//
//  Animations and alerts.swift
//  Salamtech-Dr
//
//  Created by Mohamed Hammam on 10/01/2022.
//

import Foundation
import SwiftUI

struct ActivityIndicatorView: View {
    @Binding var isPresented:Bool?
    @State var loadingTitle : LoadingType?
     var body: some View {
         if isPresented ?? false{
            ZStack {
                ZStack{
                        ProgressView {
                        }
                        .frame(width: 120, height: 120)
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                        .scaleEffect(1.5 , anchor: .center)
                        .background(Color.black.opacity(0.55)).cornerRadius(20)
                    }
                    .background(Color.gray.opacity(0.1).blur(radius: 20))
                .edgesIgnoringSafeArea(.all)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // 1
                .background(Color.black.opacity(0.1))

            }
                   
    }
}


struct ActivityIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
        ActivityIndicatorView(isPresented: .constant(true))
        }.edgesIgnoringSafeArea(.all)
           
    }
}



//MARK: ---- in case you want to use text with indicator ----
enum LoadingType {
    case loading, uploading, none
}
func selecttype(yourType: LoadingType) -> String? {
    switch yourType {
    case .loading:
        return "Loading..."
    case .uploading:
        return "Uploading..."
    case .none:
        return ""
    }
}
