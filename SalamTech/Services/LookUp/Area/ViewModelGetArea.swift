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
    let passthroughModelSubject = PassthroughSubject<ModelAreas, Error>()
    private var cancellables: Set<AnyCancellable> = []
  
    
    @Published var cityId: Int = 0

//    //------- output
//    @Published var isValid = false
//    @Published var inlineErrorPassword = ""
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
            self.publishedAreaModel = modeldata.Data ?? []
//            print(self.publishedAreaModel )
            
        }.store(in: &cancellables)
   
    }
    
    
    func startFetchAreas() {
        if Helper.isConnectedToNetwork(){
            self.isLoading = true
            let url  = URLs().GetAreas
            let Parameters : [String:Any] = [:]
                
                let header:HTTPHeaders = ["Authorization":Helper.getAccessToken()]
                let queryItems = [URLQueryItem(name:"cityId",value:"\(cityId)")]
                var urlComponents = URLComponents(string: url)
                urlComponents?.queryItems = queryItems
                let convertedUrl = urlComponents?.url
                if let convertUrl = convertedUrl {
                    print(convertUrl)
                }
            
            NetworkLayer.request(url: "\(convertedUrl!)", method: .get, parameters: Parameters, header: header, model: ModelAreas.self) { [self] (success, model, err) in
                if success{
                    //case of success
                    DispatchQueue.main.async {
                        self.passthroughModelSubject.send( model!  )
                    }
                    message = model?.Message ?? "Bad Request"

                }else{
                    if model != nil{
                        //case of model with error
                        message = model?.Message ?? "Bad Request"
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
