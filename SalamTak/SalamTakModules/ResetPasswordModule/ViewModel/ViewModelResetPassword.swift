//
//  ViewModelResetPassword.swift
//  SalamTech-DR
//
//  Created by Mohamed Hammam on 03/03/2022.
//

import Foundation
import Combine
import Alamofire

class ViewModelResetPassword: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<ResetPassword>, Error>()
    private var cancellables: Set<AnyCancellable> = []
    
    // ------- input
    @Published var ResetMethod : Int = 2
    
    @Published  var email: String = "" {
        didSet{
            if self.email.isEmpty{
                self.emailErrorMessage = "*"
            } else if !self.email.isValidEmail(){
                self.emailErrorMessage = "Invalid Email"
            } else {
                self.emailErrorMessage = ""
            }
        }
    }
    
    let characterLimit: Int
    @Published  var phoneNumber: String = "" {
        didSet{
            let filtered = phoneNumber.filter {$0.isNumber}
            if phoneNumber != filtered {
                phoneNumber = filtered
            }
            if self.phoneNumber.count < 11 || self.phoneNumber.count > 11 {
                self.phoneErrorMessage = "Phone Number Must be 11 number"
            } else if self.phoneNumber.isEmpty {
                self.phoneErrorMessage = "*"
            } else if self.phoneNumber.count == 11 {
                self.phoneErrorMessage = ""
            }
        }
    }
    
    //------- output
    @Published var emailErrorMessage = ""
    @Published var phoneErrorMessage = ""
    @Published var publishedUserResetModel: ResetPassword? = nil
    @Published var isReset = false
    
    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
    init(limit: Int = 11){
        characterLimit = limit
        passthroughModelSubject.sink { (completion) in
        } receiveValue: { (modeldata) in
            self.publishedUserResetModel = modeldata.data
        }.store(in: &cancellables)
    }
}

extension ViewModelResetPassword:TargetType{
    var url: String {
        return  URLs().ResetPassword
    }
    
    var method: httpMethod {
        return .Post
    }
    
    var parameter: parameterType {
        var parametersarr : [String : Any]  = ["ResetMethod":ResetMethod,"UserTypeId" : 3]
        if email != ""{
            parametersarr["Email"] = email 
        } else{
            parametersarr["Phone"] = phoneNumber
        }

        return .parameterRequest(Parameters: parametersarr, Encoding: JSONEncoding.default)
    }
    
    var header: [String : String]? {
        let header = ["Authorization":Helper.getAccessToken()]
        return header
    }
    
    func startFetchResetPassword(){
        print(parameter)
        if Helper.isConnectedToNetwork(){
            self.isLoading = true
            BaseNetwork.request(Target: self, responseModel: BaseResponse<ResetPassword>.self) { [self] (success, model, err) in
                if success{
                    //case of success
                    DispatchQueue.main.async {
                        self.passthroughModelSubject.send( model!  )
                        self.isReset = true
                    }
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
