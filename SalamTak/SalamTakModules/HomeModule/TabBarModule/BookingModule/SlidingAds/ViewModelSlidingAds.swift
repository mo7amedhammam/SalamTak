//
//  ViewModelSlidingAds.swift
//  SalamTak
//
//  Created by wecancity on 05/02/2023.
//

import Foundation
import Combine

class ViewModelSlidingAds: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject_Ads = PassthroughSubject<BaseResponse<[ModelSlidingAds]>, Error>()

    private var cancellables: Set<AnyCancellable> = []
    
//    // ------- input
    @Published  var PageID: Int = 1 // 1:home,2:search,3:result
    @Published  var DoctorApp: Bool = false

//    //------- output
    @Published var publishedAdsModel: [ModelSlidingAds] = []

    @Published var isDone = false
    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
 
    init() {
//        GetDashboardAds()
        passthroughModelSubject_Ads.sink { (completion) in
        } receiveValue: {[weak self] (modeldata) in
            self?.publishedAdsModel = modeldata.data ?? []
//            print(modeldata)
        }.store(in: &cancellables)
    }
}

extension ViewModelSlidingAds:TargetType{
    
    var url: String {
        let url = URLs().GetSlidingAds
        let queryItems = [URLQueryItem(name:"PageID",value:"\(PageID)"),
                          URLQueryItem(name:"DoctorApp",value:"\(DoctorApp)")
        ]

        var urlComponents = URLComponents(string: url)
        urlComponents?.queryItems = queryItems
        let convertedUrl = urlComponents?.url
//        if let convertUrl = convertedUrl {
////            print(convertUrl)
//        }
        return convertedUrl?.absoluteString ?? ""
        
    }
    
    var method: httpMethod {
            return .Get
    }
    
    var parameter: parameterType {
        return .plainRequest
    }
    
    var header: [String : String]? {
        let header = ["Authorization":Helper.getAccessToken()]
        return header
    }
    
    func GetDashboardAds(){
        print(url)
        if Helper.isConnectedToNetwork(){
            self.isLoading = true
            BaseNetwork.request(Target: self, responseModel: BaseResponse<[ModelSlidingAds]>.self) { [self] (success, model, err) in
                if success{
                    //case of success
//                    DispatchQueue.main.async {
                        self.isDone = true
                        self.passthroughModelSubject_Ads.send(model!)
//                    }
                }else{
                    if model != nil{
                        //case of model with error
                        message = model?.message ?? "Bad Request"
                        isAlert = true
                    }else{
                        if err == "Unauthorized"{
                            //case of Empty model (unauthorized)
                            message = "Session_expired\nlogin_again".localized(language)
                        }else{
                            isAlert = true
                            message = err ?? "there is an error"
                        }
                    }
                    isAlert = true
                }
                isLoading = false
            }
        }else{
            //case of no internet connection
            message = "Check_Your_Internet_Connection".localized(language)
            isAlert = true
        }
    }

}
