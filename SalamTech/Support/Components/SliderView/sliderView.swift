//
//  sliderView.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 16/06/2022.
//

import Foundation
import SwiftUI
struct CustomView: View {

    @Binding var percentage: Float // or some value binded
    var range:Int = 50

    var body: some View {
        VStack {
            GeometryReader { geometry in
                VStack {
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .foregroundColor(.gray.opacity(0.2))
                            .frame(height:22)

                        Rectangle()
                            .foregroundColor(Color("blueColor"))
                            .frame(height:22)
                            .frame(width: geometry.size.width * CGFloat(self.percentage / Float(range)))
                    }
                    .cornerRadius(12)
                    .gesture(DragGesture(minimumDistance: 0)
                    .onChanged({ value in
                        self.percentage = min(max(0, Float(value.location.x / geometry.size.width * CGFloat(range))), Float(range))
                        print(self.percentage)
                }))
                }
            }
            .frame(height:55)
            .padding()
        }
    }
}

struct CustomView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            CustomView(percentage: .constant(12))
        }.navigationBarHidden(true)
    }
}
