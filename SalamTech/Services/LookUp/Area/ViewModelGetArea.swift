//
//  ViewModelGetAreas.swift
//  SalamTech-DR
//
//  Created by Mohamed Hammam on 27/01/2022.
//

import Foundation
import Combine
import Alamofire

class ViewModelGetAreas: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<[Area]>, Error>()
    private var cancellables: Set<AnyCancellable> = []
  
    
    @Published var cityId: Int = 0

//    //------- output

    @Published var publishedAreaModel: [Area] = []
    @Published var isLoading:Bool? = false
    @Published var isError = false
    @Published var errorMsg = ""
    @Published var IsDone = false
    @Published var isNetworkError = false
    
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
 
    init() {
        
        passthroughModelSubject.sink { (completion) in
        } receiveValue: { (modeldata) in
            self.publishedAreaModel = modeldata.data ?? []
            
        }.store(in: &cancellables)
   
    }
    

    
}


extension ViewModelGetAreas:TargetType{
    var url: String{
        let url = URLs().GetAreas
        let queryItems = [URLQueryItem(name:"cityId",value:"\(cityId)")]
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

    
    func startFetchAreas() {
        if Helper.isConnectedToNetwork(){
            self.isLoading = true

            BaseNetwork.request(Target: self, responseModel: BaseResponse<[Area]>.self) { [self] (success, model, err) in
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
