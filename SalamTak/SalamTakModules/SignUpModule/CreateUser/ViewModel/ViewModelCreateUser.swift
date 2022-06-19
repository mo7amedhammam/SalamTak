//
//  ViewModelCreateUser.swift
//  Salamtech-Dr
//
//  Created by Mohamed Hammam on 08/01/2022.
//

import Foundation
import Combine
import Alamofire

class ViewModelCreateUser: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<CreateUserModel>, Error>()
    private var cancellables: Set<AnyCancellable> = []
    
    // ------- input
    @Published  var fullName: String = ""
    @Published  var email: String = ""
    @Published  var phoneNumber: String = ""
    @Published  var password = ""
    
    //------- output
    @Published var publishedUserCreatededModel: CreateUserModel? = nil
    @Published var isRegistered = false
    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""

    init() {
      
        passthroughModelSubject.sink { (completion) in
            //            print(completion)
        } receiveValue: {[self] (modeldata) in
            publishedUserCreatededModel = modeldata.data
            
            isRegistered = true
                           Helper.setUserData(Id: publishedUserCreatededModel?.Id ?? 0, PhoneNumber: publishedUserCreatededModel?.Phone ?? "", patientName: "model?.Data?.Name" )
                           Helper.setAccessToken(access_token: "Bearer " + "\(publishedUserCreatededModel?.Token ?? "")")
                           Helper.setUserimage(userImage: URLs.BaseUrl+"\(publishedUserCreatededModel?.Image ?? "")")
        }.store(in: &cancellables)
        
    }
}


extension ViewModelCreateUser:TargetType{
   
    var url: String {
            return  URLs().CreateUser
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
    
    func startFetchUserCreation(){
        
        if Helper.isConnectedToNetwork(){
            self.isLoading = true
            BaseNetwork.request(Target: self, responseModel: BaseResponse<CreateUserModel>.self ) { [self] (success, model, err) in
                if success{
                    //case of success
                    DispatchQueue.main.async {
                        self.passthroughModelSubject.send(model!)
                        self.isRegistered = true
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
