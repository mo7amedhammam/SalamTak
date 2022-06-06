//
//  VMSearchDoc.swift
//  SalamTech
//
//  Created by Mohamed Hammam on 05/04/2022.
//

import Foundation
import Combine
import Alamofire
import SwiftUI

class VMSearchDoc: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let ModelFetchDoctors = PassthroughSubject<BaseResponse<ModelDoc<[Doc]>> , Error>()
    let ModelFetchMoreDoctors = PassthroughSubject<BaseResponse<ModelDoc<[Doc]>> , Error>()

    private var cancellables: Set<AnyCancellable> = []
    // ------- input
    @Published var searchDocOperation : searchDocType = .fetchDoctors

    
    @Published var MaxResultCount                      :Int = 0
    @Published var SkipCount                            :Int = 0
    @Published var SpecialistId                         :Int = 0
    @Published var MedicalExaminationTypeId           :Int = 0
    @Published var DoctorName                           :String?
    @Published var CityId                                :Int? = 0
    @Published var AreaId                                :Int? = 0
    @Published var GenderId                              :Int? = 0
    @Published var Fees                                   :Int? = 0
    @Published var SeniortyLevelId                      :Int? = 0
    @Published var SubSpecialistId                      :[Int]? = []
    
//MARK: --- Filter ------
    @Published var FilterSpecialistId                        :Int? = 0
    @Published var FilterCityId                               :Int? = 0
    @Published var FilterAreaId                               :Int? = 0
    @Published var FilterGenderId                             :Int? = 0
    @Published var FilterFees                                  :Int? = 0
    @Published var FilterSeniortyLevelId                     :Int? = 0
    @Published var FilterSubSpecialistId                     :[Int]? = []
 
    //------- output
    @Published var isValid = false
    @Published var inlineErrorPassword = ""
    
    @Published var publishedModelSearchDoc: [Doc] = [Doc.init( id: 7878787878787, FeesFrom: 78787878787, DoctorName: "", SubSpecialistName: [], MedicalExamationTypeImage: [])]
    
//    @Published var isLoading:Bool?
//    @Published var isError = false
//    @Published var errorMsg = ""
//    @Published var isDone = false
//    @Published var isNetworkError = false
//    @Published var SessionExpired = false
    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""

    @Published var noDoctors = false
    
    init() {

        ModelFetchDoctors.sink { (completion) in
            //            print(completion)
        } receiveValue: { [weak self]  (modeldata) in
            self?.noDoctors = false
            switch self?.searchDocOperation {
            case .fetchDoctors:
                self?.publishedModelSearchDoc = modeldata.data?.Items ?? []
                
                if self?.publishedModelSearchDoc == [] || self?.publishedModelSearchDoc.isEmpty == true {
                    self?.noDoctors = true
                }
            case .fetchMoreDoctors:
                self?.publishedModelSearchDoc.append( contentsOf: modeldata.data?.Items ?? [])
                if self?.publishedModelSearchDoc == [] || self?.publishedModelSearchDoc.isEmpty == true {
                    self?.noDoctors = true
                }
            case .none:
                break
            }
           
        
  
        }.store(in: &cancellables)
        
//        ModelFetchMoreDoctors.sink { (completion) in
//            //            print(completion)
//        } receiveValue: { [weak self] (modeldata) in
//            self?.noDoctors = false
//
//
//        }.store(in: &cancellables)
    
    }
        
    
//    func FetchDoctors() {
//        var Parameters : [String:Any] = [
//        // required
//            "MaxResultCount": MaxResultCount ,
//            "SkipCount":SkipCount,
//            "SpecialistId":FilterSpecialistId == 0 ? SpecialistId:FilterSpecialistId ?? true ,
//            "MedicalExaminationTypeId":MedicalExaminationTypeId
//    ]
//        // optional
//        if DoctorName != ""{
//            Parameters["DoctorName"] = DoctorName
//        }
//
//        if FilterCityId != 0{
//            Parameters["CityId"] = FilterCityId
//        }else if CityId != 0{
//            Parameters["CityId"] = CityId
//        }
//
//        if FilterAreaId != 0{
//            Parameters["AreaId"] = FilterAreaId
//        }else  if AreaId != 0{
//            Parameters["AreaId"] = AreaId
//        }
//
//        if FilterFees != 0{
//            Parameters["Fees"] = FilterFees
//        }else if Fees != 0{
//            Parameters["Fees"] = Fees
//        }
//
//        if FilterGenderId != 0{
//            Parameters["GenderId"] = FilterGenderId
//        }else if GenderId != 0{
//            Parameters["GenderId"] = GenderId
//        }
//
//        if FilterSeniortyLevelId != 0{
//            Parameters["SeniortyLevelId"] = FilterSeniortyLevelId
//        }else if SeniortyLevelId != 0{
//            Parameters["SeniortyLevelId"] = SeniortyLevelId
//        }
//
//        if FilterSubSpecialistId != []{
//            Parameters["SubSpecialistId"] = FilterSubSpecialistId
//        }else if SubSpecialistId != []{
//            Parameters["SubSpecialistId"] = SubSpecialistId
//        }
//
//
//        if Helper.isConnectedToNetwork(){
//            print(Parameters)
//
//            APISearchDoc.SearchDoctors(parameters: Parameters,
//        completion:  { (success, model, err) in
//
//                self.isLoading = true
//            if success{
//                DispatchQueue.main.async {
//                    self.ModelFetchDoctors.send(model!)
//                    self.isLoading = false
//                    self.isDone = true
//                    print(model!)
//                }
//            }else{
//                self.isLoading = false
//                self.isError = true
//                print(model?.message ?? "")
//                self.errorMsg = err ?? "cannot get Doctors"
//            }
//        })
//            self.isLoading = false
//
//        }else{
//                   // Alert with no internet connection
//            self.isLoading = false
//          isNetworkError = true
//               }
//    }
    
