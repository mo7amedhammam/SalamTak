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
    @EnvironmentObject var searchDoc : VMSearchDoc

    @Binding var FilterTag:FilterCases
    
//    @Binding var SpecialistId:Int?
//    @Binding var selectedSpecLvlName :String?
//    @Binding var selectedSpecLvlId :Int?
//    @Binding var SpecbuttonSelected: Int?
    
    var body: some View {
        VStack{
            Text("Speciality".localized(language))
                .font(.system(size: 18))
                .fontWeight(.bold)
                .frame(width:UIScreen.main.bounds.width)
                .overlay(HStack{
                    Spacer()
                    Button(action: {
                        FilterTag = .Menu
                    }, label: {
                        Image(systemName: "x.circle.fill")
                            .font(.title)
                            .foregroundColor(.gray.opacity(0.6))
                    })
                }
                            .padding()
                )
            ScrollView {
                ForEach(specialityvm.publishedSpecialistModel ?? [], id:\.self) { button in
                    HStack {
                        Spacer().frame(width:30)
                        Button(action: {
//                            self.selectedSpecLvlId = button.id ?? 0
//                            self.selectedSpecLvlName = button.Name ?? ""
                            searchDoc.FilterSpecialistId = button.id ?? 0
                            searchDoc.FilterSpecialistName = button.Name ?? ""
                            
                            searchDoc.FilterSubSpecialistId = []
                            searchDoc.FilterSubSpecialistName = []

//                            searchDoc.isFiltering = false
                            
                        }, label: {
                            HStack{
                                Image(systemName:  self.searchDoc.FilterSpecialistId == button.id ? "checkmark.circle.fill" :"circle" )
                                    .font(.system(size: 20))
                                    .foregroundColor(self.searchDoc.FilterSpecialistId == button.id ? Color("blueColor") : Color("lightGray"))
                                Text(button.Name ?? "")  .padding()
                                    .foregroundColor(self.searchDoc.FilterSpecialistId == button.id ? Color("blueColor") : Color("lightGray"))
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
        SpecialityFilterList( FilterTag: .constant(.Speciality))
            .environmentObject(ViewModelSpecialist())
            .environmentObject(VMSearchDoc())

    }
}
