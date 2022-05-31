//
//  ViewModelExaminationTypeId.swift
//  SalamTech
//
//  Created by wecancity on 02/04/2022.
//  

import Foundation
import Combine
import SwiftUI
import Alamofire

class ViewModelExaminationTypeId: ObservableObject {
    var language = LocalizationService.shared.language

    let passthroughSubject = PassthroughSubject<String, Error>()
    let ModelExTypeId = PassthroughSubject<ModelExaminationTypeId, Error>()
    
    private var cancellables: Set<AnyCancellable> = []
    
    
    // ------- input
    
    
    //------- output
    @Published var isValid = false
    @Published var inlineErrorPassword = ""
    @Published var publishedModelExaminationTypeId: [ExaminationType] = []
    
    
    @Published var isLoading:Bool? = false
    @Published var isError = false
    @Published var errorMsg = ""
    @Published var isDone = false
    @Published var isNetworkError = false
    @Published var SessionExpired = false

    
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""

    
    init() {
        
//        GetExaminationTypeId()
        
        ModelExTypeId.sink { (completion) in
        } receiveValue: { [self] (modeldata) in
            self.publishedModelExaminationTypeId = modeldata.data ?? []
        }.store(in: &cancellables)
    }
    
    
//    func GetExaminationTypeId() {
//        if Helper.isConnectedToNetwork(){
//            GetExaminationTypeIdApiServise.GetExaminationTypeIdApiServise(
//                completion:  { (success, model, err) in
//                    self.isLoading = true
//                    if success{
//                        DispatchQueue.main.async {
//                            self.ModelExTypeId.send(model!)
//                            self.isLoading = false
//                            self.isDone = true
//                            print(model!)
//                        }
//                    }else{
//                        if model != nil{
//                        self.isLoading = false
//                        self.isError = true
//                        print(model?.message ?? "")
//
//
//                        self.errorMsg = err ?? "cannot get examnation Type Id "
//                        }else{
//                            if err == "unauthorized"{
//                                self.SessionExpired = true
//                                self.isLoading = false
//                            }
//                        }
//                    }
//                })
//            self.isLoading = false
//
//        }else{
//            // Alert with no internet connection
//            self.isLoading = false
//            isNetworkError = true
//        }
//    }
    
   
    
    
    func GetExaminationTypeId() {
        if Helper.isConnectedToNetwork(){
            self.isLoading = true
            let url = URLs().GetMedicalExaminationType
            let header : HTTPHeaders = [:]
            let Parameters : [String:Any] = [:]
            
            NetworkLayer.request(url: url, method: .get, parameters: Parameters, header: header, model: ModelExaminationTypeId.self) { [self] (success, model, err) in
                if success{
                    //case of success
                    DispatchQueue.main.async {
                        self.ModelExTypeId.send( model!  )
                    }
                    message = model?.message ?? "Bad Request"

                }else{
                    if model != nil{
                        //case of model with error
                        message = model?.message ?? "Bad Request"
                        activeAlert = .serverError
                }
                    else{
                    //case of Empty model (unauthorized)
                        message = "Session_expired\nlogin_again".localized(language)
                    activeAlert = .unauthorized

                }
                    isAlert = true
                }
                isLoading = false
            }
            
        }else{
            //case of no internet connection
            activeAlert = .NetworkError
            message = "Check_Your_Internet_Connection".localized(language)
            isAlert = true
        }
        
    }
    

    
    
}
