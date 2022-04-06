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
    let passthroughModelSubject = PassthroughSubject<ModelResetPassword, Error>()
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
    @Published var publishedUserResetModel: ModelResetPassword? = nil
    @Published var isRegistered = false
    @Published var isLoading:Bool? = false
    @Published var isError = false
    @Published var errorMsg = ""
    @Published private var UserCreated = false
    @Published var isNetworkError = false
    
    
    

    //    @Published var receivededmodel: registerModel? = nil
    
//    @Published var receivededmodel = registerModel(Data: userData(Code: 0, ReSendCounter: 0, UserId: 0) , MessageCode: 0, Success: false, Message: "")
  
   
    init() {
        
      
    
        //-----------------------------------------------------------------
        passthroughModelSubject.sink { (completion) in
            //            print(completion)
        } receiveValue: { (modeldata) in
            self.publishedUserResetModel = modeldata
//            self.verify.passedOTP = modeldata.Data?.Code ?? 000
//            createUserWith.init(name: self.fullName, email: self.email, Phone: self.phoneNumber, password: self.password, OTP: modeldata.Data?.Code ?? 0)
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
//    func isValidEmail(testStr:String) -> Bool {
//                print("validate emilId: \(testStr)")
//                let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
//                let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
//                let result = emailTest.evaluate(with: testStr)
//                return result
//            }
    
    
    
    func startFetchResetPassword( email: String) {
        if Helper.isConnectedToNetwork(){
//        if isValid == true {
            self.isLoading = true
        ApiService.resetPassword( email: email, completion: { (success, modeldata, err) in
            
            if success{
                DispatchQueue.main.async {
                    self.passthroughModelSubject.send(modeldata!)
                    self.isRegistered = true
                    self.isLoading = false
                }
                print(modeldata?.data?.code ?? 0000)
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
    
    
    
    
}

