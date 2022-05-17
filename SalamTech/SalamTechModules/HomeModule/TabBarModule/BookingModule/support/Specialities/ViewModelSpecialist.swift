//
//  ViewModelSpecialist.swift
//  SalamTech
//
//  Created by wecancity on 02/04/2022.
//


import Foundation
import Combine

class ViewModelSpecialist: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<ModelSpecialist, Error>()
    private var cancellables: Set<AnyCancellable> = []
    
//    // ------- input

    @Published var  publishedSpecialistModel :  [Speciality]?
    @Published var isLoading = false
    @Published var isError = false
    @Published var errorMsg = ""
    @Published var UserCreated = false
    @Published var isNetworkError = false
 
    init() {
        
        startFetchSpecialist()
        passthroughModelSubject.sink { (completion) in
        } receiveValue: { (modeldata) in
            self.publishedSpecialistModel = modeldata.Data ?? []
        }.store(in: &cancellables)
        
      
        
    }
    
    
  
    
    func startFetchSpecialist() {

        if Helper.isConnectedToNetwork(){
            GetSpecialistAPI.GetSpecialist(completion:  { (success, model, err) in
                
                self.isLoading = true
            if success{
                DispatchQueue.main.async {
                    self.passthroughModelSubject.send(model!)
                    self.UserCreated = true
                    self.isLoading = false
//                    print(model)
                }
            }else{
                self.isLoading = false
                self.isError = true
                print(model?.Message ?? "")
                self.errorMsg = err ?? "cannot get Specialist"
            }
        })

        }else{
                   // Alert with no internet connection
            self.isLoading = false
          isNetworkError = true
               }
    }
    
    
}
