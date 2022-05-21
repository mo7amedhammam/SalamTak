//
//  ViewModelGetCities.swift
//  SalamTech-DR
//
//  Created by Mohamed Hammam on 27/01/2022.
//

import Foundation
import Combine
import SwiftUI

class ViewModelGetCities: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<ModelCities, Error>()
    let passthroughModelSubject1 = PassthroughSubject<ModelCitYByCityId, Error>()

    private var cancellables: Set<AnyCancellable> = []
    

    @Published var CountryId: Int = 0
    @Published var CityId: Int = 0

    
//    //------- output
//    @Published var isValid = false
//    @Published var inlineErrorPassword = ""
    @Published var publishedCityModel: [City] = []
    
    @Published var publishedCityInfoByIdModel: CityInfo?

    @Published var isLoading:Bool? = false
    @Published var isError = false
    @Published var errorMsg = ""
    @Published var IsDone = false
    @Published var isNetworkError = false
 
    init() {
        
        passthroughModelSubject.sink { (completion) in
        } receiveValue: { (modeldata) in
            self.publishedCityModel = modeldata.Data ?? []
            print(self.publishedCityModel)
           // print(self.publishedCityModel[0].Name ?? "" )
        }.store(in: &cancellables)
        
        passthroughModelSubject1.sink { (completion) in
        } receiveValue: { (modeldata) in
            self.publishedCityInfoByIdModel = modeldata.Data
           // print(self.publishedCityModel[0].Name ?? "" )
        }.store(in: &cancellables)
        
    }
    
   func startFetchCities(countryid:Int?) {

        if Helper.isConnectedToNetwork(){
            GetCitiesApiService.GetCities(
                CountryId: countryid ?? 0 , completion:  { (success, model, err) in
            
                self.isLoading = true
            if success{
                DispatchQueue.main.async {
                    self.IsDone = true
                    self.isLoading = false
                    self.passthroughModelSubject.send(model!)
//                    print(model!)
                }
            }else{
                self.isLoading = false
                self.isError = true
                print(model?.Message ?? "")
                self.errorMsg = err ?? "cannot get cities"
            }
        })

        }else{
                   // Alert with no internet connection
            self.isLoading = false
          isNetworkError = true
               }
    }

    
    func GetCityInfoById(cityId:Int) {

        if Helper.isConnectedToNetwork(){
            GetCitiesApiService.GetCityByCityId(cityId: cityId, completion:  { (success, model, err) in
         self.isLoading = true
            if success{
                DispatchQueue.main.async {
                    self.IsDone = true
                    self.isLoading = false
                    self.passthroughModelSubject1.send(model!)
//                    print(model!)
                }
            }else{
                self.isLoading = false
                self.isError = true
                print(model?.Message ?? "")
                self.errorMsg = err ?? "cannot get city info by id"
            }
        })

        }else{
                   // Alert with no internet connection
            self.isLoading = false
          isNetworkError = true
               }
    }
    
    
}


