//
//  LanguageView.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 07/04/2022.
//

import SwiftUI


struct LanguageView: View {
    @Binding var selection: Int?
    var body: some View {
        VStack {
            MyRadioButtons1(selection: $selection)
        }
    }
    
}

struct LanguageView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageView(selection: .constant(1))
    }
}

struct MyRadioButton1: View {
    var id: Int
    @Binding var currentlySelectedId: Int?
    @State var text:String
    let screenWidth = UIScreen.main.bounds.size.width - 100
    
    var body: some View {
        Button(action: {
            self.currentlySelectedId = self.id
            
            if self.currentlySelectedId == 1 {
                LocalizationService.shared.language = .english_us
                Helper.setLanguage(currentLanguage: "en")
            } else if self.currentlySelectedId == 2 {
                LocalizationService.shared.language = .arabic
                Helper.setLanguage(currentLanguage: "ar")
            }
            
        }, label: {
            Text(text)
                .font(Font.SalamtechFonts.Reg14)
        })
            .foregroundColor(id == currentlySelectedId ? Color.white : .black)
            .frame(width: screenWidth / 2, height: 37)
            .background(id == currentlySelectedId ? Color("darkGreen") : Color.gray.opacity(0.1))
            .cornerRadius(10)
            .onAppear(perform: {
                if Helper.getLanguage() == "en" {
                    currentlySelectedId = 1
                } else if Helper.getLanguage() == "ar" {
                    currentlySelectedId = 2
                }
            })
    }
}


struct MyRadioButtons1: View {
    init(selection: Binding<Int?>) {
        self._currentlySelectedId = selection
    }
    @Binding var currentlySelectedId: Int?
    var body: some View {
        HStack (spacing: 20){
            MyRadioButton1(id: 2, currentlySelectedId: $currentlySelectedId , text: "العربية")
            MyRadioButton1(id: 1, currentlySelectedId: $currentlySelectedId , text: "English")
        }
        
    }
}