//    func FetchMoreDoctors() {
//        var Parameters : [String:Any] = [
//        // required
//            "MaxResultCount": MaxResultCount ,
//            "SkipCount":SkipCount,
//            "SpecialistId":SpecialistId ,
//            "MedicalExaminationTypeId":MedicalExaminationTypeId
//    ]
//        // optional
//        if DoctorName != ""{
//            Parameters["DoctorName"] = DoctorName
//        }
//
//        if FilterCityId != 0{
//            Parameters["CityId"] = FilterCityId
//        }else if CityId != 0{
//            Parameters["CityId"] = CityId
//        }
//
//        if FilterAreaId != 0{
//            Parameters["AreaId"] = FilterAreaId
//        }else  if AreaId != 0{
//            Parameters["AreaId"] = AreaId
//        }
//
//        if FilterFees != 0{
//            Parameters["Fees"] =  FilterFees
//        }else if Fees != 0{
//            Parameters["Fees"] = Fees
//        }
//
//        if FilterGenderId != 0{
//            Parameters["GenderId"] = FilterGenderId
//        }else if GenderId != 0{
//            Parameters["GenderId"] = GenderId
//        }
//
//        if FilterSeniortyLevelId != 0{
//            Parameters["SeniortyLevelId"] = FilterSeniortyLevelId
//        }else if SeniortyLevelId != 0{
//            Parameters["SeniortyLevelId"] = SeniortyLevelId
//        }
//
//        if FilterSubSpecialistId != []{
//            Parameters["SubSpecialistId"] = FilterSubSpecialistId
//        }else if SubSpecialistId != []{
//            Parameters["SubSpecialistId"] = SubSpecialistId
//        }
//
//        if Helper.isConnectedToNetwork(){
//            print(Parameters)
//            APISearchDoc.SearchDoctors(parameters: Parameters,
//        completion:  { (success, model, err) in
//
//                self.isLoading = true
//            if success{
//                DispatchQueue.main.async {
//                    self.ModelFetchMoreDoctors.send(model!)
//                    self.isLoading = false
//                    self.isDone = true
//                    print(model!)
//                }
//            }else{
//                self.isLoading = false
//                self.isError = true
//                print(model?.message ?? "")
//                self.errorMsg = err ?? "cannot get Doctors"
//            }
//        })
//            self.isLoading = false
//
//        }else{
//                   // Alert with no internet connection
//            self.isLoading = false
//          isNetworkError = true
//               }
//    }

}


enum searchDocType{
    case fetchDoctors, fetchMoreDoctors
}

extension VMSearchDoc:TargetType{

    var url: String{
        switch searchDocOperation{
            
        case .fetchDoctors:
       return URLs().DoctorSearch
                
        case .fetchMoreDoctors:
            return URLs().DoctorSearch
        }
    }
    
    var method: httpMethod{
//        switch searchDocOperation{
//        case .fetchDoctors:
            return .Post
//        case .fetchMoreDoctors:
//            return .Post
//
//        }
    }
    
