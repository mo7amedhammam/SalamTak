//
//  InfoTextFieldView.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 03/04/2022.
//

import SwiftUI
struct InputTextFieldInfo: View {
    @Binding var text: String
    var title : String
    let screenWidth = UIScreen.main.bounds.size.width - 120
    var body: some View {
        ZStack (alignment:.leading){
            
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
                .offset(y: text.isEmpty ? 0 : -20)
                .scaleEffect(text.isEmpty ? 1 : 0.8, anchor: .leading)
            
            
            TextField("",text:$text)
                .textInputAutocapitalization(.never)
            
        }
        .animation(.default)
        .frame(width: screenWidth / 3, height: 25)
        .font(.system(size: 13))
        .padding(12)
        .disableAutocorrection(true)
        .background(
            Color.white
        ).foregroundColor(Color("blueColor"))
            .cornerRadius(5)
            .shadow(color: Color.black.opacity(0.099), radius: 3)
    }
}
struct InputTextFieldInfoArabic: View {
    @Binding var text: String
    var title : String
    let screenWidth = UIScreen.main.bounds.size.width - 120
    var body: some View {
        ZStack (alignment:.trailing){
            
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
                .offset(y: text.isEmpty ? 0 : -20)
                .scaleEffect(text.isEmpty ? 1 : 0.8, anchor: .trailing)
            
            
            TextField("",text:$text)
                .multilineTextAlignment(.trailing)
            
        }
        .animation(.default)
        .frame(width: screenWidth / 3, height: 25)
        .font(.system(size: 13))
        .padding(12)
        .disableAutocorrection(true)
        .background(
            Color.white
        ).foregroundColor(Color("blueColor"))
            .cornerRadius(5)
            .shadow(color: Color.black.opacity(0.099), radius: 3)
    }
}
