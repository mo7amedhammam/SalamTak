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
    let ModelSchedualByServiseId = PassthroughSubject<ModelSearchDoc , Error>()
//    let ModelSchedualByServiseDayId = PassthroughSubject<ModelGetSchedualByServiseDayId, Error>()
//    let ModelCreatedSchedual = PassthroughSubject<ModelCreateServiceById, Error>()
//    let ModelUpdatedSchedual = PassthroughSubject<ModelUpdatedClinicSchedual, Error>()
    
    private var cancellables: Set<AnyCancellable> = []
    

   
    // ------- input

    @Published var MaxResultCount                            :Int?
    @Published var SkipCount                               :Int?
    @Published var DoctorName                           :String?
    @Published var SpecialistId                               :Int?
    @Published var CityId                               :Int?
    @Published var AreaId                               :Int?
    @Published var GenderId                               :Int?
    @Published var Fees                                     :String = ""
    @Published var SeniortyLevelId                               :Int?
    @Published var SubSpecialistId                               :[Int]?
    @Published var MedicalExaminationTypeId                     :Int?

    
    //update period
//        @Published var updateSchedualId:Int?
//        @Published var updateDayId:Int?
//        @Published var updateTimeFrom:Date = Date()                           // "05:30"
//        @Published var updateTimeTo:Date = Date()                             // "08:30"
//        @Published var updateFees:String = ""
//        @Published var updateDurationMedicalExaminationId:Int?
//        @Published var updateDurationMedicalExaminationValue:Int?
//        @Published var updateInactive:Bool?

    //------- output
    @Published var isValid = false
    @Published var inlineErrorPassword = ""
    @Published var publishedModelSearchDoc: [Doc]?
//    @Published var publishedModelSchedualByServiseDayId: [SchedualByServiseDayId] = []
//    @Published var publishedCreatedSchedualModel: ModelCreateServiceById?
//    @Published var publishedUpdatedSchedualModel: ModelUpdatedClinicSchedual?


    @Published var isLoading:Bool?
    @Published var isError = false
    @Published var errorMsg = ""
    @Published var isDone = false
    @Published var isNetworkError = false
    @Published var SessionExpired = false

    
    init() {
   
        ModelSchedualByServiseId.sink { (completion) in
            //            print(completion)
        } receiveValue: { [self] (modeldata) in
            
            self.publishedModelSearchDoc = modeldata.data?.Items ?? []
        
  
        }.store(in: &cancellables)
    
        
//        ModelSchedualByServiseDayId.sink { (completion) in
//            //            print(completion)
//        } receiveValue: { (modeldata) in
//            self.publishedModelSchedualByServiseDayId = modeldata.data ?? []
//
//        }.store(in: &cancellables)
//
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
            "MaxResultCount": 10,
            "SkipCount":0,
            "SpecialistId":2,
            "MedicalExaminationTypeId":2
    ]
        if DoctorName != ""{
            Parameters["DoctorName"] = DoctorName
        }
        if CityId != 0{
            Parameters["CityId"] = CityId
        }
        if AreaId != 0{
            Parameters["AreaId"] = AreaId
        }
        if Fees != ""{
            Parameters["Fees"] = Double( Fees )
        }
        if GenderId != 0{
            Parameters["GenderId"] = GenderId
        }
        if SeniortyLevelId != 0{
            Parameters["SeniortyLevelId"] = SeniortyLevelId
        }
        if SubSpecialistId != []{
            Parameters["SubSpecialistId"] = SubSpecialistId
        }
        
        
        if Helper.isConnectedToNetwork(){
            APISearchDoc.SearchDoctors(parameters: Parameters,
        completion:  { (success, model, err) in
            
                self.isLoading = true
            if success{
                DispatchQueue.main.async {
                    self.ModelSchedualByServiseId.send(model!)
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
    
//    func GetClinicSchedualserviceDayId() {
//
//        if Helper.isConnectedToNetwork(){
//            GetDocSchedualByServIdApiServise.GetDocSchedualByServDayId(serviceId: serviceId ?? 0,DayId: DayId ?? 0,
//        completion:  { (success, model, err) in
//               self.isLoading = true
//            if success{
//                DispatchQueue.main.async {
//                    self.ModelSchedualByServiseDayId.send(model!)
//                    self.isLoading = false
//                    self.isDone = true
//                    print(model!)
//                }
//            }else{
//                self.isLoading = false
//                self.isError = true
//                print(model?.message ?? "")
//
//
//                self.errorMsg = err ?? "cannot get serviseby day id "
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
