//
//  CustomSheet.swift
//  SalamTech
//
//  Created by wecancity on 17/04/2022.
//

import Foundation
import SwiftUI

struct CustomSheet <Content: View>: View {

    let content: Content
    var language : Language
      var IsPresented: Binding<Bool>

    init(  IsPresented:Binding<Bool>, @ViewBuilder content: () -> Content) {
        self.language = LocalizationService.shared.language
        self.IsPresented = IsPresented
        self.content = content()
    }

    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                
              
                
                VStack {
                        Capsule()
                            .frame(width: 50, height: 4)
                            .foregroundColor(.gray)
                            .padding(.top ,10)
                            .padding(.bottom,20)
                    
//                    ScrollView( showsIndicators: false, content: {
//                        self.content
//                    })
                        VStack {
                        self.content
                    }
                }.background(
                    RoundedRectangle(cornerRadius: 40.0)
                        .foregroundColor(.white)
                        .ignoresSafeArea()
                        .opacity(1.5)
                        .shadow(radius: 15)
                        .frame(width: UIScreen.main.bounds.width)

)

            }

        }
        .frame(width: UIScreen.main.bounds.width)
        .background(
            Color.clear
        )
        .onTapGesture(perform: {
            IsPresented.wrappedValue.toggle()
        })
        
    }
}


struct FeesFilterTextField: View {
    @Binding var text: String
    var title : String
    let screenWidth = UIScreen.main.bounds.size.width - 50
    var body: some View {
        ZStack (alignment:.leading){
            if text != "" || !text.isEmpty{
                Text(title)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .offset(y: text.isEmpty ? 0 : -20)
                    .scaleEffect(text.isEmpty ? 1 : 0.9, anchor: .leading)
            }
            
            TextField(title,text:$text)
                .autocapitalization(.none)
                .textInputAutocapitalization(.none)
//                .padding(12)
                .font(.system(size: 20))

            
        }
        
//        .animation(.default)
        .frame( height: 45)
        .font(.system(size: 20))
        .padding(12)
        .disableAutocorrection(true)
        .background(
            Color.white
        ).foregroundColor(.black)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.099), radius: 3)
        
    }
}
struct FeesFilterTextField1: View {
    var text: String
    var title : String
    let screenWidth = UIScreen.main.bounds.size.width - 50
    var body: some View {
        ZStack (alignment:.leading){
            if text != "" || !text.isEmpty{
                Text(title)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .offset(y: text.isEmpty ? 0 : -20)
                    .scaleEffect(text.isEmpty ? 1 : 0.9, anchor: .leading)
            }
            
            HStack {
                Text(text)
                    .autocapitalization(.none)
                    .textInputAutocapitalization(.none)
    //                .padding(12)
                .font(.system(size: 20))
                
                Spacer()
            }

            
        }
        
//        .animation(.default)
        .frame( height: 45)
        .font(.system(size: 20))
        .padding(12)
        .disableAutocorrection(true)
        .background(
            Color.white
        ).foregroundColor(.black)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.099), radius: 3)
        
    }
}
struct SliderView: View {
    @Binding var minFee :CGFloat
    @Binding var maxFee :CGFloat
    var range :Int
    @Binding var percentage :Float

    
    var totalWith = UIScreen.main.bounds.width - 50
    var body: some View {
        
        VStack {
            GeometryReader { geometry in
                
                VStack {
                    ZStack(alignment:.leading){
                        Capsule()
                            .fill(Color.black.opacity(0.20))
                            .frame(height:4)
                        
                        Capsule()
                            .fill(Color.black)
                            .frame(height:4)
                            .frame(width: geometry.size.width * CGFloat(self.percentage / Float( range)))

        //                    .offset(x: self.width+15)
                        
        //                HStack(spacing:0){
        //                    Circle()
        //                        .fill(Color.blue)
        //                        .frame(width: 15, height: 15)
        //                        .offset(x: self.width)
        //                        .gesture(
        //                            DragGesture()
        //                                .onChanged({ (Value) in
        //                                    if Value.location.x <= 0 && Value.location.x <= self.width1{
        //                                    self.width = Value.location.x
        //                                    }
        //                                })
        //                        )
                            
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 15, height: 15)
                                .background(Circle().stroke(Color.red.opacity(0.55), lineWidth:2))
                                .offset(x: geometry.size.width * CGFloat(self.percentage / Float( range)))
        //                        .offset(x: width)

                                .gesture(DragGesture(minimumDistance: 0)
                                .onChanged({ value in
                                    self.percentage = Float(minFee)+(min(max(0, Float(value.location.x / geometry.size.width * CGFloat( range) )), Float(range)))
                                    print(self.percentage)
                                }))
                            
        //                }
                        
                        
                    }
                }
                .frame(height:55)
            }
            .frame(height:55)
        }
        .frame(height:55)

    }

}
func getval(val:CGFloat)->String{
    return String(format: "%.2f", val)
}
struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            SliderView(minFee:.constant(0),maxFee:.constant(120), range: 50, percentage: .constant(12))
        }.navigationBarHidden(true)
    }
}


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
//                    .frame(height:55)
//                    .padding(.vertical,20)

                }
