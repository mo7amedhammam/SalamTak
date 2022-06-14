//
//  ViewModelUpdatePassword.swift
//  SalamTech-DR
//
//  Created by Mostafa Morsy on 03/03/2022.
//

import Foundation
import Combine
import Alamofire


class ViewModelUpdatePassword: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<UpdatePassword>, Error>()
    private var cancellables: Set<AnyCancellable> = []
    
   
    @Published  var password = ""
    @Published  var password1 = ""
    @Published  var UserId = 0
    


    
    //------- output
    @Published var nameErrorMessage = ""
    @Published var emailErrorMessage = ""
    @Published var phoneErrorMessage = ""
    @Published var isValid = false
    @Published var inlineErrorPassword = ""
    @Published var publishedUserRegisteredModel: UpdatePassword? = nil
    @Published var isRegistered = false
    @Published private var UserCreated = false

    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
   
    init() {
        
      
     validations()
        passthroughModelSubject.sink { (completion) in
            //            print(completion)
        } receiveValue: { (modeldata) in
            self.publishedUserRegisteredModel = modeldata.data

        }.store(in: &cancellables)
   
    }
    
  
    
    func validations(){
       
         var isPasswordEmptyPublisher: AnyPublisher<Bool,Never> {
            $password
                .debounce(for: 0.8, scheduler: RunLoop.main)
                .removeDuplicates()
                .map{ $0.isEmpty && $0.count >= 6}
                .eraseToAnyPublisher()
        }
         var arePasswordsEqualPublisher: AnyPublisher<Bool,Never> {
            Publishers.CombineLatest($password, $password1)
                .debounce(for: 0.2, scheduler: RunLoop.main)
                .map{ $0 == $1}
                .eraseToAnyPublisher()
        }
         var isPasswordsValidPublisher: AnyPublisher<PasswordStatus,Never> {
            Publishers.CombineLatest(isPasswordEmptyPublisher, arePasswordsEqualPublisher)
                .map{
                    if $0 {return PasswordStatus.empty}
                    if !$1 {return PasswordStatus.repeatedPasswordWrong}
                    return PasswordStatus.valid
                }
                .eraseToAnyPublisher()
        }
        
        
        
        enum PasswordStatus {
            case notemail
            case empty
            case repeatedPasswordWrong
            case valid
        }
        
        //----------
       
        
        isPasswordsValidPublisher
            .dropFirst()
            .receive(on: RunLoop.main)
            .map{ passwordStatus in
                switch passwordStatus {
                case .notemail:
                    return "Not Valid Email"
                case .empty:
                    return "Password cannot be Empty"
                case .repeatedPasswordWrong:
                    return "Passwords do not match"
                case .valid:
                    return ""
                }
            }
            .assign(to: \.inlineErrorPassword, on: self)
            .store(in: &cancellables)
        
        
        
    }
    
//    func startFetchUpdatePassword(userId:Int, password:String) {
//        if Helper.isConnectedToNetwork(){
////        if isValid == true {
//            self.isLoading = true
//            ApiService.updatePassword(userId: userId, password: password, completion: { (success, modeldata, err) in
//
//            if success{
//                DispatchQueue.main.async {
//                    self.passthroughModelSubject.send(modeldata!)
//                    self.isRegistered = true
//                    self.isLoading = false
//                }
//                print(modeldata?.Data?.Id ?? 0000)
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
    
//    func startFetchUpdatePassword1( password:String) {
//        if Helper.isConnectedToNetwork(){
////        if isValid == true {
//            self.isLoading = true
//            ApiService.updatePassword1(password: password, completion: { (success, modeldata, err) in
//
//            if success{
//                DispatchQueue.main.async {
//                    self.passthroughModelSubject.send(modeldata!)
//                    self.isRegistered = true
//                    self.isLoading = false
//                }
//                print(modeldata?.Data?.Id ?? 0000)
//            }else{
//                self.isLoading = false
//                print(modeldata?.Message ?? "")
//                self.isError = true
//                self.errorMsg = modeldata?.Message ?? ""
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

extension ViewModelUpdatePassword:TargetType{
    var url: String {
        return  URLs().UpdatePassword
    }
    
    var method: httpMethod {
        return .Post
    }
    
    var parameter: parameterType {
        let parametersarr : [String : Any] =  ["Password" : password ,"UserId" : UserId ]
        return .parameterRequest(Parameters: parametersarr, Encoding: JSONEncoding.default)
    }
    
    var header: [String : String]? {
        let header = ["Authorization":Helper.getAccessToken()]
        return header
    }
    
    func startFetchUpdatePassword(){
        print(parameter)
        if Helper.isConnectedToNetwork(){
            self.isLoading = true
            BaseNetwork.request(Target: self, responseModel: BaseResponse<UpdatePassword>.self) { [self] (success, model, err) in
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
