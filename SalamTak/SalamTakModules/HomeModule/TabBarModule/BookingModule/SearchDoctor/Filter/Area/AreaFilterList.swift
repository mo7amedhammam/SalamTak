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
    
    @Binding var FilterTag:FilterCases
    @Binding var CityId:Int
    @Binding var selectedFilterCityId :Int?
    @Binding var selectedFilterAreaName :String?
    @Binding var selectedFilterAreaId :Int?
    @Binding var AreabuttonSelected: Int?
    
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
                ForEach(0..<AreasVM.publishedAreaModel.count, id:\.self) { button in
                    HStack {
                        Spacer().frame(width:30)
                        Button(action: {
                            self.AreabuttonSelected = button
                            print("SelectedID is \(self.AreasVM.publishedAreaModel[button].id ?? 0)")
                            
                            self.selectedFilterAreaId = self.AreasVM.publishedAreaModel[button].id ?? 0
                            self.selectedFilterAreaName = self.AreasVM.publishedAreaModel[button].Name ?? ""
                            
                        }, label: {
                            HStack{
                                Image(systemName:  self.AreabuttonSelected == button ? "checkmark.circle.fill" :"circle" )
                                    .font(.system(size: 20))
                                    .foregroundColor(self.AreabuttonSelected == button ? Color("blueColor") : Color("lightGray"))
                                Text(self.AreasVM.publishedAreaModel[button].Name ?? "")  .padding()
                                    .foregroundColor(self.AreabuttonSelected == button ? Color("blueColor") : Color("lightGray"))
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
            AreasVM.cityId = selectedFilterCityId ?? CityId
            AreasVM.startFetchAreas()
        })

    }
}

struct AreaFilterList_Previews: PreviewProvider {
    static var previews: some View {
        AreaFilterList( FilterTag: .constant(.Area), CityId: .constant(2), selectedFilterCityId: .constant(1), selectedFilterAreaName: .constant(""), selectedFilterAreaId: .constant(2), AreabuttonSelected: .constant(2))
            .environmentObject(ViewModelGetAreas())
    }
}
