//
//  ReviewsVM.swift
//  SalamTech
//
//  Created by Mohamed Hammam on 11/05/2022.
//

import Foundation
import Combine

class ReviewsVM: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<[DocReview]>, Error>()
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var doctorId = 0
    @Published var publishedReviewsModel: [DocReview] = []
    @Published var noReviews = false
    
    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
 
    init() {
        
        passthroughModelSubject.sink { (completion) in
        } receiveValue: { [self]  (modeldata) in
            noReviews = false
            publishedReviewsModel = modeldata.data ?? []
            if publishedReviewsModel.count == 0 || publishedReviewsModel == [] {
                noReviews = true
            }
        }.store(in: &cancellables)
   
    }
    
}


extension ReviewsVM:TargetType{
    var url: String{
        let url = URLs().DoctorRate
        let queryItems = [URLQueryItem(name:"doctorId",value:"\(doctorId)")]
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

    
    func startFetchReviews() {
        if Helper.isConnectedToNetwork(){
            self.isLoading = true

            BaseNetwork.request(Target: self, responseModel:BaseResponse<[DocReview]>.self) { [self] (success, model, err) in
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
