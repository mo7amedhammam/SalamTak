//
//  ViewModelGetAreas.swift
//  SalamTech-DR
//
//  Created by Mohamed Hammam on 27/01/2022.
//

import Foundation
import Combine

class ViewModelGetAreas: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<ModelAreas, Error>()
    private var cancellables: Set<AnyCancellable> = []
  
    
//    @Published var cityId: Int?

//    //------- output
//    @Published var isValid = false
//    @Published var inlineErrorPassword = ""
    @Published var publishedAreaModel: [Area] = []
    @Published var isLoading = false
    @Published var isError = false
    @Published var errorMsg = ""
    @Published var IsDone = false
    @Published var isNetworkError = false
 
    init() {
        
        passthroughModelSubject.sink { (completion) in
        } receiveValue: { (modeldata) in
            self.publishedAreaModel = modeldata.Data ?? []
            print("self.publishedAreaModel VM ")

            print(self.publishedAreaModel ?? [])
//            print(self.publishedAreaModel?[0].Name ?? "" )
            
        }.store(in: &cancellables)
   
    }
    
    func startFetchAreas(cityId:Int) {

        if Helper.isConnectedToNetwork(){
            GetAreasApiService.GetAreas(
                cityId: cityId , completion:  { (success, model, err) in
            
                    self.isLoading = true
            if success{
                DispatchQueue.main.async {
                    self.passthroughModelSubject.send(model!)
                    self.IsDone = true
                    self.isLoading = false
//                    print("model! API ")
//
//                    print(model!)
                }
            }else{
                self.isLoading = false
                self.isError = true
//                print(model?.Message ?? "")
                self.errorMsg = err ?? "cannot get areas"
            }
        })

        }else{
                   // Alert with no internet connection
            self.isLoading = false
          isNetworkError = true
               }
    }
    
    
}
