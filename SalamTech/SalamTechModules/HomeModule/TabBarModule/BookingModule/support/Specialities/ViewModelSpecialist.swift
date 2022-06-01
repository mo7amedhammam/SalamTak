//
//  ViewModelSpecialist.swift
//  SalamTech
//
//  Created by wecancity on 02/04/2022.
//


import Foundation
import Combine
import Alamofire

class ViewModelSpecialist: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<[Speciality]>, Error>()
    private var cancellables: Set<AnyCancellable> = []
    
//    // ------- input

    @Published var  publishedSpecialistModel :  [Speciality]?
    @Published var isLoading:Bool? = false
    @Published var isError = false
    @Published var errorMsg = ""
    @Published var UserCreated = false
    @Published var isNetworkError = false
    
    
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
 
    init() {
        
//        startFetchSpecialist()
        passthroughModelSubject.sink { (completion) in
        } receiveValue: { (modeldata) in
            self.publishedSpecialistModel = modeldata.data ?? []
        }.store(in: &cancellables)      
        
    }
    
//    func startFetchSpecialist() {
//        if Helper.isConnectedToNetwork(){
//            self.isLoading = true
//            let url = URLs().GetSpecialist
//            let header : HTTPHeaders = [:]
//            let Parameters : [String:Any] = [:]
//
//            NetworkLayer.request(url: url, method: .get, parameters: Parameters, header: header, model: ModelSpecialist.self) { [self] (success, model, err) in
//                if success{
//                    //case of success
//                    DispatchQueue.main.async {
//                        self.passthroughModelSubject.send( model!  )
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



extension ViewModelSpecialist:TargetType{
    var url: String{
        return URLs().GetSpecialist
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

    
    func startFetchSpecialist() {
        if Helper.isConnectedToNetwork(){
            self.isLoading = true

            BaseNetwork.request(Target: self, responseModel: BaseResponse<[Speciality]>.self) { [self] (success, model, err) in
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
