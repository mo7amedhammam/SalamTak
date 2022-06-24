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

struct MedicalTextFieldInfo: View {
    @Binding var text: String
    @Binding var text1: String
    @State private var isActive = false
    var title : String
    let screenWidth = UIScreen.main.bounds.size.width - 55
    var body: some View {
        ZStack (alignment:.leading){
            HStack{
                ZStack(alignment:.leading){
                    Text(title)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .offset(y:  -20)
                        .scaleEffect( 0.8, anchor: .leading)
                    
                    TextField(isActive ? "120" : "--/--",text:isActive ? $text1 : $text)
                        .disabled(isActive)
                        .textInputAutocapitalization(.never)
                }
                
                Spacer()
                Text("Normal")
                    .font(.caption)
                    .foregroundColor(isActive ? Color("blueColor") : Color.gray)
                Toggle(isOn: $isActive) {
                }
                .toggleStyle(SwitchToggleStyle(tint: Color("blueColor")))
                .frame(width: 70)
                .padding(.trailing,10)
            }
            
        }
        .frame(width: screenWidth , height: 25)
        .font(.system(size: 13))
        .padding(12)
        .disableAutocorrection(true)
        .background(
            Color.white
        ).foregroundColor(Color("blueColor"))
            .cornerRadius(5)
            .shadow(color: Color.black.opacity(0.099), radius: 3)
        
            .onChange(of: text){ newval in
                if newval==text1{
                    isActive = true
                }
            }
        
    }
}

struct InputTextFieldMedicalInfo: View {
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
        .frame(width: screenWidth / 2, height: 25)
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
                .font(.system(size: 20))
        }
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

