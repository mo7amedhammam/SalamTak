//
//  ViewModelExaminationTypeId.swift
//  SalamTech
//
//  Created by wecancity on 02/04/2022.
//  

import Foundation
import Combine
import SwiftUI

class ViewModelExaminationTypeId: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let ModelExaminationTypeId = PassthroughSubject<ModelExaminationTypeId, Error>()
    
    private var cancellables: Set<AnyCancellable> = []
    
    
    // ------- input
    
    
    //------- output
    @Published var isValid = false
    @Published var inlineErrorPassword = ""
    @Published var publishedModelExaminationTypeId: [ExaminationType] = []
    
    
    @Published var isLoading = false
    @Published var isError = false
    @Published var errorMsg = ""
    @Published var isDone = false
    @Published var isNetworkError = false
    @Published var SessionExpired = false

    
    init() {
        
        GetExaminationTypeId()
        
        ModelExaminationTypeId.sink { (completion) in
        } receiveValue: { [self] (modeldata) in
            self.publishedModelExaminationTypeId = modeldata.data ?? []
        }.store(in: &cancellables)
    }
    
    
    func GetExaminationTypeId() {
        if Helper.isConnectedToNetwork(){
            GetExaminationTypeIdApiServise.GetExaminationTypeIdApiServise(
                completion:  { (success, model, err) in
                    self.isLoading = true
                    if success{
                        DispatchQueue.main.async {
                            self.ModelExaminationTypeId.send(model!)
                            self.isLoading = false
                            self.isDone = true
                            print(model!)
                        }
                    }else{
                        if model != nil{
                        self.isLoading = false
                        self.isError = true
                        print(model?.message ?? "")
                        
                        
                        self.errorMsg = err ?? "cannot get examnation Type Id "
                        }else{
                            if err == "unauthorized"{
                                self.SessionExpired = true
                                self.isLoading = false
                            }
                        }
                    }
                })
            self.isLoading = false
            
        }else{
            // Alert with no internet connection
            self.isLoading = false
            isNetworkError = true
        }
    }
    
   
    
    

    
    
}
