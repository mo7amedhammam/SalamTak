//
//  AdaptiveKeayboard.swift
//  SalamTech-DR
//
//  Created by Mohamed Hammam on 06/02/2022.
//
import SwiftUI
import Combine

extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}
extension Publishers {
    // 1.
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        // 2.
        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { $0.keyboardHeight+140 }
        
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
        
        // 3.
        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}

// From https://stackoverflow.com/a/14135456/6870041

extension UIResponder {
    static var currentFirstResponder: UIResponder? {
        _currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(UIResponder.findFirstResponder(_:)), to: nil, from: nil, for: nil)
        return _currentFirstResponder
    }

    private static weak var _currentFirstResponder: UIResponder?

    @objc private func findFirstResponder(_ sender: Any) {
        UIResponder._currentFirstResponder = self
    }

    var globalFrame: CGRect? {
        guard let view = self as? UIView else { return nil }
        return view.superview?.convert(view.frame, to: nil)
    }
}

struct KeyboardAdaptive: ViewModifier {
  @State private var bottomPadding: CGFloat = 0
      
      func body(content: Content) -> some View {
          // 1.
          GeometryReader { geometry in
              content
                  .padding(.bottom, self.bottomPadding)
                  // 2.
                  .onReceive(Publishers.keyboardHeight) { keyboardHeight in
                      // 3.
                      let keyboardTop = geometry.frame(in: .global).height - keyboardHeight
                      // 4.
                      let focusedTextInputBottom = UIResponder.currentFirstResponder?.globalFrame?.maxY ?? 0
                      // 5.
                      self.bottomPadding = max(0, focusedTextInputBottom - keyboardTop - geometry.safeAreaInsets.bottom)
              }
              // 6.
//              .animation(.easeOut(duration: 0.16))
          }
      }
}

extension View {
    func adaptsToKeyboard() -> some View {
        ModifiedContent(content: self, modifier: KeyboardAdaptive())
    }
}





import SwiftUI
import Combine

let keyboardSpaceD = KeyboardSpace()
extension View {
    func keyboardSpace() -> some View {
        modifier(KeyboardSpace.Space(data: keyboardSpaceD))
    }
}

class KeyboardSpace: ObservableObject {
    var sub: AnyCancellable?
    
    @Published var currentHeight: CGFloat = 0
    var heightIn: CGFloat = 0 {
        didSet {
            withAnimation {
                if UIWindow.keyWindow != nil {
                    //fix notification when switching from another app with keyboard
                    self.currentHeight = heightIn
                }
            }
        }
    }
    
    init() {
        subscribeToKeyboardEvents()
    }
    
    private let keyboardWillOpen = NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillShowNotification)
        .map { $0.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect }
        .map { $0.height - (UIWindow.keyWindow?.safeAreaInsets.bottom ?? 0) - 80 }
    
    private let keyboardWillHide =  NotificationCenter.default
        .publisher(for: UIResponder.keyboardWillHideNotification)
        .map { _ in CGFloat.zero }
    
    private func subscribeToKeyboardEvents() {
        sub?.cancel()
        sub = Publishers.Merge(keyboardWillOpen, keyboardWillHide)
            .subscribe(on: RunLoop.main)
            .assign(to: \.self.heightIn, on: self)
    }
    
    deinit {
        sub?.cancel()
    }
    
    struct Space: ViewModifier {
        @ObservedObject var data: KeyboardSpace
        
        func body(content: Content) -> some View {
            VStack(spacing: 0) {
                content
                
                Rectangle()
                    .foregroundColor(Color(.clear))
                    .frame(height: data.currentHeight)
                    .frame(maxWidth: .greatestFiniteMagnitude)

            }
        }
    }
}

extension UIWindow {
    static var keyWindow: UIWindow? {
        let keyWindow = UIApplication.shared.connectedScenes
            .first { $0.activationState == .foregroundActive }
            .flatMap { $0 as? UIWindowScene }?.windows
            .first { $0.isKeyWindow }
        return keyWindow
    }
}
