//
//  ViewModelGetCountries.swift
//  SalamTech-DR
//
//  Created by wecancity on 16/01/2022.
//

import Foundation
import Combine

class ViewModelFoodAllergy: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<ModelFoodAllergy, Error>()
    private var cancellables: Set<AnyCancellable> = []
    @Published  var Id : [Int] = []
    @Published  var Name: [String] = []

    @Published private(set) var publishedCountryModel: [FoodAllergy] = []
    @Published var isLoading = false
    @Published var isError = false
    @Published var errorMsg = ""
    @Published var UserCreated = false
    @Published var isNetworkError = false
 
    init() {
        passthroughModelSubject.sink { (completion) in
        } receiveValue: { (modeldata) in
            self.publishedCountryModel = modeldata.Data ?? []
            print(self.publishedCountryModel)
            print(self.publishedCountryModel[0].Name ?? "" )
            
        }.store(in: &cancellables)
        
        //-----------------------------------------------------------------
        //        passthroughSubject
        //            .dropFirst(2)
        //            .filter({ (value) -> Bool in
        //                value != "5"
        //            })
        //            .map { value in
        //                return value + " seconds"
        //            }
        //            .sink { (completion) in
        //                switch completion {
        //                case .finished:
        //                    self.time = "Finished"
        //                case .failure(let err):
        //                    self.time = err.localizedDescription
        //                }
        //            } receiveValue: { (value) in
        //                self.time = value
        //            }
        //            .store(in: &cancellables)
        //
        //-------------------------------------------------------
        
    }
    
    
  
    
    func startFetchFoodAllergy() {

        if Helper.isConnectedToNetwork(){
            GetFoodAllergyApiService.GetFoodAllergy(
                completion:  { (success, model, err) in
                
            
                self.isLoading = true
            if success{
                DispatchQueue.main.async {
                    self.UserCreated = true
                    self.isLoading = false
                    self.passthroughModelSubject.send(model!)
//                    print(model!)
                }
            }else{
                self.isLoading = false
                self.isError = true
                print(model?.Message ?? "")
                self.errorMsg = err ?? "cannot get countries"
            }
        })

        }else{
                   // Alert with no internet connection
            self.isLoading = false
          isNetworkError = true
               }
    }
    
    
}
