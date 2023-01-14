//
//  RangeSliderView.swift
//  SalamTak
//
//  Created by wecancity on 12/01/2023.
//

import SwiftUI
import Combine

struct RangeSliderView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var isActive: Bool = false
    let sliderPositionChanged: (ClosedRange<Float>) -> Void

    var body: some View {
        GeometryReader { geometry in
            sliderView(sliderSize: geometry.size,
                       sliderViewYCenter: geometry.size.height / 2)
        }
        .frame(width:300,height: 30)
    }

    @ViewBuilder private func sliderView(sliderSize: CGSize, sliderViewYCenter: CGFloat) -> some View {
        lineBetweenThumbs(from: viewModel.leftThumbLocation(width: sliderSize.width, sliderViewYCenter: sliderViewYCenter),to: viewModel.rightThumbLocation(width: sliderSize.width, sliderViewYCenter: sliderViewYCenter))

        thumbView(position: viewModel.leftThumbLocation(width: sliderSize.width,sliderViewYCenter: sliderViewYCenter),
                  value: Float(viewModel.sliderPosition.lowerBound))
        .highPriorityGesture(DragGesture()
                                .onChanged { dragValue in
            let newValue = viewModel.newThumbLocation(dragLocation: dragValue.location, width: sliderSize.width)
            
            if newValue < viewModel.sliderPosition.upperBound {
                viewModel.sliderPosition = newValue...viewModel.sliderPosition.upperBound
                sliderPositionChanged(viewModel.sliderPosition)
                isActive = true
            }
        })

        thumbView(position: viewModel.rightThumbLocation(width: sliderSize.width, sliderViewYCenter: sliderViewYCenter),value: Float(viewModel.sliderPosition.upperBound))
        .highPriorityGesture(DragGesture()
                                .onChanged { dragValue in
            let newValue = viewModel.newThumbLocation(dragLocation: dragValue.location, width: sliderSize.width)
            
            if newValue > viewModel.sliderPosition.lowerBound {
                viewModel.sliderPosition = viewModel.sliderPosition.lowerBound...newValue
                sliderPositionChanged(viewModel.sliderPosition)
                isActive = true
            }
        })
    }

    @ViewBuilder func lineBetweenThumbs(from: CGPoint, to: CGPoint) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .fill( Color.gray.opacity(0.3))
                .frame(height: 4)

            Path { path in
                path.move(to: from)
                path.addLine(to: to)
            }
            .stroke(isActive ? Color.salamtackWelcome :.salamtackWelcome.opacity(0.7),
                    lineWidth: 4)
        }
    }

    @ViewBuilder func thumbView(position: CGPoint, value: Float) -> some View {
     Circle()
//        .frame(size: .rangeSliderThumb)
        .foregroundColor(isActive ? .salamtackWelcome :.salamtackWelcome)
        .contentShape(Rectangle())
        .position(x: position.x, y: position.y)
        .animation(.spring(), value: isActive)
    }
}

extension RangeSliderView {
    final class ViewModel: ObservableObject {
        @Published var sliderPosition: ClosedRange<Float>
        let sliderBounds: ClosedRange<Int>
        let sliderBoundDifference: Int
        init(sliderPosition: ClosedRange<Float>,
             sliderBounds: ClosedRange<Int>) {
            self.sliderPosition = sliderPosition
            self.sliderBounds = sliderBounds
            self.sliderBoundDifference = sliderBounds.count - 1
        }

        func leftThumbLocation(width: CGFloat, sliderViewYCenter: CGFloat = 0) -> CGPoint {
            let sliderLeftPosition = CGFloat(sliderPosition.lowerBound - Float(sliderBounds.lowerBound))
            return .init(x: sliderLeftPosition * stepWidthInPixel(width: width), y: sliderViewYCenter)
        }

        func rightThumbLocation(width: CGFloat, sliderViewYCenter: CGFloat = 0) -> CGPoint {
            let sliderRightPosition = CGFloat(sliderPosition.upperBound - Float(sliderBounds.lowerBound))
            
            return .init(x: sliderRightPosition * stepWidthInPixel(width: width),
                         y: sliderViewYCenter)
        }

        func newThumbLocation(dragLocation: CGPoint, width: CGFloat) -> Float {
            let xThumbOffset = min(max(0, dragLocation.x), width)
            return Float(sliderBounds.lowerBound) + Float(xThumbOffset / stepWidthInPixel(width: width))
        }

