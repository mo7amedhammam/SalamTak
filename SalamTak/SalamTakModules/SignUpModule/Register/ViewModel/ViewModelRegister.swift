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
    @Published  var fullName: String = ""{
        didSet{
            if self.fullName.isEmpty{
                self.nameErrorMessage = "*"
            } else {
                self.nameErrorMessage = ""
            }
        }
    }
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
    @Published  var phoneNumber: String = "" {
        didSet{
//            if phoneNumber.count > limit {
//                phoneNumber = String(phoneNumber.prefix(limit))
//            }
            let filtered = phoneNumber.filter {$0.isNumber}
            if phoneNumber != filtered {
                phoneNumber = filtered
            }
            if  self.phoneNumber.count > 8 && self.phoneNumber.count < 11 || self.phoneNumber.count > 11 {
                self.phoneErrorMessage = "Phone Number Must Be 11 number"
            } else if self.phoneNumber.isEmpty {
                self.phoneErrorMessage = "*"
            } else if self.phoneNumber.count == 11 {
                self.phoneErrorMessage = ""
            }
        }
    }
    @Published  var phoneNumber1: String = "+20 | "
    @Published  var password = ""
    @Published  var password1 = ""
    


    
    //------- output
    @Published var nameErrorMessage = ""
    @Published var emailErrorMessage = ""
    @Published var phoneErrorMessage = ""
    @Published var isValid = false
    @Published var inlineErrorPassword = ""
    @Published var publishedUserRegisteredModel: RegisterModel? = nil
    @Published var isRegistered = false
    @Published private var UserCreated = false
        
    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
   
    init(limit: Int = 11) {
        
        characterLimit = limit
     validations()
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

    func validations(){
 
        
         var isFullNameValidPublisher: AnyPublisher<Bool,Never> {
            $fullName
                .debounce(for: 0.8, scheduler: RunLoop.main)
                .removeDuplicates()
                .map{ $0.count >= 4}
                .eraseToAnyPublisher()
        }

         var isPhoneNumberValidPublisher: AnyPublisher<Bool,Never> {
            $phoneNumber
                .debounce(for: 0.8, scheduler: RunLoop.main)
                .removeDuplicates()
                .map{ $0.count == 11 }
                .eraseToAnyPublisher()
        }
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
        
         var isFormValidPublisher: AnyPublisher<Bool,Never> {
            Publishers.CombineLatest3(isPasswordsValidPublisher,isFullNameValidPublisher,isPhoneNumberValidPublisher)
                .map{ $0 == .valid && $1 && $2}
                .eraseToAnyPublisher()
        }
        
        enum PasswordStatus {
            case notemail
            case empty
            case repeatedPasswordWrong
            case valid
        }
        
        isFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
            .store(in: &cancellables)
        
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
