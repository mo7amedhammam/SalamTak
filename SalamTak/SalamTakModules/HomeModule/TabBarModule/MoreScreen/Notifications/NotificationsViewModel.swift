//
//  ViewModel.swift
//  SalamTak
//
//  Created by wecancity on 05/01/2023.
//


import Foundation
import Combine
import Alamofire

enum NotificationOp {
case getnewcount, getnotifications
}
class NotificationsViewModel: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModel = PassthroughSubject<BaseResponse<NotificationCount>, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<[NotificationModel]>, Error>()
    private var cancellables: Set<AnyCancellable> = []
    
    //    // ------- input
    @Published var notificationop: NotificationOp = .getnewcount

    //    //------- output
    @Published var NewNotificationCount: Int = 0
    @Published var publishedNotificationsArray: [NotificationModel] = []
    @Published var isDone = false
    
    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
    init() {
        execute(operation: .getnewcount)
        
        passthroughModel.sink { (completion) in
        } receiveValue: {[weak self] (modeldata) in
            self?.NewNotificationCount = modeldata.data?.NewNotificationCount ?? 0
        }.store(in: &cancellables)
        
        passthroughModelSubject.sink { (completion) in
        } receiveValue: {[weak self] (modeldata) in
            self?.publishedNotificationsArray = modeldata.data ?? []
        }.store(in: &cancellables)
    }
}

extension NotificationsViewModel:TargetType{
    var url: String {
        switch notificationop{
        case .getnewcount:
            return URLs().GetNotificationsCount

        case .getnotifications:
            return URLs().GetNotifications

        }
    }
    
    var method: httpMethod {
        return .Get
    }
    
    var parameter: parameterType {
        return .plainRequest
    }
    
    var header: [String : String]? {
        let header = ["Authorization":Helper.getAccessToken()]
        return header
    }
    
    func execute(operation:NotificationOp){
        self.notificationop = operation
        switch operation {
        case .getnewcount:
            startFetchNotificationsCount()
        case .getnotifications:
            startFetchNotifications()
        }
    }
    
    func startFetchNotificationsCount(){
        if Helper.isConnectedToNetwork(){
            self.isLoading = true
            BaseNetwork.request(Target: self, responseModel: BaseResponse<NotificationCount>.self) { [self] (success, model, err) in
                if success{
                    //case of success
                    DispatchQueue.main.async {
                        self.isDone = true
                        self.passthroughModel.send(model!)
                    }
                }else{
                    if model != nil{
                        //case of model with error
                        message = model?.message ?? "Bad Request"
                        isAlert = true
                    }else{
                        if err == "Unauthorized"{
                            //case of Empty model (unauthorized)
                            activeAlert = .unauthorized
                            isAlert = true
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
    
    func startFetchNotifications(){
        if Helper.isConnectedToNetwork(){
            self.isLoading = true
            BaseNetwork.request(Target: self, responseModel: BaseResponse<[NotificationModel]>.self) { [self] (success, model, err) in
                if success{
                    //case of success
                    DispatchQueue.main.async {
                        self.isDone = true
                        self.passthroughModelSubject.send(model!)
                        print(model)
                    }
                }else{
                    if model != nil{
                        //case of model with error
                        message = model?.message ?? "Bad Request"
                        isAlert = true
                    }else{
                        if err == "Unauthorized"{
                            //case of Empty model (unauthorized)
                            activeAlert = .unauthorized
                            isAlert = true
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
