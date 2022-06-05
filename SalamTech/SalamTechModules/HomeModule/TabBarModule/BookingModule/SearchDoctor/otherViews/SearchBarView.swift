//
//  SearchBarView.swift
//  SalamTak
//
//  Created by wecancity on 05/06/2022.
//

import Foundation
import SwiftUI

struct SearchBar: View {
    var language = LocalizationService.shared.language

    var PlaceHolder = ""
    @Binding var text: String
    
    @State private var isEditing = false
    @Binding  var isSearch : Bool
    var action: () -> Void
    
    var body: some View {
        HStack {
            
            TextField(PlaceHolder, text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
                .submitLabel(.search)
                .onSubmit {
                    action()
                    //                    isSearch = true
                    //                    isEditing = false
                }
            
            //            if text != "" || !text.isEmpty{
            //                            Button(action: {
            //                                self.isEditing = false
            //                                self.text = ""
            //                   self.isSearch = false
            //            action()
            
            //                     UIApplication.shared.dismissKeyboard()
            //                            }) {
            //                                Text("Cancel")
            //                            }
            //                            .padding(.trailing, 10)
            //                            .transition(.move(edge: .trailing))
            //                            .animation(.default)
            //                        }
        }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)

        
        .overlay(
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 15)
                
                if  text != "" || !text.isEmpty{
                    Button(action: {
                        self.text = ""
                        self.isEditing = false
                        action()
                        
                        UIApplication.shared.dismissKeyboard()
                    }) {
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(.gray)
                            .padding(.trailing, 15)
                    }
                }
            }
        )
    }
}

