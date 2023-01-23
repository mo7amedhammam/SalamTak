//
//  ViewModelDocClinics.swift
//  SalamTak
//
//  Created by wecancity on 23/01/2023.
//

import Foundation
import Combine
import Alamofire
//import SwiftUI

class ViewModelDocClinics: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passDocClinicsArr = PassthroughSubject<BaseResponse<[ModelDocClinics]> , Error>()
    private var cancellables: Set<AnyCancellable> = []
    
    // ------- input
    @Published var DoctorId                            :Int = 0

    //------- output
    @Published var publishedModelSearchDoc: [ModelDocClinics]?

    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""

    
    init() {
        passDocClinicsArr.sink { (completion) in
            //            print(completion)
        } receiveValue: { [self] (modeldata) in
            self.publishedModelSearchDoc = modeldata.data
        }.store(in: &cancellables)
    }
}


extension ViewModelDocClinics:TargetType{
    var url: String{
        return URLs().DoctorClinics
    }
    
    var method: httpMethod{
        return .Get
    }
    
    var parameter: parameterType{
        let Parameters : [String:Any] = [
//        // required
            "DoctorId": DoctorId
    ]
        return .parameterRequest(Parameters: Parameters, Encoding: URLEncoding.default)
    }
    
    var header: [String : String]? {
        return [:]
    }
    
    func FetchDoctorClinics() {
        if Helper.isConnectedToNetwork(){
            self.isLoading = true

            BaseNetwork.request(Target: self, responseModel: BaseResponse<[ModelDocClinics]>.self) { [self] (success, model, err) in
                if success{
                    //case of success
                    DispatchQueue.main.async {
                        self.passDocClinicsArr.send( model!  )
                    }
                }else{
                    if model != nil{
                        //case of model with error
                        message = model?.message ?? "Bad Request"
                        activeAlert = .serverError
                }else{
                    if err == "Unauthorized"{
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
