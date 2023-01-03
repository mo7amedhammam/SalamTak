//
//  ViewModelRegister.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 31/03/2022.
//

import Foundation
import Combine
import Alamofire
extension String {
    func isValidEmail() -> Bool {
            let emailRegEx = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"

            let emailValidation = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
            return emailValidation.evaluate(with: self)
        }
}


class ViewModelRegister: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<RegisterModel>, Error>()
    private var cancellables: Set<AnyCancellable> = []
    let characterLimit: Int
    
    // ------- input
    @Published  var fullName: String = ""
    @Published  var email: String = ""
    @Published  var phoneNumber: String = ""
  
    @Published  var phoneNumber1: String = "+20 | "
    @Published  var password = ""
    @Published  var password1 = ""
    @Published var IsTermsAgreed = false
    @Published var termsErrorMessage = ""

    //------- output
    @Published var nameErrorMessage = ""
    @Published var emailErrorMessage = ""
    @Published var phoneErrorMessage = ""
    @Published var isValid = false
    @Published var passwordErrorMessage = ""
    @Published var confirmPasswordErrorMessage = ""

    @Published var publishedUserRegisteredModel: RegisterModel? = nil
    @Published var isRegistered = false
    @Published private var UserCreated = false
   
    @Published var formIsValid = false

    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
   
    init(limit: Int = 11) {
        characterLimit = limit

     checkvalidations()
        //-----------------------------------------------------------------
        passthroughModelSubject.sink { (completion) in
            //            print(completion)
        } receiveValue: { (modeldata) in
            if modeldata.message == "Success"{
                self.publishedUserRegisteredModel = modeldata.data
                self.isRegistered = true
            }
        }.store(in: &cancellables)
    }
    
//    func isValidPhone(phone: String) -> Bool {
//            let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
//            let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
//            return phoneTest.evaluate(with: phone)
//        }

//    func isValidEmail(email: String) -> Bool {
//            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//            return emailTest.evaluate(with: email)
//        }

}

extension ViewModelRegister:TargetType {
   
    var url: String {
            return  URLs().RegisterUser
    }
    
    var method: httpMethod {
        return .Post
    }
    
    var parameter: parameterType {
        let parametersarr : [String : Any] =  ["Name" : fullName ,"Email" : email ,"Phone" : phoneNumber ,"Password" : password ,"UserTypeId" : 3 ]
        return .parameterRequest(Parameters: parametersarr, Encoding: JSONEncoding.default)
    }
    
    var header: [String : String]? {
        let header = ["Content-Type":"application/json" , "Accept":"application/json"]
        return header
    }
    
    func startFetchUserRegisteration(){
        
        if Helper.isConnectedToNetwork(){
            print(parameter)

            self.isLoading = true
            BaseNetwork.request(Target: self, responseModel: BaseResponse<RegisterModel>.self ) { [self] (success, model, err) in
                if success{
                    //case of success
                    DispatchQueue.main.async {
                        self.passthroughModelSubject.send(model!)
//                        self.isRegistered = true
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


// MARK: - Setup validations
extension ViewModelRegister{
    var isUserNameValidPublisher: AnyPublisher<Bool, Never> {
       $fullName
         .map { name in
             guard name.count > 0 else {
                 self.nameErrorMessage = ""
                 return false
             }

             if name.count >= 3 {
                 self.nameErrorMessage = ""
                 return true
             }else{
                 self.nameErrorMessage = "minimum_3_chars_required"
                 return false
             }
         }
         .eraseToAnyPublisher()
     }
    
    var isPhoneValidPublisher: AnyPublisher<Bool, Never> {
       $phoneNumber

         .map { number in
//             self.phoneNumber = String(number.prefix(self.characterLimit))
             guard number.count > 0 else {
                 self.phoneErrorMessage = ""
                 return false
             }
             let phonePredicate = NSPredicate(format:"SELF MATCHES %@","01[0125][0-9]{8}$")
             if phonePredicate.evaluate(with: number) && number.count >= 11{
                 self.phoneErrorMessage = ""
             return true
             }else{
                 self.phoneErrorMessage = "not_valid_Phone_number"
                 return false
             }
         }
         .eraseToAnyPublisher()
     }
    
    var isUserEmailValidPublisher: AnyPublisher<Bool, Never> {
       $email
            .map { email in
             guard email.count > 0 else {
                 self.emailErrorMessage = ""
                 return false
             }

             let emailPredicate = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
             if emailPredicate.evaluate(with: email){
                 self.emailErrorMessage = ""
             return true
             }else{
                 self.emailErrorMessage = "not_valid_email"
                 return false
             }
         }
         .eraseToAnyPublisher()
     }
    
    var isNameAndPhoneValidPunlisher:AnyPublisher<Bool,Never>{
        Publishers.CombineLatest3(isUserNameValidPublisher,isUserEmailValidPublisher,isPhoneValidPublisher)
            .map{ name, email, phone in
                return name && email && phone
            }
            .eraseToAnyPublisher()
    }
    
    var isPasswordValidPublisher: AnyPublisher<Bool, Never> {
        $password
          .map { password in
              guard password.count > 0 else {
                  self.passwordErrorMessage = ""
                  return false
              }
              if password.count >= 6{
                  self.passwordErrorMessage = ""
                  return true
              }else{
                  self.passwordErrorMessage = "At_Least_6_Characters"
                  return false
              }
          }
          .eraseToAnyPublisher()
      }
    
    var passwordMatchesPublisher: AnyPublisher<Bool, Never> {
       Publishers.CombineLatest($password, $password1)
         .map { password, repeated in
             
             guard repeated.count > 0 && password.count > 0 else {
                 if password.count == 0 && repeated.count > 0{
                 self.confirmPasswordErrorMessage = "password_is_empty"
                 } else if repeated.count == 0 {
                     self.confirmPasswordErrorMessage = ""
                 }
                 return false
             }
             if password == repeated{
                 self.confirmPasswordErrorMessage = ""
                 return true
             }else{
                 self.confirmPasswordErrorMessage = "password_not_match"
                 return false
             }
         }
         .eraseToAnyPublisher()
     }
    
    var isSignupFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3 (
        isNameAndPhoneValidPunlisher,
        isPasswordValidPublisher,
        passwordMatchesPublisher)
        .map { isNameAndPhoneValid, isPasswordValid, passwordMatches in
            return isNameAndPhoneValid && isPasswordValid && passwordMatches
        }
        .eraseToAnyPublisher()
    }
    func checkvalidations(){
        isSignupFormValidPublisher
          .receive(on: RunLoop.main)
          .assign(to: \.formIsValid, on: self)
          .store(in: &cancellables)
    }

}
