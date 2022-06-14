//
//  ViewModelResetPassword.swift
//  SalamTech-DR
//
//  Created by Mostafa Morsy on 03/03/2022.
//

import Foundation
import Combine
import Alamofire


class ViewModelResetPassword: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<ResetPassword>, Error>()
    private var cancellables: Set<AnyCancellable> = []
    
    // ------- input
    
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
    
    //------- output
    @Published var nameErrorMessage = ""
    @Published var emailErrorMessage = ""
    @Published var phoneErrorMessage = ""
    @Published var isValid = false
    @Published var inlineErrorPassword = ""
    @Published var publishedUserResetModel: ResetPassword? = nil
    @Published var isRegistered = false
    @Published private var UserCreated = false
       
    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
    init() {
        passthroughModelSubject.sink { (completion) in
            //            print(completion)
        } receiveValue: { (modeldata) in
            self.publishedUserResetModel = modeldata.data
        }.store(in: &cancellables)

    }
    
    func isValidPhone(phone: String) -> Bool {
            let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return phoneTest.evaluate(with: phone)
        }

    func isValidEmail(email: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: email)
        }

//    func startFetchResetPassword( email: String) {
//        if Helper.isConnectedToNetwork(){
////        if isValid == true {
//            self.isLoading = true
//        ApiService.resetPassword( email: email, completion: { (success, modeldata, err) in
//            
//            if success{
//                DispatchQueue.main.async {
//                    self.passthroughModelSubject.send(modeldata!)
//                    self.isRegistered = true
//                    self.isLoading = false
//                }
//                print(modeldata?.data?.code ?? 0000)
//            }else{
//                self.isLoading = false
//                print(err ?? "error here from registeruserViewmodel")
//                self.isError = true
//                self.errorMsg = err ?? "Error"
//            }
//            self.isLoading = false
//            self.errorMsg = err ?? "Error msg sign up "
//            print(self.errorMsg )
//
//        })
//            
////        }else{
////            print("not validated")
////        }
//        }else{
//                   // Alert with no internet connection
//          isNetworkError = true
//            self.isLoading = false
//
//               }
//    }

}

extension ViewModelResetPassword:TargetType{
    var url: String {
        return  URLs().ResetPassword
    }
    
    var method: httpMethod {
        return .Post
    }
    
    var parameter: parameterType {
        let parametersarr : [String : Any]  = ["Email" : email ,"UserTypeId" : 3]
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
