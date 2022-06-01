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
    let ModelExTypeId = PassthroughSubject<BaseResponse<[ExaminationType]>, Error>()
    
    private var cancellables: Set<AnyCancellable> = []
    
    
    // ------- input
    
    
    //------- output
    @Published var isValid = false
    @Published var inlineErrorPassword = ""
    @Published var publishedModelExaminationTypeId: [ExaminationType] = []
    
    
    @Published var isLoading:Bool? = false
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
//            self.isLoading = true
//            let url = URLs().GetMedicalExaminationType
//            let header : HTTPHeaders = [:]
//            let Parameters : [String:Any] = [:]
//
//
//            NetworkLayer.request(url: url, method: .get, parameters: Parameters, header: header, model: ModelExaminationTypeId.self) { [self] (success, model, err) in
//                if success{
//                    //case of success
//                    DispatchQueue.main.async {
//                        self.ModelExTypeId.send( model!  )
//                    }
//                    message = model?.message ?? "Bad Request"
//
//                }else{
//                    if model != nil{
//                        //case of model with error
//                        message = model?.message ?? "Bad Request"
//                        activeAlert = .serverError
//                }
//                    else{
//                    //case of Empty model (unauthorized)
//                        message = "Session_expired\nlogin_again".localized(language)
//                    activeAlert = .unauthorized
//
//                }
//                    isAlert = true
//                }
//                isLoading = false
//            }
//
//        }else{
//            //case of no internet connection
//            activeAlert = .NetworkError
//            message = "Check_Your_Internet_Connection".localized(language)
//            isAlert = true
//        }
//
//    }
    

    
    
}



extension ViewModelExaminationTypeId:TargetType{
    var url: String{
        return URLs().GetMedicalExaminationType
    }
    
    var method: httpMethod{
        return .Get
    }
    
    var parameter: parameterType{
        return .plainRequest
    }
    
    var header: [String : String]? {
        return [:]
    }

    
    func GetExaminationTypeId() {
        if Helper.isConnectedToNetwork(){
            self.isLoading = true

            BaseNetwork.request(Target: self, responseModel: BaseResponse<[ExaminationType]>.self) { [self] (success, model, err) in
                if success{
                    //case of success
                    DispatchQueue.main.async {
                        self.ModelExTypeId.send( model!  )
                    }

                }else{
                    if model != nil{
                        //case of model with error
                        message = model?.message ?? "Bad Request"
                        activeAlert = .serverError
                }else{
                    if message == "Unauthorized"{
                    //case of Empty model (unauthorized)
                        message = "Session_expired\nlogin_again".localized(language)
                    activeAlert = .unauthorized
                    }else{
                        message = err ?? "there is an error"
                        activeAlert = .serverError
                    }
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
