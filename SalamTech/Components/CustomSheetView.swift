//
//  CustomSheetView.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 03/04/2022.
//

import SwiftUI

struct CustomActionBottomSheet: View {
    @Environment(\.presentationMode) var presentationMode

    var ConfirmTitle  = "Next"
    var CancelTitle  = "Previous"
    var Confirmaction: () -> Void
    var Cancelaction: () -> Void
    @Binding var isValid :Bool

    var body: some View {
        VStack{
            
            HStack  {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text(CancelTitle)
                        .font(.system(size: 18))
                        .padding(.horizontal,15)
                        .foregroundColor(Color("lightGray"))
                })
                Spacer()
                Button(action: Confirmaction, label: {
                    Text(ConfirmTitle)
                })
                    .foregroundColor(Color.white)
                    .padding(.vertical, 16)
                    .frame(width: 230, height: 53)
                    .background(isValid ? Color("blueColor") : Color("lightGray"))
                    .cornerRadius(5)
                    .disabled(
                         isValid == false
                    )
            }
        }
        
        .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
        .padding(.horizontal)
        .padding(.top,20)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(25)
//        .edgesIgnoringSafeArea(.bottom)
    }
}