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
    @EnvironmentObject var searchDoc : VMSearchDoc

    @Binding var selectedSenLvlName : [String]
    @Binding var selectedSenLvlId : [Int]
    @State var isTapped : Bool? = false
    
    var body: some View {
        Button(action: {
            isTapped?.toggle()
            if searchDoc.FilterSubSpecialistId == []{
                searchDoc.FilterSubSpecialistId.insert(seniorityLvl.id ?? 0, at: 0)
                searchDoc.FilterSubSpecialistName.insert(seniorityLvl.Name ?? "", at: 0)
            } else{
                
                if searchDoc.FilterSubSpecialistId.contains(seniorityLvl.id ?? 0) && searchDoc.FilterSubSpecialistName.contains(seniorityLvl.Name ?? "") {
                    searchDoc.FilterSubSpecialistId.removeAll(where: {$0 == seniorityLvl.id
                    })
                    searchDoc.FilterSubSpecialistName.removeAll(where: {$0 == seniorityLvl.Name
                    })
                }else{
                    searchDoc.FilterSubSpecialistId.append(seniorityLvl.id ?? 0)
                    searchDoc.FilterSubSpecialistName.append(seniorityLvl.Name ?? "")
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
                for id  in searchDoc.FilterSubSpecialistId {
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