    var parameter: parameterType{
//        switch searchDocOperation{
//        case .fetchDoctors:
        var Parameters : [String:Any] = [
                // required
                    "MaxResultCount": MaxResultCount ,
                    "SkipCount":SkipCount,
                    "SpecialistId":FilterSpecialistId == 0 ? SpecialistId:FilterSpecialistId ?? true ,
                    "MedicalExaminationTypeId":MedicalExaminationTypeId
            ]
                // optional
                if DoctorName != ""{
                    Parameters["DoctorName"] = DoctorName
                }
                
                if FilterCityId != 0{
                    Parameters["CityId"] = FilterCityId
                }else if CityId != 0{
                    Parameters["CityId"] = CityId
                }
                
                if FilterAreaId != 0{
                    Parameters["AreaId"] = FilterAreaId
                }else  if AreaId != 0{
                    Parameters["AreaId"] = AreaId
                }
                
                if FilterFees != 0{
                    Parameters["Fees"] = FilterFees
                }else if Fees != 0{
                    Parameters["Fees"] = Fees
                }
                
                if FilterGenderId != 0{
                    Parameters["GenderId"] = FilterGenderId
                }else if GenderId != 0{
                    Parameters["GenderId"] = GenderId
                }
                
                if FilterSeniortyLevelId != 0{
                    Parameters["SeniortyLevelId"] = FilterSeniortyLevelId
                }else if SeniortyLevelId != 0{
                    Parameters["SeniortyLevelId"] = SeniortyLevelId
                }
                
                if FilterSubSpecialistId != []{
                    Parameters["SubSpecialistId"] = FilterSubSpecialistId
                }else if SubSpecialistId != []{
                    Parameters["SubSpecialistId"] = SubSpecialistId
                }
            return .parameterRequest(Parameters: Parameters, Encoding: JSONEncoding.default)
//        case .fetchMoreDoctors:
//            var Parameters : [String:Any] = [
//                // required
//                "MaxResultCount": MaxResultCount ,
//                "SkipCount":SkipCount,
//                "SpecialistId":SpecialistId ,
//                "MedicalExaminationTypeId":MedicalExaminationTypeId
//            ]
//            // optional
//            if DoctorName != ""{
//                Parameters["DoctorName"] = DoctorName
//            }
//
//            if FilterCityId != 0{
//                Parameters["CityId"] = FilterCityId
//            }else if CityId != 0{
//                Parameters["CityId"] = CityId
//            }
//
//            if FilterAreaId != 0{
//                Parameters["AreaId"] = FilterAreaId
//            }else  if AreaId != 0{
//                Parameters["AreaId"] = AreaId
//            }
//
//            if FilterFees != 0{
//                Parameters["Fees"] =  FilterFees
//            }else if Fees != 0{
//                Parameters["Fees"] = Fees
//            }
//
//            if FilterGenderId != 0{
//                Parameters["GenderId"] = FilterGenderId
//            }else if GenderId != 0{
//                Parameters["GenderId"] = GenderId
//            }
//
//            if FilterSeniortyLevelId != 0{
//                Parameters["SeniortyLevelId"] = FilterSeniortyLevelId
//            }else if SeniortyLevelId != 0{
//                Parameters["SeniortyLevelId"] = SeniortyLevelId
//            }
//
//            if FilterSubSpecialistId != []{
//                Parameters["SubSpecialistId"] = FilterSubSpecialistId
//            }else if SubSpecialistId != []{
//                Parameters["SubSpecialistId"] = SubSpecialistId
//            }
//
//            return .parameterRequest(Parameters: Parameters, Encoding: JSONEncoding.default)
//        }
    }
    
    var header: [String : String]? {
//        switch searchDocOperation{
//        case .fetchDoctors:
            return ["Authorization":Helper.getAccessToken()]

//        case .fetchMoreDoctors:
//            return ["Authorization":Helper.getAccessToken()]
//        }
    }
    
//    func execute(operation:searchDocType){
//        searchDocOperation = operation
////        switch operation{
////        case .fetchDoctors:
//        FetchDoctors(operation: .fetchDoctors)
//
////        case .fetchMoreDoctors:
////            startFetchCancelAppointment()
////
////        }
//    }

func FetchDoctors(operation:searchDocType){
    searchDocOperation = operation

    if Helper.isConnectedToNetwork(){
        self.isLoading = true

        BaseNetwork.request(Target: self, responseModel: BaseResponse<ModelDoc<[Doc]>>.self) { [self] (success, model, err) in
            if success{
                //case of success
                DispatchQueue.main.async {
                    self.ModelFetchDoctors.send( model!  )
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

//func startFetchCancelAppointment() {
//    if Helper.isConnectedToNetwork(){
//        self.isLoading = true
//
//        BaseNetwork.request(Target: self, responseModel: BaseResponse<CancelBody>.self) { [self] (success, model, err) in
//            if success{
//                //case of success
//                DispatchQueue.main.async {
//                    self.passCancelModel.send( model!  )
//                }
//
//            }else{
//                if model != nil{
//                    //case of model with error
//                    message = model?.message ?? "Bad Request"
//                    activeAlert = .serverError
//            }else{
//                if err == "Unauthorized"{
//                //case of Empty model (unauthorized)
//                    message = "Session_expired\nlogin_again".localized(language)
//                activeAlert = .unauthorized
//                }else{
//                    message = err ?? "there is an error"
//                    activeAlert = .serverError
//                }
//            }
//                isAlert = true
//            }
//            isLoading = false
//        }
//
//    }else{
//        //case of no internet connection
//        activeAlert = .NetworkError
//        message = "Check_Your_Internet_Connection".localized(language)
//        isAlert = true
//    }
//
//}

}