        private func stepWidthInPixel(width: CGFloat) -> CGFloat {
            width / CGFloat(sliderBoundDifference)
        }
    }
}

struct RangeSlider_Previews: PreviewProvider {
    static var previews: some View {
        RangeSliderView(viewModel: .init(sliderPosition: 2...8,
                                     sliderBounds: 1...10),
                    sliderPositionChanged: { _ in })
    }
}


//SliderValue to restrict double range: 0.0 to 1.0
@propertyWrapper
struct SliderValue {
    var value: Double
    
    init(wrappedValue: Double) {
        self.value = wrappedValue
    }
    
    var wrappedValue: Double {
        get { value }
        set { value = min(max(0.0, newValue), 1.0) }
    }
}

class SliderHandle: ObservableObject {
    
    //Slider Size
    let sliderWidth: CGFloat
    let sliderHeight: CGFloat
    
    //Slider Range
    let sliderValueStart: Double
    let sliderValueRange: Double
    
    //Slider Handle
    var diameter: CGFloat = 40
    var startLocation: CGPoint
    
    //Current Value
    @Published var currentPercentage: SliderValue
    
    //Slider Button Location
    @Published var onDrag: Bool
    @Published var currentLocation: CGPoint
        
    init(sliderWidth: CGFloat, sliderHeight: CGFloat, sliderValueStart: Double, sliderValueEnd: Double, startPercentage: SliderValue) {
        self.sliderWidth = sliderWidth
        self.sliderHeight = sliderHeight
        
        self.sliderValueStart = sliderValueStart
        self.sliderValueRange = sliderValueEnd - sliderValueStart
        
        let startLocation = CGPoint(x: (CGFloat(startPercentage.wrappedValue)/1.0)*sliderWidth, y: sliderHeight/2)
        
        self.startLocation = startLocation
        self.currentLocation = startLocation
        self.currentPercentage = startPercentage
        
        self.onDrag = false
    }
    
    lazy var sliderDragGesture: _EndedGesture<_ChangedGesture<DragGesture>>  = DragGesture()
        .onChanged { value in
            self.onDrag = true
            
            let dragLocation = value.location
            
            //Restrict possible drag area
            self.restrictSliderBtnLocation(dragLocation)
            
            //Get current value
            self.currentPercentage.wrappedValue = Double(self.currentLocation.x / self.sliderWidth)
            
        }.onEnded { _ in
            self.onDrag = false
        }
    
    private func restrictSliderBtnLocation(_ dragLocation: CGPoint) {
        //On Slider Width
        if dragLocation.x > CGPoint.zero.x && dragLocation.x < sliderWidth {
            calcSliderBtnLocation(dragLocation)
        }
    }
    
    private func calcSliderBtnLocation(_ dragLocation: CGPoint) {
        if dragLocation.y != sliderHeight/2 {
            currentLocation = CGPoint(x: dragLocation.x, y: sliderHeight/2)
        } else {
            currentLocation = dragLocation
        }
    }
    
    //Current Value
    var currentValue: Double {
        return sliderValueStart + currentPercentage.wrappedValue * sliderValueRange
    }
}

class CustomSlider: ObservableObject {
    
    //Slider Size
    let width: CGFloat = 300
    let lineWidth: CGFloat = 8
    
    //Slider value range from valueStart to valueEnd
    let valueStart: Double
    let valueEnd: Double
    
    //Slider Handle
    @Published var highHandle: SliderHandle
    @Published var lowHandle: SliderHandle
    
    //Handle start percentage (also for starting point)
    @SliderValue var highHandleStartPercentage = 1.0
    @SliderValue var lowHandleStartPercentage = 0.0

    var anyCancellableHigh: AnyCancellable?
    var anyCancellableLow: AnyCancellable?
    
    init(start: Double, end: Double) {
        valueStart = start
        valueEnd = end
        
        highHandle = SliderHandle(sliderWidth: width,
                                  sliderHeight: lineWidth,
                                  sliderValueStart: valueStart,
                                  sliderValueEnd: valueEnd,
                                  startPercentage: _highHandleStartPercentage
                                )
        
        lowHandle = SliderHandle(sliderWidth: width,
                                  sliderHeight: lineWidth,
                                  sliderValueStart: valueStart,
                                  sliderValueEnd: valueEnd,
                                  startPercentage: _lowHandleStartPercentage
                                )
        
        anyCancellableHigh = highHandle.objectWillChange.sink { _ in
            self.objectWillChange.send()
        }
        anyCancellableLow = lowHandle.objectWillChange.sink { _ in
            self.objectWillChange.send()
        }
    }
    
