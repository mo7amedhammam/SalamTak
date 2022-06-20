//
//  FeesFilterView.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 05/06/2022.
//

import Foundation
import SwiftUI
import Combine

struct FeesFilterView:View {
    @EnvironmentObject var FeesVM : ViewModelFees
    @Binding var FilterTag:FilterCases

    @Binding var selectedFee :Float
    var body: some View{
        VStack{
            Text("Examination_Fee".localized(language))
                .font(.system(size: 18))
                .fontWeight(.bold)
            
            VStack{
                HStack{
                    FeesFilterTextField(text:.constant("\(String(FeesVM.publishedMinMaxFee?.MinimumFees ?? 0))")  , title: "Minimum".localized(language))
                        .frame(width:(UIScreen.main.bounds.width - 50)/2)
                        .disabled(true)
                    FeesFilterTextField(text: .constant("\( String(Int( Float(FeesVM.publishedMinMaxFee?.MinimumFees ?? 0) + selectedFee)) )")  , title: "Maximum".localized(language))
                        .frame(width:(UIScreen.main.bounds.width - 50)/2)
                        .disabled(true)
                }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                
                CustomView(percentage: $selectedFee, range: Int( FeesVM.publishedMinMaxFee?.MaximumFees ?? 0) - Int( 0) )
                
            }.padding()
            
            Button(action: {
                // add review
                print("Confirm Title")
                FilterTag = .Menu
            }, label: {
                HStack {
                    Text("Confirm".localized(language))
                        .fontWeight(.semibold)
                        .font(.title3)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color("blueColor"))
                .cornerRadius(12)
                .padding(.horizontal, 12)
            })
            
                .frame( height: 60)
                .padding(.horizontal)
                .padding(.bottom,10)
        }
    }
}

struct FeesFilterView_Previews: PreviewProvider {
    static var previews: some View {
        FeesFilterView( FilterTag: .constant(.Fees), selectedFee: .constant(22))
            .environmentObject(ViewModelFees())
    }
}