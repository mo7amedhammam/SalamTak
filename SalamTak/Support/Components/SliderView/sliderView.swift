//
//  sliderView.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 16/06/2022.
//

import Foundation
import SwiftUI

struct CustomView: View {

    @Binding var minValue: String // or some value binded
    @Binding var maxValue: String // or some value binded
    var range:Int?
    @State var width:CGFloat = 0
    @State var width1:CGFloat = 0
    var totalwidth : CGFloat = UIScreen.main.bounds.width - 40
    var body: some View{
        VStack{
            ZStack(alignment:.leading){
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height:6)
//                    .frame(width:self.totalwidth ,height:6)
//                    .offset(x:-20)

                Rectangle()
                    .fill(Color.salamtackWelcome)
                    .frame(width:self.width1 - self.width ,height:6)
                    .offset(x:self.width+20)
                
                HStack(spacing:0){
                    Circle()
                        .fill(Color.salamtackWelcome)
                        .frame(width: 20, height: 20, alignment: .center)
                        .offset(x:self.width)
                        .gesture(
                            DragGesture(minimumDistance:0)
                            .onChanged({newval in
                                    if newval.location.x >= 0 && newval.location.x <= self.width1{
                                self.width = newval.location.x
                                }
                            })
                        )
                    
                    Circle()
                        .fill(Color.salamtackWelcome)
                        .frame(width: 20, height: 20, alignment: .center)
                        .offset(x:self.width1)
                        .gesture(
                            DragGesture(minimumDistance:0)
                            .onChanged({newval in
                                if newval.location.x <= self.totalwidth && newval.location.x >= self.width{
                                self.width1 = newval.location.x
                                }
                            })
                        )
                }
            }
        }
        .onAppear(perform: {
            self.width = CGFloat(Float(self.minValue) ?? 0)
            self.width1 = CGFloat(Float(self.maxValue) ?? 0)

        })
        .onChange(of: width, perform: {newval in
            self.minValue = "\(Float(String(format:"%.2f",min(max(0, Float(newval / totalwidth * CGFloat(range ?? 0))), Float(range ?? 0)))) ?? 0.0)"
        })

        .onChange(of: width1, perform: {newval in
            self.maxValue = "\(Float(String(format:"%.2f",min(max(0, Float(newval / totalwidth * CGFloat(range ?? 50))), Float(range ?? 50)))) ?? 0.0)"
        })
        
    }
}

struct CustomView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            CustomView(minValue: .constant(""), maxValue: .constant(""))
        }.navigationBarHidden(true)
    }
}
