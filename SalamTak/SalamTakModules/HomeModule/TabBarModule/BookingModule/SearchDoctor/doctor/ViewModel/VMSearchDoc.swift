//
//  VMSearchDoc.swift
//  SalamTech
//
//  Created by Mohamed Hammam on 05/04/2022.
//

import Foundation
import Combine
import Alamofire
//import SwiftUI

class VMSearchDoc: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let ModelFetchDoctors = PassthroughSubject<BaseResponse<ModelDoc<[Doc]>> , Error>()
    private var cancellables: Set<AnyCancellable> = []

    @Published var searchDocOperation : searchDocType = .fetchDoctors
    @Published var publishedModelSearchDoc: [Doc] = []
//    [Doc.init( id: 7878787878787, FeesFrom: 78787878787, DoctorName: "", SubSpecialistName: [], MedicalExamationTypeImage: [])]
    
    //MARK: --- inputs ------
    @Published var MaxResultCount                      :Int = 10
    @Published var SkipCount                            :Int = 0
    @Published var SpecialistId                         :Int = 0
    @Published var SpecialistName                         :String = ""

    @Published var MedicalExaminationTypeId           :Int = 0
    @Published var DoctorName                           :String = ""
    @Published var CityId                                :Int? = 0
    @Published var CityName                                :String? = ""

    @Published var AreaId                                :Int? = 0
    @Published var AreaName                                :String? = ""

    @Published var GenderId                              :Int? = 0
    @Published var Fees                                   :Int? = 0
    @Published var SeniortyLevelId                      :Int? = 0
    @Published var SubSpecialistId                      :[Int]? = []
    @Published var SubSpecialistName                      :[String]? = []

    //MARK: --- Filter ------
    @Published var FilterSpecialistId                        :Int = 0
    @Published var FilterSpecialistName                        :String? = ""

    @Published var FilterCityId                               :Int? = 0
    @Published var FilterCityName                             :String? = ""
    @Published var FilterAreaId                               :Int? = 0
    @Published var FilterAreaName                               :String? = ""

    @Published var FilterGenderId                             :Int? = 0
    @Published var FilterMinFees                                  :String = ""
    @Published var FilterMaxFees                                  :String = ""

    @Published var FilterSeniortyLevelId                     :Int? = 0
    @Published var FilterSeniortyLevelName                    :String? = ""

    @Published var FilterSubSpecialistId                     :[Int] = []
    @Published var FilterSubSpecialistName                     :[String] = []

    @Published var isFiltering = false

    //------- output
    @Published var noDoctors = false
    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
    init() {
        ModelFetchDoctors.sink { (completion) in
        } receiveValue: { [weak self]  (modeldata) in
            self?.noDoctors = false
            switch self?.searchDocOperation {
            case .fetchDoctors:
                self?.publishedModelSearchDoc = modeldata.data?.Items ?? []
                if self?.publishedModelSearchDoc == [] {
                    self?.noDoctors = true
                }

            case .fetchMoreDoctors:
                if modeldata.data?.Items?.count ?? 0 > 3{
                    self?.publishedModelSearchDoc.append( contentsOf: modeldata.data?.Items ?? [])
                }
                if self?.publishedModelSearchDoc == [] || self?.publishedModelSearchDoc.isEmpty == true {
                    self?.noDoctors = true
                }
 
            case .none:
                break
            }
        }.store(in: &cancellables)
        
    }
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
        return .Post
    }
    
    var parameter: parameterType{
        var Parameters : [String:Any] = [
            // required
            "MaxResultCount": MaxResultCount,
            "SkipCount":SkipCount,
            "SpecialistId":FilterSpecialistId == 0 ? SpecialistId:FilterSpecialistId ,
            "MedicalExaminationTypeId":MedicalExaminationTypeId
        ]
        // optional
        if DoctorName != ""{
            Parameters["DoctorName"] = DoctorName
        }
        
//        if isFiltering{
        if FilterCityId != 0{
            Parameters["CityId"] = FilterCityId
//        }
        }
//        else if CityId != 0{
//            Parameters["CityId"] = CityId
//        }
        
//        if isFiltering{
        if FilterAreaId != 0{
            Parameters["AreaId"] = FilterAreaId
//        }
        }
//        else if AreaId != 0{
//            Parameters["AreaId"] = AreaId
//        }
        
        if FilterMinFees != ""{
            Parameters["FeesFrom"] = Int(FilterMinFees)
        }
        if FilterMaxFees != ""{
            Parameters["FeesTo"] = Int(FilterMaxFees)
        }
//        else if Fees != 0{
//            Parameters["Fees"] = Fees
//        }
        
        if FilterGenderId != 0{
            Parameters["GenderId"] = FilterGenderId
        }
//        else if GenderId != 0{
//            Parameters["GenderId"] = GenderId
//        }
        
        if FilterSeniortyLevelId != 0{
            Parameters["SeniortyLevelId"] = FilterSeniortyLevelId
        }
//        else if SeniortyLevelId != 0{
//            Parameters["SeniortyLevelId"] = SeniortyLevelId
//        }
        
//        if isFiltering{
        if FilterSubSpecialistId != []{
            Parameters["SubSpecialistId"] = FilterSubSpecialistId
//        }
        }
//        else if SubSpecialistId != []{
//            Parameters["SubSpecialistId"] = SubSpecialistId
//        }
        return .parameterRequest(Parameters: Parameters, Encoding: JSONEncoding.default)
    }
    
    var header: [String : String]? {
        return ["Authorization":Helper.getAccessToken()]
    }
    
    func FetchDoctors(operation:searchDocType){
        searchDocOperation = operation
        if Helper.isConnectedToNetwork(){
            print(parameter)
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
            message = "Check_Your_Internet_Connection".localized(language)
            isAlert = true
        }
    }
    
}
