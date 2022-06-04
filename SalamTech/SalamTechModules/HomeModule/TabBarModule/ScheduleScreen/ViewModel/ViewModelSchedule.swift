//
//  ViewModelPersonalData.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 31/03/2022.
//

import Foundation
import Combine
import Alamofire

class ViewModelGetAppointmentInfo: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelGetSubject = PassthroughSubject<BaseResponse<[AppointmentInfo]>, Error>()
    let passCancelModel = PassthroughSubject<BaseResponse<CancelBody>, Error>()
    private var cancellables: Set<AnyCancellable> = []
 
    @Published var exmodelId  = 0
    @Published var AppointmentCancelID  = 0
    @Published var AppointmentCancelReason  = ""

    @Published var AppointmentsArr: [AppointmentInfo] = []
    @Published var AppointmentCancelObj: BaseResponse<CancelBody>?

    //------- output
    @Published var showcncel = false

    @Published var noschedules = false
    
    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
    @Published var appmethod : appointmentsReq = .getappointments
    
     init() {
         
         passthroughModelGetSubject.sink { (completion) in
        } receiveValue: { [self] (modeldata) in
            noschedules = false
            self.AppointmentsArr = modeldata.data ?? []
            if AppointmentsArr.count == 0 || AppointmentsArr == [] {
                noschedules = true
            }
        }.store(in: &cancellables)
        
        passCancelModel.sink { (completion) in
        } receiveValue: { (modeldata) in
            self.AppointmentCancelObj = modeldata
            
        }.store(in: &cancellables)
    }
        
}


extension ViewModelGetAppointmentInfo:TargetType{

    var url: String{
        switch appmethod{
        case .getappointments:
        let url = URLs().GetPatientAppointment
        let queryItems = [URLQueryItem(name:"medicalExaminationTypeId",value:"\(exmodelId)")]
        var urlComponents = URLComponents(string: url)
        urlComponents?.queryItems = queryItems
        let convertedUrl = urlComponents?.url
        if let convertUrl = convertedUrl {
            print(convertUrl)
        }
        return  convertedUrl?.absoluteString ?? ""

        case .cancelappointment:
            let url = URLs().CancelAppointmen
            let queryItems = [
                URLQueryItem(name:"AppointmentId",value:"\(AppointmentCancelID)"),
                URLQueryItem(name:"CancelReason",value:"\(AppointmentCancelReason)")
                            ]
            var urlComponents = URLComponents(string: url)
                urlComponents?.queryItems = queryItems
                let convertedUrl = urlComponents?.url
                if let convertUrl = convertedUrl {
                    print(convertUrl)
                }
            return  convertedUrl?.absoluteString ?? ""
        }
    }
    
    var method: httpMethod{
        switch appmethod{
        case .getappointments:
            return .Get
        case .cancelappointment:
            return .Get

        }
    }
    
    var parameter: parameterType{
        switch appmethod{
        case .getappointments:
            return .plainRequest
        case .cancelappointment:
            return .plainRequest
        }
    }
    
    var header: [String : String]? {
        switch appmethod{
        case .getappointments:
            return ["Authorization":Helper.getAccessToken()]

        case .cancelappointment:
            return ["Authorization":Helper.getAccessToken()]
        }
    }
    
    func execute(operation:appointmentsReq){
        appmethod = operation
        switch operation{
        case .getappointments:
            startFetchAppointmentInfo()

        case .cancelappointment:
            startFetchCancelAppointment()

        }
    }

func startFetchAppointmentInfo() {
    if Helper.isConnectedToNetwork(){
        self.isLoading = true

        BaseNetwork.request(Target: self, responseModel: BaseResponse<[AppointmentInfo]>.self) { [self] (success, model, err) in
            if success{
                //case of success
                DispatchQueue.main.async {
                    self.passthroughModelGetSubject.send( model!  )
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
                                activeAlert = .unauthorized
                    }else{
                        isAlert = true
                        message = err ?? "there is an error"
                                activeAlert = .serverError
                    }
                }
//                isAlert = true
            }
            isLoading = false
        }

    }else{
        //case of no internet connection
//        activeAlert = .NetworkError
        message = "Check_Your_Internet_Connection".localized(language)
        isAlert = true
    }

}

func startFetchCancelAppointment() {
    if Helper.isConnectedToNetwork(){
        self.isLoading = true

        BaseNetwork.request(Target: self, responseModel: BaseResponse<CancelBody>.self) { [self] (success, model, err) in
            if success{
                //case of success
                DispatchQueue.main.async {
                    self.passCancelModel.send( model!  )
                }

            }else{
                if model != nil{
                    //case of model with error
                    message = model?.message ?? "Bad Request"
                    activeAlert = .serverError
            }else{
                if err == "Unauthorized"{
                //case of Empty model (unauthorized)
                    message = "Session_expired\nlogin_again".localized(language)
                activeAlert = .unauthorized
                }else{
                    message = err ?? "there is an error"
                    activeAlert = .serverError
                }
            }
                isAlert = true
            }
            isLoading = false
        }

    }else{
        //case of no internet connection
        activeAlert = .NetworkError
        message = "Check_Your_Internet_Connection".localized(language)
        isAlert = true
    }

}

}

enum appointmentsReq{
    case getappointments
    case cancelappointment
}

