//
//  seniorityBuView.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 05/06/2022.
//

import Foundation
import SwiftUI

struct SeniorityBtn: View {
    var language = LocalizationService.shared.language
    var seniorityLvl : subspeciality
    @Binding var selectedSenLvlName : [String]
    @Binding var selectedSenLvlId : [Int]
    @State var isTapped : Bool? = false
    
    var body: some View {
        Button(action: {
            isTapped?.toggle()
            if selectedSenLvlId == []{
                self.selectedSenLvlId.insert(seniorityLvl.id ?? 0, at: 0)
                self.selectedSenLvlName.insert(seniorityLvl.Name ?? "", at: 0)
            } else{
                
                if self.selectedSenLvlId.contains(seniorityLvl.id ?? 0) && self.selectedSenLvlName.contains(seniorityLvl.Name ?? "") {
                    self.selectedSenLvlId.removeAll(where: {$0 == seniorityLvl.id
                    })
                    self.selectedSenLvlName.removeAll(where: {$0 == seniorityLvl.Name
                    })
                }else{
                    self.selectedSenLvlId.append(seniorityLvl.id ?? 0)
                    self.selectedSenLvlName.append(seniorityLvl.Name ?? "")
                }
            }
         
        }, label: {
            
                HStack (spacing: 20 ){
                    
                    Image(systemName: isTapped ?? false ? "checkmark.rectangle.fill": "checkmark.rectangle")
                        .foregroundColor( isTapped ?? false ? Color("blueColor") :Color("lightGray"))
                    Text(seniorityLvl.Name ?? "")
                        .font(.system(size: 20))
                        .foregroundColor( isTapped ?? false ? Color("blueColor") :Color("lightGray"))
                    
                    Spacer()
                    
                }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                
                .padding([.top,.bottom],5)
                .padding([.leading,.trailing],10)           

        })
            .onAppear(perform: {
                for id  in selectedSenLvlId {
                    if seniorityLvl.id == id {
                    self.isTapped = true
                }
                }
            })
    }
}
struct SeniorityBtn_Previews: PreviewProvider {
    static var previews: some View {
        SeniorityBtn(seniorityLvl: subspeciality.init(id: 1, Name: "title"), selectedSenLvlName: .constant([""]), selectedSenLvlId: .constant([0]))
    }
}
