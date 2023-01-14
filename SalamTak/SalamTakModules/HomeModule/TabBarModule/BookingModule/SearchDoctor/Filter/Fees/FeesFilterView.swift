//
//  FeesFilterView.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 05/06/2022.
//

import Foundation
import SwiftUI

struct FeesFilterView:View {
    @StateObject var FeesVM = ViewModelFees()
    var language = LocalizationService.shared.language

    @Binding var minValue: String
    @Binding var maxValue: String
    var range:Int?
    @State var width:CGFloat = 0
    @State var width1:CGFloat = 0
    var totalwidth : CGFloat = UIScreen.main.bounds.width - 40
    
//    init(minValue:Binding<String>,maxValue:Binding<String>) {
//        self._minValue = minValue
//        self._maxValue = maxValue
//        range = 1000
//        self.width = CGFloat(Float(self.minValue) ?? 0)
//        self.width1 = CGFloat(Float(self.maxValue) ?? 0)
//    }
    
    var body: some View{
        VStack(spacing:5){
            HStack {
                Text("Fees_".localized(language))
                Spacer()
                Group{
                    Text(minValue+" "+"EGP_".localized(language))
                    Text("To_".localized(language))
                    Text(maxValue+" "+"EGP_".localized(language))
                }
                .font(.salamtakRegular(of: 15))
                .foregroundColor(.salamtackWelcome)
                Spacer()
            }
            
            CustomView(minValue: $minValue, maxValue: $maxValue,range:range,totalwidth: totalwidth)
            HStack{
                Text("\(FeesVM.publishedMinMaxFee?.MinimumFees ?? 0)"+" "+"EGP_".localized(language))
                Spacer()
                Text("\(FeesVM.publishedMinMaxFee?.MaximumFees ?? 0)"+" "+"EGP_".localized(language))
            }
            .font(.salamtakRegular(of: 15))
        }
    }
}

struct FeesFilterView_Previews: PreviewProvider {
    static var previews: some View {
        FeesFilterView(minValue: .constant("200"), maxValue: .constant("330"), range: 1000)
//            .environmentObject(VMSearchDoc())
    }
}
