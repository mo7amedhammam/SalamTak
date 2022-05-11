//
//  VMSearchDoc.swift
//  SalamTech
//
//  Created by wecancity on 05/04/2022.
//

import Foundation
import Combine
import Alamofire
import SwiftUI

class VMSearchDoc: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let ModelFetchDoctors = PassthroughSubject<ModelSearchDoc , Error>()
    let ModelFetchMoreDoctors = PassthroughSubject<ModelSearchDoc , Error>()
    let ModelFetchMinMaxFee = PassthroughSubject<ModelMinMaxFee , Error>()

    private var cancellables: Set<AnyCancellable> = []
    // ------- input

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
//    @Published var publishedModelSearchDoc: [Doc]
    
    @Published var publishedModelSearchDoc: [Doc] = [Doc.init( id: 7878787878787, FeesFrom: 78787878787, DoctorName: "", SubSpecialistName: [], MedicalExamationTypeImage: [])]
    
    @Published var publishedModelMinMaxFee : MinMaxFee?



    @Published var isLoading:Bool?
    @Published var isError = false
    @Published var errorMsg = ""
    @Published var isDone = false
    @Published var isNetworkError = false
    @Published var SessionExpired = false

    
    init() {
   GetMinMaxFees()
        
        ModelFetchDoctors.sink { (completion) in
            //            print(completion)
        } receiveValue: { [weak self]  (modeldata) in
            
            self?.publishedModelSearchDoc = modeldata.data?.Items ?? []
        
  
        }.store(in: &cancellables)
        
        ModelFetchMoreDoctors.sink { (completion) in
            //            print(completion)
        } receiveValue: { [weak self] (modeldata) in
            
            self?.publishedModelSearchDoc.append( contentsOf: modeldata.data?.Items ?? [])
  
        }.store(in: &cancellables)
    
        
        ModelFetchMinMaxFee.sink { (completion) in
            //            print(completion)
        } receiveValue: { (modeldata) in
            self.publishedModelMinMaxFee = modeldata.data ?? MinMaxFee.init(MinimumFees: 0, MaximumFees: 0)

        }.store(in: &cancellables)

//
//
//        ModelCreatedSchedual.sink { (completion) in
//            //            print(completion)
//        } receiveValue: { (modeldata) in
//            self.publishedCreatedSchedualModel = modeldata
//
//        }.store(in: &cancellables)

//
//        ModelSchedualByServiseDayId.sink { (completion) in
//            //            print(completion)
//        } receiveValue: { (modeldata) in
//            self.publishedUpdatedSchedualModel = modeldata
//
//        }.store(in: &cancellables)
//
        
        
        
    }
        
    
    func FetchDoctors() {
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
        
        
        if Helper.isConnectedToNetwork(){
            print(Parameters)

            APISearchDoc.SearchDoctors(parameters: Parameters,
        completion:  { (success, model, err) in
            
                self.isLoading = true
            if success{
                DispatchQueue.main.async {
                    self.ModelFetchDoctors.send(model!)
                    self.isLoading = false
                    self.isDone = true
                    print(model!)
                }
            }else{
                self.isLoading = false
                self.isError = true
                print(model?.message ?? "")
                self.errorMsg = err ?? "cannot get Doctors"
            }
        })
            self.isLoading = false

        }else{
                   // Alert with no internet connection
            self.isLoading = false
          isNetworkError = true
               }
    }
    
    func FetchMoreDoctors() {
        var Parameters : [String:Any] = [
        // required
            "MaxResultCount": MaxResultCount ,
            "SkipCount":SkipCount,
            "SpecialistId":SpecialistId ,
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
            Parameters["Fees"] =  FilterFees
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
        
        if Helper.isConnectedToNetwork(){
            print(Parameters)
            APISearchDoc.SearchDoctors(parameters: Parameters,
        completion:  { (success, model, err) in
            
                self.isLoading = true
            if success{
                DispatchQueue.main.async {
                    self.ModelFetchMoreDoctors.send(model!)
                    self.isLoading = false
                    self.isDone = true
                    print(model!)
                }
            }else{
                self.isLoading = false
                self.isError = true
                print(model?.message ?? "")
                self.errorMsg = err ?? "cannot get Doctors"
            }
        })
            self.isLoading = false

        }else{
                   // Alert with no internet connection
            self.isLoading = false
          isNetworkError = true
               }
    }

    
    func GetMinMaxFees(){

        if Helper.isConnectedToNetwork(){
            APIGetMinMaxFee.GetMinMaxFee(completion:  { (success, model, err) in
               self.isLoading = true
            if success{
                DispatchQueue.main.async {
                    self.ModelFetchMinMaxFee.send(model!)
                    self.isLoading = false
                    self.isDone = true
                    print(model!)
                }
            }else{
                self.isLoading = false
                self.isError = true
                print(model?.message ?? "")


                self.errorMsg = err ?? "cannot get serviseby day id "
            }
        })
            self.isLoading = false

        }else{
                   // Alert with no internet connection
            self.isLoading = false
          isNetworkError = true
               }
    }

//    func startCreatingSchedualByServDayId(){
//        self.isLoading = true
//
//        let parametersarr : [String : Any]  = ["DayId" : DayId ?? 0 ,"TimeFrom" :  timef.string(from: TimeFrom) , "TimeTo" :  timef.string(from: TimeTo),"Fees" : Int(Fees) ?? 0,
//                                               "DurationMedicalExaminationId" : DurationMedicalExaminationId ?? 0,"Inactive":Inactive ?? true,"MedicalExaminationTypeId":serviceId ?? 0]
//
//        print(parametersarr)
//                if Helper.isConnectedToNetwork(){
//                    GetDocSchedualByServIdApiServise.CreateServiceById(parameters: parametersarr,
//                                                          completion:{ (success, model, err) in
//            if success{
//                DispatchQueue.main.async {
//                    self.ModelCreatedSchedual.send(model!)
//                    self.isDone = true
//                    self.isLoading = false
////                    print(model!)
////                    print(model?.message ?? "") // overlap error
//                    self.errorMsg = model?.message ?? "cant create servise by id "
//                  //  self.startGettingSchedualsByDayId()
//                }
//            }else{
//                self.isLoading = false
////                print(model?.message ?? "")
//                self.errorMsg = model?.message ?? "model msg"
//                self.isError = true
//                print(self.errorMsg)
//            }
//
//
//                self.errorMsg = err ?? "overlap error by servise id"
//                self.isError = true
//                print(err ?? "")
//
////                self.errorMsg = model?.message ?? "overlap error default"
////                print(self.errorMsg) // overlap printed from case 400
////                print(err ?? "")
//
//
//        })
//        }else{
//                   // Alert with no internet connection
//            self.isLoading = false
//          isNetworkError = true
//               }
//    }
    
    
//    func startupdatingServises() {
//        self.isLoading = true
//
//        let parametersarr : [String : Any]  = [ "SchedualId" : updateSchedualId ?? 0,"DayId" : updateDayId ?? 0 ,"TimeFrom" :  timef.string(from: updateTimeFrom) , "TimeTo" :  timef.string(from: updateTimeTo),"Fees" : Double(updateFees) ?? 0,
//                                               "DurationMedicalExaminationId" : updateDurationMedicalExaminationId ?? 0,"Inactive":updateInactive ?? true,"ClinicId":ClinicId ?? 0]
//
////        print(parametersarr)
//                if Helper.isConnectedToNetwork(){
//            CreateClinicSchedualApiService.updateSchedual(parameters: parametersarr,
//                                                          completion:{ (success, model, err) in
//            if success{
//                DispatchQueue.main.async {
////                    self.passthroughModelSubject.send(model!)
////                    self.UserCreated = true
//                    self.isLoading = false
////                    print(model!)
////                    print(model?.message ?? "") // overlap error
//                    self.errorMsg = model?.message ?? "Profile image is empty"
//                    self.GetClinicSchedualserviceDayId()
//                    self.isError = true
//                }
//            }else{
//                self.isLoading = false
////                print(model?.message ?? "")
//                self.errorMsg =  model?.message ?? "error msg"
//                self.isError = true
//                print(self.errorMsg)
//            }
//                self.errorMsg = model?.message ?? "overlap error default"
//                self.isError = true
////                print(err ?? "")
//
////                self.errorMsg = model?.message ?? "overlap error default"
////                print(self.errorMsg) // overlap printed from case 400
////                print(err ?? "")
//
//
//        })
//        }else{
//                   // Alert with no internet connection
//            self.isLoading = false
//          isNetworkError = true
//               }
//    }
  
    
}
