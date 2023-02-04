//
//  ViewModelOtherMedicalServices.swift
//  SalamTak
//
//  Created by wecancity on 30/01/2023.
//

import Foundation
import Combine
import SwiftUI
import Alamofire

class ViewModelOtherMedicalServices: ObservableObject {
    var language = LocalizationService.shared.language

    let passthroughSubject = PassthroughSubject<String, Error>()
    let ModelExTypeId = PassthroughSubject<BaseResponse<[ModelOtherMedicalServices]>, Error>()
        private var cancellables: Set<AnyCancellable> = []
    
    //------- inputs
    @Published var medicalServiseId: Int = 0
    @Published var medicalServiseName: String = ""

    @Published var CityId: Int = 0
    @Published var CityName: String = ""

    @Published var AreaId: Int = 0
    @Published var AreaName: String = ""
    
    //------- output
    @Published var publishedOtherMedicalServicesArr: [ModelOtherMedicalServices] = []
    let medicalServises:[ExaminationType] = [
//        ExaminationType.init(id: 1, Name: "Private_Clinic", image: "newcliniclogo", Inactive: false),
        ExaminationType.init(id: 2, Name: "Hospitals_",image: "Hospitals", Inactive: false),
        ExaminationType.init(id: 6, Name: "Polyclinic_",image: "Polyclinics", Inactive: false),
        ExaminationType.init(id: 5, Name: "Pharmacies_",image: "Pharmacies", Inactive: false),
        ExaminationType.init(id: 3, Name: "Labs_",image: "Laboratories", Inactive: false),
        ExaminationType.init(id: 4, Name: "Scan_",image: "RadiologyCenter", Inactive: false)
    ]
    @Published var noData = false
    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
    init() {
        ModelExTypeId.sink { (completion) in
        } receiveValue: { [self] (modeldata) in
            self.publishedOtherMedicalServicesArr = modeldata.data ?? []
            if (modeldata.data ?? []) == []{
                noData = true
            }
        }.store(in: &cancellables)
    }
}



extension ViewModelOtherMedicalServices:TargetType{
    var url: String{
        return URLs().GetHealthEntity
    }
    
    var method: httpMethod{
        return .Post
    }
    
    var parameter: parameterType{
        let parametersarr : [String : Any]  = ["CityId" : CityId ,"AreaId" : AreaId,
                                               "MedicalExaminationTypeId" : medicalServiseId
                                                ]
        return .parameterRequest(Parameters: parametersarr, Encoding: JSONEncoding.default)
    }
    
    var header: [String : String]? {
    let header = ["Authorization":Helper.getAccessToken()]
        return header
    }

    
    func GetOtherMedicalServices() {
        if Helper.isConnectedToNetwork(){
            print(url)
            print(parameter)
            self.isLoading = true

            BaseNetwork.request(Target: self, responseModel: BaseResponse<[ModelOtherMedicalServices]>.self) { [self] (success, model, err) in
                if success{
                    //case of success
                    DispatchQueue.main.async {
                        self.noData = false
                        self.ModelExTypeId.send( model!  )
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
