//
//  SpecialityFilterList.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 05/06/2022.
//

import Foundation
import SwiftUI
import Combine

struct SpecialityFilterList: View {
    @EnvironmentObject var specialityvm : ViewModelSpecialist
    @Binding var FilterTag:FilterCases
    
    @Binding var SpecialistId:Int
    @Binding var selectedSpecLvlName :String?
    @Binding var selectedSpecLvlId :Int?
    @Binding var SpecbuttonSelected: Int?
    
    var body: some View {
        VStack{
            Text("Speciality".localized(language))
                .font(.system(size: 18))
                .fontWeight(.bold)
            ScrollView {
                ForEach(0..<(specialityvm.publishedSpecialistModel?.count ?? 0), id:\.self) { button in
                    HStack {
                        Spacer().frame(width:30)
                        Button(action: {
                            self.SpecbuttonSelected = button
                            print("SelectedID is \(self.specialityvm.publishedSpecialistModel?[button].id ?? 0)")
                            
                            self.selectedSpecLvlId = self.specialityvm.publishedSpecialistModel?[button].id ?? 0
                            self.selectedSpecLvlName = self.specialityvm.publishedSpecialistModel?[button].Name ?? ""
                            
                        }, label: {
                            HStack{
                                Image(systemName:  self.SpecbuttonSelected == button ? "checkmark.circle.fill" :"circle" )
                                    .font(.system(size: 20))
                                    .foregroundColor(self.SpecbuttonSelected == button ? Color("blueColor") : Color("lightGray"))
                                Text(self.specialityvm.publishedSpecialistModel?[button].Name ?? "")  .padding()
                                    .foregroundColor(self.SpecbuttonSelected == button ? Color("blueColor") : Color("lightGray"))
                                Spacer()
                            }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                        })
                    }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                }
            }
            
            Button(action: {
                // add review
                print("Confirm Title")
                FilterTag = .Menu
            }, label: {
                HStack {
                    Text("Confirm".localized(language))
                        .fontWeight(.semibold)
                        .font(.title3)
                }.environment(\.layoutDirection, language.rawValue == "en" ? .leftToRight : .rightToLeft)
                
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
            
        }.onAppear(perform: {
            specialityvm.startFetchSpecialist()
        })
    }
}

struct SpecialityFilterList_Previews: PreviewProvider {
    static var previews: some View {
        SpecialityFilterList( FilterTag: .constant(.Speciality), SpecialistId: .constant(1), selectedSpecLvlName: .constant(""), selectedSpecLvlId: .constant(2), SpecbuttonSelected: .constant(4))
            .environmentObject(ViewModelSpecialist())
    }
}
