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
    let passthroughModelSubject = PassthroughSubject<ModelLogin, Error>()
    private var cancellables: Set<AnyCancellable> = []
    let characterLimit: Int
    
    // ------- input
    @Published  var phoneNumber: String = "" {
        didSet{
            let filtered = phoneNumber.filter {$0.isNumber}
            if phoneNumber != filtered {
                phoneNumber = filtered
            }
            if self.phoneNumber.count < 11 || self.phoneNumber.count > 11 {
                self.phoneErrorMessage = "Phone Number Must Be 11 number"
            } else if self.phoneNumber.isEmpty {
                self.phoneErrorMessage = "*"
            } else if self.phoneNumber.count == 11 {
                self.phoneErrorMessage = ""
            }
        }
    }
    @Published  var password = ""
    
    
    //------- output
    @Published var phoneErrorMessage = ""
    @Published var isValid = false
    @Published var inlineErrorPassword = ""
    @Published var publishedUserLogedInModel: ModelLogin? = nil
    @Published var isLogedin = false
    @Published var isLoading:Bool? = false
    @Published var isError = false
    @Published var errorMsg = ""
    @Published var isNetworkError = false

    
    @Published var destination = AnyView(TabBarView())
    init(limit: Int = 11) {
        characterLimit = limit
        //     validations()
        //-----------------------------------------------------------------
        passthroughModelSubject.sink { (completion) in
            //            print(completion)
        } receiveValue: { (modeldata) in
            self.publishedUserLogedInModel = modeldata
            if self.publishedUserLogedInModel?.Data?.ProfileStatus == 0 {
                self.destination = AnyView(PersonalDataView())
            }else if self.publishedUserLogedInModel?.Data?.ProfileStatus == 1{
                self.destination = AnyView(MedicalStateView())
            
            }else if self.publishedUserLogedInModel?.Data?.ProfileStatus == 2{
                self.destination = AnyView(TabBarView())
            }
        }.store(in: &cancellables)
        
    }
    
    //    func validations(){
    //
    //         var isPhoneNumberValidPublisher: AnyPublisher<Bool,Never> {
    //            $phoneNumber
    //                .debounce(for: 0.8, scheduler: RunLoop.main)
    //                .removeDuplicates()
    //                .map{ $0.count >= 10}
    //                .eraseToAnyPublisher()
    //        }
    //         var isPasswordEmptyPublisher: AnyPublisher<Bool,Never> {
    //            $password
    //                .debounce(for: 0.8, scheduler: RunLoop.main)
    //                .removeDuplicates()
    //                .map{ $0.isEmpty}
    //                .eraseToAnyPublisher()
    //        }
    //
    //         var isPasswordsValidPublisher: AnyPublisher<PasswordStatus,Never> {
    //            Publishers.CombineLatest(isPasswordEmptyPublisher, arePasswordsEqualPublisher)
    //                .map{
    //                    if $0 {return PasswordStatus.empty}
    //                    if !$1 {return PasswordStatus.repeatedPasswordWrong}
    //                    return PasswordStatus.valid
    //                }
    //                .eraseToAnyPublisher()
    //        }
    //
    //         var isFormValidPublisher: AnyPublisher<Bool,Never> {
    //            Publishers.CombineLatest3(isPasswordsValidPublisher,isFullNameValidPublisher,isPhoneNumberValidPublisher)
    //                .map{ $0 == .valid && $1 && $2}
    //                .eraseToAnyPublisher()
    //        }
    //
    //        enum PasswordStatus {
    //            case empty
    //            case repeatedPasswordWrong
    //            case valid
    //        }
    //
    //        //----------
    //        isFormValidPublisher
    //            .receive(on: RunLoop.main)
    //            .assign(to: \.isValid, on: self)
    //            .store(in: &cancellables)
    //
    //        isPasswordsValidPublisher
    //            .dropFirst()
    //            .receive(on: RunLoop.main)
    //            .map{ passwordStatus in
    //                switch passwordStatus {
    //                case .empty:
    //                    return "Password cannot be Empty"
    //                case .repeatedPasswordWrong:
    //                    return "Passwords do not match"
    //                case .valid:
    //                    return ""
    //                }
    //            }
    //            .assign(to: \.inlineErrorPassword, on: self)
    //            .store(in: &cancellables)
    //
    //    }
    
    func startLoginApi(phone: String, password: String) {
        //        if isValid == true {
//        self.isLogedin = true
        
        if Helper.isConnectedToNetwork(){
            self.isLoading = true
        ApiService.LoginUser(phone: phone, password: password, completion: { (success, model, err) in
            
            if success {
                
                DispatchQueue.main.async {
                    //                    print(model!)
                    self.passthroughModelSubject.send(model!)
                    self.isLogedin = true
                    self.isLoading = false
                    
                   // self.passthroughModelSubject.send(model!)
                    Helper.setUserData(Id: model?.Data?.Id ?? 0, PhoneNumber: model?.Data?.Phone ?? "" )
                    Helper.setUserimage(userImage: URLs.BaseUrl+"\(model?.Data?.Image ?? "")")
                    Helper.setAccessToken(access_token: "Bearer " + "\(model?.Data?.Token ?? "")" )
                }
                //                print(modeldata)
            }else{
                self.isLoading = false
                print(err ?? "error here from LoginViewmodel")
                self.errorMsg = err ?? "Error msg login vm"
                self.isError = true

            }
        })
        }else{
                   // Alert with no internet connection
          isNetworkError = true
            self.isLoading = false

               }
            
        
        //        }else{
        //            print("not validated")
        //        }
    }
    
}
