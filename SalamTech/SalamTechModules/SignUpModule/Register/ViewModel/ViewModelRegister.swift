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
    let passthroughModelSubject = PassthroughSubject<ModelRegister, Error>()
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
    @Published var publishedUserRegisteredModel: ModelRegister? = nil
    @Published var isRegistered = false
    @Published var isLoading:Bool? = false
    @Published var isError = false
    @Published var errorMsg = ""
    @Published private var UserCreated = false
    @Published var isNetworkError = false
    
    
    

    //    @Published var receivededmodel: registerModel? = nil
    
//    @Published var receivededmodel = registerModel(Data: userData(Code: 0, ReSendCounter: 0, UserId: 0) , MessageCode: 0, Success: false, Message: "")
  
   
    init(limit: Int = 11) {
        
        characterLimit = limit
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
//    func isValidEmail(testStr:String) -> Bool {
//                print("validate emilId: \(testStr)")
//                let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
//                let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//                let result = emailTest.evaluate(with: testStr)
//                return result
//            }
    
    func validations(){
        
//        var isEmailValidPublisher: AnyPublisher<Bool,Never>{
//               $email
//                   .removeDuplicates()
//                   .map { $0.trimmingCharacters(in: .whitespacesAndNewlines).count >= 10}
//                   .handleEvents(receiveOutput: { [weak self] in $0 ? (self?.emailMessage = "") : (self?.emailMessage = "Invalid email")})
//                   .eraseToAnyPublisher()
//           }
        
         var isFullNameValidPublisher: AnyPublisher<Bool,Never> {
            $fullName
                .debounce(for: 0.8, scheduler: RunLoop.main)
                .removeDuplicates()
                .map{ $0.count >= 4}
                .eraseToAnyPublisher()
        }
        
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
        
        //----------
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
    
    func startFetchUserRegisteration(fullname:String, email: String, phone:String, password:String) {
        if Helper.isConnectedToNetwork(){
//        if isValid == true {
            self.isLoading = true
        ApiService.userRegister(name: fullname, email: email, phone: phone, password: password, completion: { (success, modeldata, err) in
            
            if success{
                DispatchQueue.main.async {
                    self.passthroughModelSubject.send(modeldata!)
                    self.isRegistered = true
                    self.isLoading = false
                }
                print(modeldata?.Data?.Code ?? 0000)
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
