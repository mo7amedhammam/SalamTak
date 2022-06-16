//
//  ViewModelSubspeciality.swift
//  SalamTak
//
//  Created by wecancity on 06/06/2022.
//

import Foundation
import Combine

class ViewModelSubspeciality: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<[subspeciality]>, Error>()
    private var cancellables: Set<AnyCancellable> = []
    
//    // ------- input
    @Published  var SpecialistId: Int = 0

    @Published  var  publishedSubSpecialistModel: [subspeciality] = []

        @Published var isLoading:Bool? = false
        @Published var isAlert = false
        @Published var activeAlert: ActiveAlert = .NetworkError
        @Published var message = ""
 
    init() {
        passthroughModelSubject.sink { (completion) in
        } receiveValue: { (modeldata) in
            
            self.publishedSubSpecialistModel = modeldata.data ?? []
        }.store(in: &cancellables)
 
        
    }
    
    
    
}


extension ViewModelSubspeciality:TargetType{
    var url: String{
        let url = URLs().GetSubSpecialist
        let queryItems = [URLQueryItem(name:"specialListId",value:"\(SpecialistId)")]
            var urlComponents = URLComponents(string: url)
            urlComponents?.queryItems = queryItems
            let convertedUrl = urlComponents?.url
            if let convertUrl = convertedUrl {
                print(convertUrl)
            }
        return  convertedUrl?.absoluteString ?? ""

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

    
    func startFetchSubSpecialist() {
        if Helper.isConnectedToNetwork(){
            self.isLoading = true

            BaseNetwork.request(Target: self, responseModel: BaseResponse<[subspeciality]>.self) { [self] (success, model, err) in
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
