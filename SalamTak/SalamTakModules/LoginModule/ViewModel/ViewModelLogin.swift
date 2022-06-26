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
    @Published  var phoneNumber: String = "" {
        didSet{
            let filtered = phoneNumber.filter {$0.isNumber}
            if phoneNumber != filtered {
                phoneNumber = filtered
            }
            if self.phoneNumber.count < 11 || self.phoneNumber.count > 11 {
                self.phoneErrorMessage = "Phone Number Must be 11 number"
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
//    @Published var inlineErrorPassword = ""
    @Published var publishedUserLogedInModel: LoginModel? = nil
    @Published var isLogedin = false

    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""

    
    @Published var destination = AnyView(TabBarView())
    init(limit: Int = 11) {
        characterLimit = limit

        passthroughModelSubject.sink { (completion) in
            //            print(completion)
        } receiveValue: { [self](modeldata) in
            publishedUserLogedInModel = modeldata.data
            if publishedUserLogedInModel?.ProfileStatus == 0 {
                destination = AnyView(PersonalDataView())
            }else if publishedUserLogedInModel?.ProfileStatus == 1{
                destination = AnyView(MedicalStateView())
            
            }else if self.publishedUserLogedInModel?.ProfileStatus == 2{
                Helper.setUserData(Id: publishedUserLogedInModel?.Id ?? 0, PhoneNumber: publishedUserLogedInModel?.Phone ?? "", patientName: publishedUserLogedInModel?.Name ?? "" )
                Helper.setUserimage(userImage: URLs.BaseUrl+"\(publishedUserLogedInModel?.Image ?? "")")
                destination = AnyView(TabBarView())
            }
            Helper.setAccessToken(access_token: "Bearer " + "\(publishedUserLogedInModel?.Token ?? "")" )
            
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
