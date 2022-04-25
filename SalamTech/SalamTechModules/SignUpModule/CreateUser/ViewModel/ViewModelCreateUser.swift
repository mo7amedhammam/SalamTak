//
//  ViewModelCreateUser.swift
//  Salamtech-Dr
//
//  Created by wecancity on 08/01/2022.
//

import Foundation
import Combine
import Alamofire

class ViewModelCreateUser: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<ModelCreateUser, Error>()
    private var cancellables: Set<AnyCancellable> = []
    
    // ------- input
    @Published  var fullName: String = ""
    @Published  var email: String = ""
    @Published  var phoneNumber: String = ""
    @Published  var phoneNumber1: String = "+20 | "
    @Published  var password = ""
    @Published  var password1 = ""

    
    //------- output
    @Published var isValid = false
    @Published var inlineErrorPassword = ""
    @Published var publishedUserCreatededModel: ModelCreateUser? = nil
    @Published var isRegistered = false
    @Published var isError = false
    @Published var errorMsg = ""
    @Published private var UserCreated = false
    @Published var isNetworkError = false


    init() {
      
//     validations()
        //-----------------------------------------------------------------
        passthroughModelSubject.sink { (completion) in
            //            print(completion)
        } receiveValue: { (modeldata) in
            self.publishedUserCreatededModel = modeldata
        }.store(in: &cancellables)
        
    }
    

    
  
    func startFetchUserCreation(name:String, email: String, phone:String, password:String) {
        
        if Helper.isConnectedToNetwork(){
            ApiService.CreateUser(Name: name, Email: email, Phone: phone, Password: password,completion: { (success, model, err) in
            
            if success{
                print("user created from viewmodel create user")

                DispatchQueue.main.async {
                    self.passthroughModelSubject.send(model!)
                    self.isRegistered = true
//
//                    print(model?.Message ?? "")
//                    print(model?.Data?.Phone ?? "")
//                    print(model?.Data?.Token ?? "")

                    Helper.setUserData(Id: model?.Data?.Id ?? 0, PhoneNumber: model?.Data?.Phone ?? "", patientName: "model?.Data?.Name" )
                    Helper.setAccessToken(access_token: "Bearer " + "\(model?.Data?.Token ?? "")")
                    Helper.setUserimage(userImage: URLs.BaseUrl+"\(model?.Data?.Image ?? "")")

                }
                //                print(modeldata)
            }else{
                print(err ?? "error here from create userViewmodel")
                self.isError = true
                self.errorMsg = err ?? "Error"
            }
        })
        }else{
                   // Alert with no internet connection
          isNetworkError = true
               }
       
    }
    
 
}