//                .frame(height:55)
//                .padding()

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




struct LockerSlider<V>: View where V : BinaryFloatingPoint, V.Stride : BinaryFloatingPoint {

    // MARK: - Value
    // MARK: Private
    @Binding private var value: V
    private let bounds: ClosedRange<V>
    private let step: V.Stride

    private let length: CGFloat    = 50
    private let lineWidth: CGFloat = 2

    @State private var ratio: CGFloat   = 0
    @State private var startX: CGFloat? = nil


    // MARK: - Initializer
    init(value: Binding<V>, in bounds: ClosedRange<V>, step: V.Stride = 1) {
        _value  = value
    
        self.bounds = bounds
        self.step   = step
    }


    // MARK: - View
    // MARK: Public
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                // Track
                RoundedRectangle(cornerRadius: length / 2)
                    .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
            
                // Thumb
                Circle()
                    .foregroundColor(.white)
                    .frame(width: length, height: length)
                    .offset(x: (proxy.size.width - length) * ratio)
                    .gesture(DragGesture(minimumDistance: 0)
                                .onChanged({ updateStatus(value: $0, proxy: proxy) })
                                .onEnded { _ in startX = nil })
            }
            .frame(height: length)
            .overlay(overlay)
            .simultaneousGesture(DragGesture(minimumDistance: 0)
                                    .onChanged({ update(value: $0, proxy: proxy) }))
            .onAppear {
                ratio = min(1, max(0,CGFloat(value / bounds.upperBound)))
            }
        }
    }

    // MARK: Private
    private var overlay: some View {
        RoundedRectangle(cornerRadius: (length + lineWidth) / 2)
            .stroke(Color.gray, lineWidth: lineWidth)
            .frame(height: length + lineWidth)
    }


    // MARK: - Function
    // MARK: Private
    private func updateStatus(value: DragGesture.Value, proxy: GeometryProxy) {
        guard startX == nil else { return }
    
        let delta = value.startLocation.x - (proxy.size.width - length) * ratio
        startX = (length < value.startLocation.x && 0 < delta) ? delta : value.startLocation.x
    }

    private func update(value: DragGesture.Value, proxy: GeometryProxy) {
        guard let x = startX else { return }
        startX = min(length, max(0, x))
    
        var point = value.location.x - x
        let delta = proxy.size.width - length
    
        // Check the boundary
        if point < 0 {
            startX = value.location.x
            point = 0
        
        } else if delta < point {
            startX = value.location.x - delta
            point = delta
        }
    
        // Ratio
        var ratio = point / delta
    
    
        // Step
        if step != 1 {
            let unit = CGFloat(step) / CGFloat(bounds.upperBound)
        
            let remainder = ratio.remainder(dividingBy: unit)
            if remainder != 0 {
                ratio = ratio - CGFloat(remainder)
            }
        }
    
        self.ratio = ratio
        self.value = V(bounds.upperBound) * V(ratio)
    }
}
