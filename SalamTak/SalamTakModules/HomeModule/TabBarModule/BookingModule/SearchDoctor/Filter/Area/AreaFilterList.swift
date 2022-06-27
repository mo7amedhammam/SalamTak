//
//  AreaFilterList.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 05/06/2022.
//

import Foundation
import SwiftUI
import Combine
struct AreaFilterList:View{
    
    @EnvironmentObject var AreasVM : ViewModelGetAreas
    @EnvironmentObject var searchDoc : VMSearchDoc

    @Binding var FilterTag:FilterCases
//    @Binding var CityId:Int
//    @Binding var selectedFilterCityId :Int?
//
//    @Binding var selectedFilterAreaName :String?
//    @Binding var selectedFilterAreaId :Int?
//    @Binding var AreabuttonSelected: Int?
    
    var body: some View{
        VStack {
            Text("Area".localized(language))
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
                ForEach(AreasVM.publishedAreaModel, id:\.self) { button in
                    HStack {
                        Spacer().frame(width:30)
                        Button(action: {
//                            searchDoc.isFiltering = true
                            self.searchDoc.FilterAreaId = button.id ?? 0
                            self.searchDoc.FilterAreaName = button.Name ?? ""
                            
                        }, label: {
                            HStack{
                                Image(systemName:  self.searchDoc.FilterAreaId == button.id ? "checkmark.circle.fill" :"circle" )
                                    .font(.system(size: 20))
                                    .foregroundColor(self.searchDoc.FilterAreaId == button.id ? Color("blueColor") : Color("lightGray"))
                                Text(button.Name ?? "")  .padding()
                                    .foregroundColor(self.searchDoc.FilterAreaId == button.id ? Color("blueColor") : Color("lightGray"))
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
            AreasVM.cityId = searchDoc.FilterSpecialistId
            AreasVM.startFetchAreas()
        })
        
    }
}

struct AreaFilterList_Previews: PreviewProvider {
    static var previews: some View {
        AreaFilterList( FilterTag: .constant(.Area))
            .environmentObject(ViewModelGetAreas())
            .environmentObject(VMSearchDoc())

    }
}
