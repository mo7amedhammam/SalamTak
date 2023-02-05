//
//  ViewModelDocDetails.swift
//  SalamTech
//
//  Created by Mohamed Hammam on 18/04/2022.
//


import Foundation
import Combine
import Alamofire
import SwiftUI

class ViewModelDocDetails: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let GetModelDocDetails = PassthroughSubject<BaseResponse<DocDetails> , Error>()
    private var cancellables: Set<AnyCancellable> = []
    
    // ------- input
    @Published var DoctorId                            :Int = 0
    @Published var MedicalExaminationTypeId              :Int = 0
    @Published var ClinicId                               :Int = 0
    @Published var SchedualDate                      : Date = Date()

    //------- output
    @Published var publishedModelSearchDoc: DocDetails?

    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""

    
    init() {
   
        GetModelDocDetails.sink { (completion) in
            //            print(completion)
        } receiveValue: { [self] (modeldata) in
            self.publishedModelSearchDoc = modeldata.data
        }.store(in: &cancellables)
    }
}


extension ViewModelDocDetails:TargetType{
    var url: String{
        return URLs().DoctorDetails
    }
    
    var method: httpMethod{
        return .Post
    }
    
    var parameter: parameterType{
        let Parameters : [String:Any] = [
        // required
            "DoctorId": DoctorId ,
            "MedicalExaminationTypeId":MedicalExaminationTypeId,
            "ClinicId":ClinicId ,
            "SchedualDate":ChangeFormate(NewFormat: "yyyy-MM-dd").string(from: SchedualDate)
            
    ]
        return .parameterRequest(Parameters: Parameters, Encoding: JSONEncoding.default)
    }
    
    var header: [String : String]? {
        return [:]
    }

    
    func FetchDoctorDetails() {
        if Helper.isConnectedToNetwork(){
            self.isLoading = true
print(url)
            print(parameter)
            BaseNetwork.request(Target: self, responseModel: BaseResponse<DocDetails>.self) { [self] (success, model, err) in
               print(model)
                if success{
                    //case of success
                    DispatchQueue.main.async {
                        self.GetModelDocDetails.send( model!  )
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
