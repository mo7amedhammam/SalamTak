//
//  Animations and alerts.swift
//  Salamtech-Dr
//
//  Created by wecancity on 10/01/2022.
//

import Foundation
import SwiftUI

struct Arcs: View {
    @Binding var isAnimating: Bool
    let count: UInt
    let width: CGFloat
    let spacing: CGFloat

    public init(animate: Binding<Bool>, count: UInt = 3, width: CGFloat = 2, spacing: CGFloat = 1) {
            self._isAnimating = animate
            self.count = count
            self.width = width
            self.spacing = spacing
        }
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<Int(count)) { index in
                item(forIndex: index, in: geometry.size)
                    .rotationEffect(isAnimating ? .degrees(360) : .degrees(0))
                    .animation(
                        Animation.default
                            .speed(Double.random(in: 0.2...0.5))
                            .repeatCount(isAnimating ? .max : 1, autoreverses: false)
                    )
            }
        }
        .aspectRatio(contentMode: .fit)
    }

    private func item(forIndex index: Int, in geometrySize: CGSize) -> some View {
        Group { () -> Path in
            var p = Path()
            p.addArc(center: CGPoint(x: geometrySize.width/2, y: geometrySize.height/2),
                     radius: geometrySize.width/2 - width/2 - CGFloat(index) * (width + spacing),
                     startAngle: .degrees(0),
                     endAngle: .degrees(Double(Int.random(in: 120...300))),
                     clockwise: true)
            return p.strokedPath(.init(lineWidth: width))
        }
        .frame(width: geometrySize.width, height: geometrySize.height)
    }
}


struct Bars: View {
    @Binding var isAnimating: Bool
    let count: UInt
    let spacing: CGFloat
    let cornerRadius: CGFloat
    let scaleRange: ClosedRange<Double>
    let opacityRange: ClosedRange<Double>

    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<Int(count)) { index in
                item(forIndex: index, in: geometry.size)
            }
        }
        .aspectRatio(contentMode: .fit)
    }

    private var scale: CGFloat { CGFloat(isAnimating ? scaleRange.lowerBound : scaleRange.upperBound) }
    private var opacity: Double { isAnimating ? opacityRange.lowerBound : opacityRange.upperBound }

    private func size(count: UInt, geometry: CGSize) -> CGFloat {
        (geometry.width/CGFloat(count)) - (spacing-2)
    }

    private func item(forIndex index: Int, in geometrySize: CGSize) -> some View {
        RoundedRectangle(cornerRadius: cornerRadius,  style: .continuous)
            .frame(width: size(count: count, geometry: geometrySize), height: geometrySize.height)
            .scaleEffect(x: 1, y: scale, anchor: .center)
            .opacity(opacity)
            .animation(
                Animation
                    .default
                    .repeatCount(isAnimating ? .max : 1, autoreverses: true)
                    .delay(Double(index) / Double(count) / 2)
            )
            .offset(x: CGFloat(index) * (size(count: count, geometry: geometrySize) + spacing))
    }
}


struct Blinking: View {
    @Binding var isAnimating: Bool
    let count: UInt
    let size: CGFloat

    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<Int(count)) { index in
                item(forIndex: index, in: geometry.size)
                    .frame(width: geometry.size.width, height: geometry.size.height)

            }
        }
        .aspectRatio(contentMode: .fit)
    }

    private func item(forIndex index: Int, in geometrySize: CGSize) -> some View {
        let angle = 2 * CGFloat.pi / CGFloat(count) * CGFloat(index)
        let x = (geometrySize.width/2 - size/2) * cos(angle)
        let y = (geometrySize.height/2 - size/2) * sin(angle)
        return Circle()
            .frame(width: size, height: size)
            .scaleEffect(isAnimating ? 0.5 : 1)
            .opacity(isAnimating ? 0.25 : 1)
            .animation(
                Animation
                    .default
                    .repeatCount(isAnimating ? .max : 1, autoreverses: true)
                    .delay(Double(index) / Double(count) / 2)
            )
            .offset(x: x, y: y)
    }
}


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
struct ActivityIndicatorView: View {
    @Binding var isPresented:Bool?
    @State var loadingTitle : LoadingType?
     var body: some View {
         
   
        if isPresented ?? false{
            ZStack {
                ZStack{
        //                Color.gray.opacity(0.01).blur(radius: 10)
                        ProgressView {
//                            Text(selecttype(yourType: loadingTitle ?? .none ) ?? "").font(.system(size: 10)).foregroundColor(.white)
//                                .font(.title2)
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
//                .accentColor(Color.black)
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






//
//struct MyalertView: View {
//    @Binding var isPresented:Bool
//    var body: some View {
//
//
//
//
//
////            .frame(maxWidth: .infinity, maxHeight: .infinity) // 1
//////                .accentColor(Color.black)
////                .background(Color.black.opacity(0.1))
//
//
//                .alert(isPresented: $isPresented, content: {
//                    Alert(title: Text("Alert:"),
//                        message: Text("press OK to execute default action..."),
//                        dismissButton: Alert.Button.default(
//                            Text("Ok"), action: { print("Hello world!") }
//                        )
//                    )
////                    Alert(title: Text("Alert!"), message: Text("Message"),
////                        primaryButton: Alert.Button.default(Text("Yes"), action: {
////                            print("Yes")
////                        }),
////                        secondaryButton: Alert.Button.cancel(Text("No"), action: {
////                            print("No")
////                        })
////                    )
//
//                })
//    }
//}
//
//
//struct MyalertView_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack{
//            MyalertView(isPresented: .constant(true))
//        }.edgesIgnoringSafeArea(.all)
//
//    }
//}
