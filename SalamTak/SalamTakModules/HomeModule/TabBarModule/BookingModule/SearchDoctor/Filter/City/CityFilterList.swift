//
//  CityFilterList.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 05/06/2022.
//

import Foundation
import SwiftUI
import Combine
struct CityFilterList:View{
    @EnvironmentObject var CitiesVM : ViewModelGetCities
    @Binding var FilterTag:FilterCases
    @Binding var selectedFilterCityName :String?
    @Binding var selectedFilterCityId :Int?
    @Binding var CitybuttonSelected: Int?
    
    var body: some View{
        VStack {
            Text("City".localized(language))
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
                ForEach(0..<CitiesVM.publishedCityModel.count, id:\.self) { button in
                    HStack {
                        Spacer().frame(width:30)
                        Button(action: {
                            self.CitybuttonSelected = button
                            print("SelectedID is \(self.CitiesVM.publishedCityModel[button].Id ?? 0)")
                            
                            self.selectedFilterCityId = self.CitiesVM.publishedCityModel[button].Id ?? 0
                            self.selectedFilterCityName = self.CitiesVM.publishedCityModel[button].Name ?? ""
                            
                        }, label: {
                            HStack{
                                Image(systemName:  self.CitybuttonSelected == button ? "checkmark.circle.fill" :"circle" )
                                    .font(.system(size: 20))
                                    .foregroundColor(self.CitybuttonSelected == button ? Color("blueColor") : Color("lightGray"))
                                Text(self.CitiesVM.publishedCityModel[button].Name ?? "")  .padding()
                                    .foregroundColor(self.CitybuttonSelected == button ? Color("blueColor") : Color("lightGray"))
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
            CitiesVM.CountryId = 1
            CitiesVM.startFetchCities()
        })
    }
}

struct CityFilterList_Previews: PreviewProvider {
    static var previews: some View {
        CityFilterList( FilterTag: .constant(.City), selectedFilterCityName: .constant(""), selectedFilterCityId: .constant(0), CitybuttonSelected: .constant(0))
            .environmentObject(ViewModelGetCities())
    }
}
