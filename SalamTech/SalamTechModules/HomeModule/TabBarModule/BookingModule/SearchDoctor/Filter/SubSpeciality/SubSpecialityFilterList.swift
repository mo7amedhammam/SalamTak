//
//  SubSpecialityFilterList.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 05/06/2022.
//

import Foundation
import SwiftUI
import Combine
struct SubSpecialityFilterList:View{

    @EnvironmentObject var SubSpecialityVM : ViewModelSubspeciality

    @Binding var FilterTag:FilterCases

    @Binding var SpecialistId:Int
    @Binding var selectedSpecLvlId :Int?
    @Binding var selectedSubSpecLvlNames : [String]
    @Binding var selectedSubSpecLvlIds : [Int]


    var body:some View{
        VStack {
            Text("Sub_Specialities".localized(language))
                .font(.system(size: 18))
                .fontWeight(.bold)
            //                    }
            ScrollView {
                ForEach(0..<SubSpecialityVM.publishedSubSpecialistModel.count, id:\.self) { button in
                    HStack {
                        Spacer().frame(width:30)
                        //
                        
                        SeniorityBtn(seniorityLvl: SubSpecialityVM.publishedSubSpecialistModel[button], selectedSenLvlName: $selectedSubSpecLvlNames, selectedSenLvlId: $selectedSubSpecLvlIds)
                        
                        
                    }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                }
            }
            
            
            Button(action: {
                // add review
                print("Confirm Title")
                FilterTag = .Menu
                //                                showFilter.toggle()
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
        .onAppear(perform: {
            SubSpecialityVM.SpecialistId = selectedSpecLvlId ?? SpecialistId
            SubSpecialityVM.startFetchSubSpecialist()
        })

    }
}

