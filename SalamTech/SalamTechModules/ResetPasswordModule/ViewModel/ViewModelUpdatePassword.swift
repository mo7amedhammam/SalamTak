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
    let passthroughModelSubject = PassthroughSubject<ModelUpdatePassword, Error>()
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
    @Published var publishedUserRegisteredModel: ModelUpdatePassword? = nil
    @Published var isRegistered = false
    @Published var isLoading:Bool? = false
    @Published var isError = false
    @Published var errorMsg = ""
    @Published private var UserCreated = false
    @Published var isNetworkError = false
    
    
    

    //    @Published var receivededmodel: registerModel? = nil
    
//    @Published var receivededmodel = registerModel(Data: userData(Code: 0, ReSendCounter: 0, UserId: 0) , MessageCode: 0, Success: false, Message: "")
  
   
    init() {
        
      
     validations()
        //-----------------------------------------------------------------
        passthroughModelSubject.sink { (completion) in
            //            print(completion)
        } receiveValue: { (modeldata) in
            self.publishedUserRegisteredModel = modeldata
//            self.verify.passedOTP = modeldata.Data?.Code ?? 000
//            createUserWith.init(name: self.fullName, email: self.email, Phone: self.phoneNumber, password: self.password, OTP: modeldata.Data?.Code ?? 0)
        }.store(in: &cancellables)
        
        //-----------------------------------------------------------------
        //        passthroughSubject
        //            .dropFirst(2)
        //            .filter({ (value) -> Bool in
        //                value != "5"
        //            })
        //            .map { value in
        //                return value + " seconds"
        //            }
        //            .sink { (completion) in
        //                switch completion {
        //                case .finished:
        //                    self.time = "Finished"
        //                case .failure(let err):
        //                    self.time = err.localizedDescription
        //                }
        //            } receiveValue: { (value) in
        //                self.time = value
        //            }
        //            .store(in: &cancellables)
        //
        //-------------------------------------------------------
        
        
        
    }
    
  
    
    func validations(){
        
//        var isEmailValidPublisher: AnyPublisher<Bool,Never>{
//               $email
//                   .removeDuplicates()
//                   .map { $0.trimmingCharacters(in: .whitespacesAndNewlines).count >= 10}
//                   .handleEvents(receiveOutput: { [weak self] in $0 ? (self?.emailMessage = "") : (self?.emailMessage = "Invalid email")})
//                   .eraseToAnyPublisher()
//           }
        
      
//        var isEmailValidPublisher: AnyPublisher<Bool,Never> {
//           $email
//               .debounce(for: 0.8, scheduler: RunLoop.main)
//               .removeDuplicates()
////               .map{
////                   input in
////                                  guard !input.isEmpty else {
////                                      return "Email cannot be left empty"
////                                  }
////                                  guard input.isValidEmail() else {
////                                      return "Email is not valid"
////                                  }
////               }
//               .eraseToAnyPublisher()
//       }
        
       
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
    
    func startFetchUpdatePassword(userId:Int, password:String) {
        if Helper.isConnectedToNetwork(){
//        if isValid == true {
            self.isLoading = true
            ApiService.updatePassword(userId: userId, password: password, completion: { (success, modeldata, err) in
            
            if success{
                DispatchQueue.main.async {
                    self.passthroughModelSubject.send(modeldata!)
                    self.isRegistered = true
                    self.isLoading = false
                }
                print(modeldata?.Data?.Id ?? 0000)
            }else{
                self.isLoading = false
                print(err ?? "error here from registeruserViewmodel")
                self.isError = true
                self.errorMsg = err ?? "Error"
            }
            self.isLoading = false
            self.errorMsg = err ?? "Error msg sign up "
            print(self.errorMsg )

        })
            
//        }else{
//            print("not validated")
//        }
        }else{
                   // Alert with no internet connection
          isNetworkError = true
            self.isLoading = false

               }
    }
    
    func startFetchUpdatePassword1( password:String) {
        if Helper.isConnectedToNetwork(){
//        if isValid == true {
            self.isLoading = true
            ApiService.updatePassword1(password: password, completion: { (success, modeldata, err) in
            
            if success{
                DispatchQueue.main.async {
                    self.passthroughModelSubject.send(modeldata!)
                    self.isRegistered = true
                    self.isLoading = false
                }
                print(modeldata?.Data?.Id ?? 0000)
            }else{
                self.isLoading = false
                print(modeldata?.Message ?? "")
                self.isError = true
                self.errorMsg = modeldata?.Message ?? ""
            }
            self.isLoading = false
            self.errorMsg = err ?? "Error msg sign up "
            print(self.errorMsg )

        })
            
//        }else{
//            print("not validated")
//        }
        }else{
                   // Alert with no internet connection
          isNetworkError = true
            self.isLoading = false

               }
    }
    
    
    //****************
    //    func newfetch(){
    //        let header:HTTPHeaders = ["Content-Type":"application/json" , "Accept":"application/json"]
    //        let parameters : [String : Any] = ["Email" : "mood@mdlvb.cpm" ,"Phone" : "01252525254" ,"Password" : "123456" ,"Name" : "mostafa" ,"UserTypeId" : 2 ]
    //
    //        AF.request("https://salamtech.azurewebsites.net/api/en/User/Register", method: .post,parameters: parameters ,headers: header ).publishDecodable(type: registerModel.self).sink { (Completion) in
    //              switch Completion {
    //              case .finished:
    //                ()
    //              case .failure(let err):
    //                  print(err.localizedDescription)
    //              }
    //        } receiveValue: { (response) in
    //            switch response.result {
    //            case .success(let model):
    ////                self.message = model.Message ?? ""
    ////                self.status = model.Success ?? false
    ////                self.code = model.Data?.Code ?? 0
    //
    //                print(model.Message ?? "")
    //
    //                print(model.Success ?? "")
    //
    //                self.publishedUserRegisteredModel = model
    //
    //                print(self.publishedUserRegisteredModel?.Success ?? false)
    //
    //            case .failure(let err):
    //                print(err.localizedDescription)
    //            }
    //
    //        }.store(in: &cancellables)
    //
    //    }
    
    
    
    
}

