//
//  CalendarPopup.swift
//  SalamTak
//
//  Created by wecancity on 03/01/2023.
//

import Foundation
import SwiftUI

enum dateRange {
    case open, withstart, withend, close
}

struct CalendarPopup:View{
    
    @Binding var selectedDate : Date
    @Binding var isPresented : Bool
    var displayedcomponent : DatePickerComponents?
    var rangeType:dateRange = .open
    var startingDate = Date()
    var endingDate = Date()

    var body: some View{
        if isPresented{
            ZStack {
                Color.black.opacity(0.3)
//                VisualEffectBlur(blurStyle: .systemThinMaterialDark,vibrancyStyle: .fill){}
//                    .opacity(0.9)
            }
            .ignoresSafeArea()
//            .frame(width: UIScreen.main.bounds.width, alignment: .center)
//                .background(
//                    Color.black.opacity(0.2)
//                        .blur(radius: 0.2)
//                )
                .onTapGesture(perform: {
                    isPresented = false
                })
                .overlay(
                    VStack {
//                        DatePicker("", selection: $selectedDate, in: startingDate...endingDate, displayedComponents: [.date])
                        Spacer()
                        Group{
                        switch rangeType {
                        case .open:
                            DatePicker("", selection: $selectedDate, displayedComponents: [.date])

                        case .withstart:
                            DatePicker("", selection: $selectedDate, in: startingDate... , displayedComponents: [.date])
                        case .withend:
                            DatePicker("", selection: $selectedDate, in: ...endingDate, displayedComponents: [.date])

                        case .close:
                            DatePicker("", selection: $selectedDate, in:  startingDate...endingDate , displayedComponents: [.date])

                        }
                        }
                            .datePickerStyle(WheelDatePickerStyle())
                            .background(.white)
                            .cornerRadius(12)
                            .padding(.horizontal)
                        
//                        GradientButton(action: {
//                                isPresented = false
//                        },Title: "Done".localized(language) , IsDisabled:.constant(false)
//                        )
                        ButtonView(text: "Done".localized(language), action: {
//                            withAnimation(.easeIn(duration: 0.3)) {
                                isPresented =  false
//                            }
                        })
                            .padding(.horizontal)
                        
                }
                .shadow(color: .black.opacity(0.3), radius: 12)
                          .onChange(of: selectedDate){_ in
      //                        isPresented = false
                      }
                )
            
        }
    }
}
struct CalendarPopup_Previews: PreviewProvider {
    static var previews: some View {
        CalendarPopup(selectedDate: .constant(Date()), isPresented: .constant(true))
    }
}


/*
The iOS implementation of a UIVisualEffectView's blur and vibrancy.
*/

//
//// MARK: - VisualEffectBlur
//
//struct VisualEffectBlur<Content: View>: View {
//    var blurStyle: UIBlurEffect.Style
//    var vibrancyStyle: UIVibrancyEffectStyle?
//    var content: Content
//
//    init(blurStyle: UIBlurEffect.Style = .systemMaterial, vibrancyStyle: UIVibrancyEffectStyle? = nil, @ViewBuilder content: () -> Content) {
//        self.blurStyle = blurStyle
//        self.vibrancyStyle = vibrancyStyle
//        self.content = content()
//    }
//
//    var body: some View {
//        Representable(blurStyle: blurStyle, vibrancyStyle: vibrancyStyle, content: ZStack { content })
//            .accessibility(hidden: Content.self == EmptyView.self)
//    }
//}
//
//// MARK: - Representable
//
//extension VisualEffectBlur {
//    struct Representable<Content: View>: UIViewRepresentable {
//        var blurStyle: UIBlurEffect.Style
//        var vibrancyStyle: UIVibrancyEffectStyle?
//        var content: Content
//
//        func makeUIView(context: Context) -> UIVisualEffectView {
//            context.coordinator.blurView
//        }
//
//        func updateUIView(_ view: UIVisualEffectView, context: Context) {
//            context.coordinator.update(content: content, blurStyle: blurStyle, vibrancyStyle: vibrancyStyle)
//        }
//
//        func makeCoordinator() -> Coordinator {
//            Coordinator(content: content)
//        }
//    }
//}
//
//// MARK: - Coordinator
//
//extension VisualEffectBlur.Representable {
//    class Coordinator {
//        let blurView = UIVisualEffectView()
//        let vibrancyView = UIVisualEffectView()
//        let hostingController: UIHostingController<Content>
//
//        init(content: Content) {
//            hostingController = UIHostingController(rootView: content)
//            hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            hostingController.view.backgroundColor = nil
//            blurView.contentView.addSubview(vibrancyView)
//            blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            vibrancyView.contentView.addSubview(hostingController.view)
//            vibrancyView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        }
//
//        func update(content: Content, blurStyle: UIBlurEffect.Style, vibrancyStyle: UIVibrancyEffectStyle?) {
//            hostingController.rootView = content
//            let blurEffect = UIBlurEffect(style: blurStyle)
//            blurView.effect = blurEffect
//            if let vibrancyStyle = vibrancyStyle {
//                vibrancyView.effect = UIVibrancyEffect(blurEffect: blurEffect, style: vibrancyStyle)
//            } else {
//                vibrancyView.effect = nil
//            }
//            hostingController.view.setNeedsDisplay()
//        }
//    }
//}
//
//// MARK: - Content-less Initializer
//
//extension VisualEffectBlur where Content == EmptyView {
//    init(blurStyle: UIBlurEffect.Style = .systemMaterial) {
//        self.init( blurStyle: blurStyle, vibrancyStyle: nil) {
//            EmptyView()
//        }
//    }
//}
//
//// MARK: - Previews
//
//struct VisualEffectBlur_Previews: PreviewProvider {
//    static var previews: some View {
//        ZStack {
//            LinearGradient(
//                gradient: Gradient(colors: [.red, .blue]),
//                startPoint: .topLeading,
//                endPoint: .bottomTrailing
//            )
//
//            VisualEffectBlur(blurStyle: .systemUltraThinMaterial, vibrancyStyle: .fill) {
//                Text("Hello World!")
//                    .frame(width: 200, height: 100)
//            }
//        }
//        .previewLayout(.sizeThatFits)
//    }
//}
