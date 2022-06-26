//
//  ViewModelFees.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 06/06/2022.
//

import Foundation
import Combine

class ViewModelFees: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<MinMaxFee>, Error>()
    private var cancellables: Set<AnyCancellable> = []
    
    //    ------- output
    @Published var  publishedMinMaxFee: MinMaxFee? = MinMaxFee.init()
    
    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
    
    init() {
        startFetchFees()
        
        passthroughModelSubject.sink { (completion) in
        } receiveValue: { (modeldata) in
            self.publishedMinMaxFee = modeldata.data ?? MinMaxFee.init()
        }.store(in: &cancellables)
    }
}

extension ViewModelFees:TargetType{
    var url: String{
        return URLs().FilteredFees
    }
    
    var method: httpMethod{
        return .Post
    }
    
    var parameter: parameterType{
        return .plainRequest
    }
    
    var header: [String : String]? {
        return [:]
    }
    
    func startFetchFees() {
        if Helper.isConnectedToNetwork(){
            self.isLoading = true
            
            BaseNetwork.request(Target: self, responseModel: BaseResponse<MinMaxFee>.self) { [self] (success, model, err) in
                if success{
                    //case of success
                    DispatchQueue.main.async {
                        self.passthroughModelSubject.send( model!  )
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
