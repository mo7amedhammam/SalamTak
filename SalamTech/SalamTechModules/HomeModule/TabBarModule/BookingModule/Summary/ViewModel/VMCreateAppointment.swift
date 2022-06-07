//
//  VMCreateAppointment.swift
//  SalamTech
//
//  Created by wecancity on 25/04/2022.
//

import Foundation
import Combine
import Alamofire
import SwiftUI

class VMCreateAppointment: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let GetModelCreateAppointment = PassthroughSubject<BaseResponse<Statusmodel> , Error>()
    private var cancellables: Set<AnyCancellable> = []

    // ------- input
    @Published var DoctorId                            :Int = 0
    @Published var DoctorWorkingDayTimeId              :Int = 0
    @Published var AppointmentDate                       :String = ""
    @Published var Fees                      : Double = 0.0
    @Published var Comment                      : String = ""

    @Published var publishedCreateAppointment: Statusmodel?

    //------- output
    @Published var isDone:Bool = false
    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
    init() {
        GetModelCreateAppointment.sink { (completion) in
            //            print(completion)
        } receiveValue: { [self] (modeldata) in
            self.publishedCreateAppointment = modeldata.data
        }.store(in: &cancellables)
    }
 
}

extension VMCreateAppointment:TargetType{
    var url: String{
        return URLs().CreatePatientAppointment
    }
    
    var method: httpMethod{
        return .Post
    }
    
    var parameter: parameterType{
        let Parameters : [String:Any] = [
        // required
            "DoctorId": DoctorId ,
            "DoctorWorkingDayTimeId":DoctorWorkingDayTimeId,
            "AppointmentDate":AppointmentDate ,
            "Fees":Fees,
            "Comment":Comment
    ]

        return .parameterRequest(Parameters: Parameters, Encoding: JSONEncoding.default)
    }
    
    var header: [String : String]? {
        let header = ["Authorization":Helper.getAccessToken()]
        return header
    }

    
    func CreatePatientAppointment() {
        if Helper.isConnectedToNetwork(){
            self.isLoading = true

            BaseNetwork.request(Target: self, responseModel: BaseResponse<Statusmodel>.self) { [self] (success, model, err) in
                if success{
                    //case of success
                    DispatchQueue.main.async {
                        self.GetModelCreateAppointment.send( model!  )
                    }
                    isDone = true
                    activeAlert = .success
                    message = publishedCreateAppointment?.Statues ?? "Success"
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
