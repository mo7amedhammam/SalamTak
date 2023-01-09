//
//  ViewModelLogin.swift
//  Salamtech-Dr
//
//  Created by Mohamed Hammam on 06/01/2022.
//


import SwiftUI
import Alamofire
import Combine

class ViewModelLogin: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<LoginModel>, Error>()
    private var cancellables: Set<AnyCancellable> = []
    let characterLimit: Int
    
    // ------- input
    @Published  var phoneNumber: String = ""
    @Published  var password = ""
    
    @Published var formIsValid:Bool = false

    //------- output
    @Published var phoneErrorMessage = ""
    @Published var passwordErrorMessage = ""
    @Published var publishedUserLogedInModel: LoginModel? = nil
    @Published var isLogedin = false

    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""

    
    @Published var destination = AnyView(TabBarView())
    init(limit: Int = 11) {
        characterLimit = limit
        
        checkvalidations()
        passthroughModelSubject.sink { (completion) in
            //            print(completion)
        } receiveValue: { [weak self](modeldata) in
            self?.publishedUserLogedInModel = modeldata.data
            if self?.publishedUserLogedInModel?.ProfileStatus == 0 {
                self?.destination = AnyView(PatientInfoView(taskOP: .create,index:.constant(0))
                                                .navigationBarHidden(true))
            }else if self?.publishedUserLogedInModel?.ProfileStatus == 1{
                self?.destination = AnyView(PatientMedicalInfoView(taskOP:.create, index: .constant(1))
                                                .navigationBarHidden(true))
            
            }else if self?.publishedUserLogedInModel?.ProfileStatus == 2{
                Helper.setUserData(Id: self?.publishedUserLogedInModel?.Id ?? 0, PhoneNumber: self?.publishedUserLogedInModel?.Phone ?? "", patientName: modeldata.data?.Name ?? "" )
                Helper.setUserimage(userImage: URLs.BaseUrl+"\(modeldata.data?.Image ?? "")")
                self?.destination = AnyView(TabBarView()
                                                .navigationBarHidden(true))
                Helper.userLogedIn(value: true)
            }
            Helper.setAccessToken(access_token: "Bearer " + "\(modeldata.data?.Token ?? "")" )
            
        }.store(in: &cancellables)
        
    }
}


extension ViewModelLogin:TargetType    {

    var url: String {
        return  URLs().LoginUser
    }
    
    var method: httpMethod {
        return .Post
    }
    
    var parameter: parameterType {
        let parametersarr : [String : Any] =  ["Phone" : phoneNumber ,"Password" : password,"UserTypeId" : 3 ]
        return .parameterRequest(Parameters: parametersarr, Encoding: JSONEncoding.default)
    }
    
    var header: [String : String]? {
        let header = ["Content-Type":"application/json" , "Accept":"application/json"]
        return header
    }
    
    func startLoginApi(){
        
        if Helper.isConnectedToNetwork(){
            self.isLoading = true
            BaseNetwork.request(Target: self, responseModel: BaseResponse<LoginModel>.self) { [self] (success, model, err) in
                if success{
                    //case of success
                    DispatchQueue.main.async {
                        self.passthroughModelSubject.send(model!)
                        self.isLogedin = true
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

extension ViewModelLogin{
    
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
    
    var isSignupFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest (
        isPhoneValidPublisher,
        isPasswordValidPublisher)
        .map { isPhoneValid, isPasswordValid in
            return isPhoneValid && isPasswordValid
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
