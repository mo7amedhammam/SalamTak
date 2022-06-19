//
//  VMAddReview.swift
//  SalamTech
//
//  Created by Mohamed Hammam on 18/05/2022.
//

import Foundation
import Combine
import Alamofire

class VMAddReview: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let ModelFetchDoctors = PassthroughSubject<BaseResponse<rateSt> , Error>()

    private var cancellables: Set<AnyCancellable> = []
    // ------- input

    @Published var DoctorId                    :Int = 0
    @Published var Rate                         :Int = 0
    @Published var Comment                      :String = ""

    @Published var publishedModelAddReview : rateSt? = rateSt.init()

    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
    init() {
        
        ModelFetchDoctors.sink { (completion) in
            //            print(completion)
        } receiveValue: { [weak self]  (modeldata) in
            self?.publishedModelAddReview = modeldata.data
            print(self?.publishedModelAddReview ?? rateSt.init())
        }.store(in: &cancellables)
    }
}


extension VMAddReview:TargetType{
    var url: String{
        return URLs().CreateDoctorRate
    }
    
    var method: httpMethod{
        return .Post
    }
    
    var parameter: parameterType{
        let Parameters : [String:Any] = [
            // required
            "DoctorId": DoctorId ,
            "Rate":Rate,
            "Comment":Comment
        ]
        return .parameterRequest(Parameters: Parameters, Encoding: JSONEncoding.default)
    }
    
    var header: [String : String]? {
        let header = ["Authorization":Helper.getAccessToken()]
        return header
    }

    
    func AddDocRate() {
        if Helper.isConnectedToNetwork(){
            self.isLoading = true

            BaseNetwork.request(Target: self, responseModel: BaseResponse<rateSt>.self) { [self] (success, model, err) in
                if success{
                    //case of success
                    DispatchQueue.main.async {
                        self.ModelFetchDoctors.send( model!  )
                    }
                    isAlert = true
                    activeAlert = .success
                    message = publishedModelAddReview?.Statues ?? "Success"

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