    //Percentages between high and low handle
    var percentagesBetween: String {
        return String(format: "%.2f", highHandle.currentPercentage.wrappedValue - lowHandle.currentPercentage.wrappedValue)
    }
    
    //Value between high and low handle
    var valueBetween: String {
        return String(format: "%.2f", highHandle.currentValue - lowHandle.currentValue)
    }
}


struct SliderView: View {
    @ObservedObject var slider: CustomSlider
    
    var body: some View {
        RoundedRectangle(cornerRadius: slider.lineWidth)
            .fill(Color.gray.opacity(0.2))
            .frame(width: slider.width, height: slider.lineWidth)
            .overlay(
                ZStack {
                    //Path between both handles
                    SliderPathBetweenView(slider: slider)
                    
                    //Low Handle
                    SliderHandleView(handle: slider.lowHandle)
                        .highPriorityGesture(slider.lowHandle.sliderDragGesture)
                    
                    //High Handle
                    SliderHandleView(handle: slider.highHandle)
                        .highPriorityGesture(slider.highHandle.sliderDragGesture)
                }
            )
    }
}

struct SliderHandleView: View {
    @ObservedObject var handle: SliderHandle
    
    var body: some View {
        Circle()
            .frame(width: handle.diameter, height: handle.diameter)
            .foregroundColor(.white)
            .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 0)
            .scaleEffect(handle.onDrag ? 1.3 : 1)
            .contentShape(Rectangle())
            .position(x: handle.currentLocation.x, y: handle.currentLocation.y)
    }
}

struct SliderPathBetweenView: View {
    @ObservedObject var slider: CustomSlider
    
    var body: some View {
        Path { path in
            path.move(to: slider.lowHandle.currentLocation)
            path.addLine(to: slider.highHandle.currentLocation)
        }
        .stroke(Color.green, lineWidth: slider.lineWidth)
    }
}




struct showSliderView: View {
    @ObservedObject var slider = CustomSlider(start: 10, end: 100)
    
    var body: some View {
        VStack {
            Text("Value: " + slider.valueBetween)
            Text("Percentages: " + slider.percentagesBetween)
            
            Text("High Value: \(slider.highHandle.currentValue)")
            Text("Low Value: \(slider.lowHandle.currentValue)")
            
            //Slider
            SliderView(slider: slider)
        }
    }
}
struct showSliderView_Previews: PreviewProvider {
    static var previews: some View {
        showSliderView(slider: CustomSlider.init(start: 20, end: 50))
    }
}



struct showSliderView2 : View {
    @State var leftHandleViewState = CGSize.zero
    @State var rightHandleViewState = CGSize.zero
    var body: some View {
        let leftHandleDragGesture = DragGesture(minimumDistance: 1, coordinateSpace: .local)
            .onChanged { value in
//                guard value.location.x >= 0 && leftHandleViewState.width == rightHandleViewState.width else {
//                    return
//                }
                self.leftHandleViewState.width = value.location.x
        }
        let rightHandleDragGesture = DragGesture(minimumDistance: 1, coordinateSpace: .local)
            .onChanged { value in
//                guard value.location.x <= 0 && leftHandleViewState.width == rightHandleViewState.width else {
//                    return
//                }
                self.rightHandleViewState.width = value.location.x
        }
        return HStack(spacing: 0) {
            Circle()
                .fill(Color.yellow)
                .frame(width: 24, height: 24, alignment: .center)
                .offset(x: leftHandleViewState.width, y: 0)
                .gesture(leftHandleDragGesture)
                .zIndex(1)
            Rectangle()
                .frame(width: CGFloat(300.0), height: CGFloat(1.0), alignment: .center)
                .zIndex(0)
            Circle()
                .fill(Color.yellow)
                .frame(width: 24, height: 24, alignment: .center)
                .offset(x: rightHandleViewState.width, y: 0)
                .gesture(rightHandleDragGesture)
                .zIndex(1)
        }
    }
}

#if DEBUG
struct showSliderView2_Previews : PreviewProvider {
    static var previews: some View {
        showSliderView2()
    }
}
#endif
