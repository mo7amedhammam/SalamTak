//
//  BottomPopupView.swift
//  SalamTech
//
//  Created by wecancity on 14/05/2022.
//

import SwiftUI

struct BottomPopupView<Content: View>: View {
    @State private var animationAmount = 1.0

    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
//        GeometryReader { geometry in
            VStack {
                Spacer()
                content
//                    .padding(.bottom, geometry.safeAreaInsets.bottom)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(radius: 16, corners: [.topLeft, .topRight])
            }
//            .edgesIgnoringSafeArea([.bottom])
            .edgesIgnoringSafeArea(.top)
//        }
        
//        .scaleEffect(animationAmount)
//        .opacity(1.5 - animationAmount)
        
        .animation(
            .easeInOut(duration: 2)
                .repeatForever(autoreverses: false),
            value: 1.0
        )
//        .animation(.easeInOut(duration: 2.0))

//        .transition(.move(edge: .bottom))
        .transition(.opacity )
//        .transition(.asymmetric(insertion: .opacity, removal: .scale))

    }
}


struct RoundedCornersShape: Shape {
    
    let radius: CGFloat
    let corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    
    func cornerRadius(radius: CGFloat, corners: UIRectCorner = .allCorners) -> some View {
        clipShape(RoundedCornersShape(radius: radius, corners: corners))
    }
}


struct OverlayModifier<OverlayView: View>: ViewModifier {
    
    @Binding var isPresented: Bool
    let overlayView: OverlayView
    
    init(isPresented: Binding<Bool>, @ViewBuilder overlayView: @escaping () -> OverlayView) {
        self._isPresented = isPresented
        self.overlayView = overlayView()
    }
    
    func body(content: Content) -> some View {
        content.overlay(isPresented ? overlayView : nil)
    }
}

extension View {
    
    func popup<OverlayView: View>(isPresented: Binding<Bool>,
                                
                                  blurRadius: CGFloat = 3,
                                  blurAnimation: Animation? = .linear,
                                  @ViewBuilder overlayView: @escaping () -> OverlayView) -> some View {
        return blur(radius: isPresented.wrappedValue ? blurRadius : 0)
            .animation(blurAnimation)
            .allowsHitTesting(!isPresented.wrappedValue)
            .modifier(OverlayModifier(isPresented: isPresented, overlayView: overlayView))
    }
}


struct NamePopupView: View {
    
    @Binding var isPresented: Bool
    @State var text = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Enter your name")
                    .font(.system(size: 25, weight: .bold, design: .default))
                Spacer()
                Button(action: {
                    isPresented = false
                }, label: {
                    Image(systemName: "xmark")
                        .imageScale(.small)
                        .frame(width: 32, height: 32)
                        .background(Color.black.opacity(0.06))
                        .cornerRadius(16)
                        .foregroundColor(.black)
                })
            }
            TextField("", text: $text)
                .frame(height: 36)
                .padding([.leading, .trailing], 10)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
            HStack {
                Spacer()
                Button(action: {
                    isPresented = false
                }, label: {
                    Text("Done")
                })
                .frame(width: 80, height: 36)
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
        }
        .padding()
    }
}

struct NamePopupView_Previews: PreviewProvider {
    static var previews: some View {
        NamePopupView(isPresented: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}
