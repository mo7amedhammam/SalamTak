//
//  ViewModelPromotions.swift
//  SalamTak
//
//  Created by wecancity on 05/02/2023.
//

import Combine
import Alamofire
class ViewModelPromotions: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject_Ads = PassthroughSubject<BaseResponse<[ModelPromotions]>, Error>()

    private var cancellables: Set<AnyCancellable> = []
    
//    // ------- input
    @Published  var PageID: Int = 1
    @Published  var DoctorApp: Bool = false

//    //------- output
    @Published var publishedAdsModel: [ModelPromotions] = []
    @Published var noData = false

    @Published var isDone = false
    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
 
    init() {
        GetPromotions()
        passthroughModelSubject_Ads.sink { (completion) in
        } receiveValue: {[weak self] (modeldata) in
            self?.publishedAdsModel = modeldata.data ?? []
//            print(modeldata)
        }.store(in: &cancellables)
    }
    
}


extension ViewModelPromotions:TargetType{
    var url: String{
        let url = URLs().GetPromotions
        let queryItems = [
                          URLQueryItem(name:"DoctorApp",value:"\(DoctorApp)")
        ]
        var urlComponents = URLComponents(string: url)
        urlComponents?.queryItems = queryItems
        let convertedUrl = urlComponents?.url
        return convertedUrl?.absoluteString ?? ""
    }
    
    var method: httpMethod{
        return .Get
    }
    
    var parameter: parameterType{
        return .plainRequest
    }
    
    var header: [String : String]? {
    let header = ["Authorization":Helper.getAccessToken()]
        return header
    }

    
    func GetPromotions() {
        if Helper.isConnectedToNetwork(){
            print(url)
            print(method)
            print(parameter)
            self.isLoading = true

            BaseNetwork.request(Target: self, responseModel: BaseResponse<[ModelPromotions]>.self) { [self] (success, model, err) in
                print(model)

                if success{
                    //case of success
                    DispatchQueue.main.async {
                        self.noData = false
                        self.passthroughModelSubject_Ads.send( model!  )
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
