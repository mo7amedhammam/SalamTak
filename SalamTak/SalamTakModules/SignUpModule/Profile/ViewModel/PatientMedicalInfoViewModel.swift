//
//  PatientMedicalInfoViewModel.swift
//  SalamTak
//
//  Created by wecancity on 29/12/2022.
//

import Foundation
import Combine
import Alamofire
import SwiftUI

enum PatientInfoMedicalOp{
    case GetPatientMedicalInfo, CreatePatientMedicalInfo, UpdatePatientMedicalInfo
}


class PatientMedicalInfoViewModel: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<PatientMedicalInfoModel>, Error>()
    private var cancellables: Set<AnyCancellable> = []
  
    @Published var PatientMedicalOP : PatientInfoMedicalOp = .GetPatientMedicalInfo
    
    @Published  var PatientId: Int = 0
    @Published  var Height: String = ""
    @Published  var Weight: String = ""
    @Published  var Pressure: String = ""              // 1 for male  2 for female
    @Published  var SugarLevel: String = ""              //  date format "yyyy/mm/dd"
    @Published  var isnormalPressure = false
    @Published  var normalPressure = "120"
    @Published  var isnormalSugar = false
    @Published  var normalSugar = "96"
    
    @Published  var OtherAllergies : String = ""
    @Published  var BloodTypeId: Int = 0
    @Published  var BloodTypeName: String = ""
    @Published  var Prescriptions : String = ""
    
    @Published  var CurrentMedication : String = ""
    @Published  var PastMedication : String = ""
    @Published  var ChronicDiseases : String = ""
    @Published  var Iinjuries : String = ""
    @Published  var Surgeries : String = ""
    
    @Published  var PatientFoodAllergiesName     : [String] = []
    @Published  var PatientFoodAllergiesDto     : [Int] = []
    @Published  var PatientMedicineAllergiesName     : [String] = []
    @Published  var PatientMedicineAllergiesDto     : [Int] = []

    @Published  var NationalityName: String = "Nationality"
    @Published  var cityName             : String = ""
    @Published  var areaName             : String = ""
    @Published  var occupationName       : String = "Occupation"
  
    //------- validation
    @Published  var errorFirstName : String = ""
    @Published  var errorFirstNameAr: String = ""
    @Published  var errorMiddelName: String = ""
    @Published  var errorMiddelNameAr: String = ""
    @Published  var errorLastName: String = ""
    @Published  var errorLastNameAr: String = ""
    @Published  var errorNationalityId: Int = 0
    @Published  var errorGenderId: Int?               // 1 for male  2 for female
    @Published  var errorSpecialistId: Int = 0
    @Published  var errorBirthday: Date?              //  date format "yyyy/mm/dd"
    @Published  var errorSeniorityLevelId: Int = 0
    @Published  var errorWebsite : String = ""
    @Published  var errorDoctorInfo : String = ""
    @Published  var errorDoctorInfoAr : String = ""
    //------- output
    @Published var isValid = false
    @Published var inlineErrorPassword = ""
    @Published var publishedDoctorCreatedModel: PatientMedicalInfoModel? 
    @Published var UserCreated = false
    @Published var UserUpdated = false
    @Published var formIsValid:Bool = false

    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
    init() {
        checkvalidations()
//        execute(Operation: .GetPatientMedicalInfo)
        
        passthroughModelSubject.sink { (completion) in
            //            print(completion)
        } receiveValue: {[weak self] (modeldata) in
//            self.publishedDoctorCreatedModel = modeldata.data
            if self?.PatientMedicalOP == .CreatePatientMedicalInfo && modeldata.success ?? false{
                self?.UserCreated = true
                Helper.userLogedIn(value: true)
            }
            self?.PatientId = modeldata.data?.id ?? 0
            self?.Height =  (modeldata.data?.height ?? 0) > 0 ? String(modeldata.data?.height ?? 0):""
            self?.Weight = (modeldata.data?.weight ?? 0) > 0 ? String(modeldata.data?.weight ?? 0):""
            self?.Pressure = modeldata.data?.pressure ?? ""
            if modeldata.data?.pressure ?? "" == self?.normalPressure {
                self?.isnormalPressure = true
            }
            if modeldata.data?.sugarLevel ?? "" == self?.normalSugar {
                self?.isnormalSugar = true
            }
            self?.SugarLevel = modeldata.data?.sugarLevel ?? ""
            self?.BloodTypeId = modeldata.data?.bloodTypeID ?? 0
            self?.BloodTypeName = modeldata.data?.bloodName ?? ""
            self?.PatientMedicineAllergiesDto = modeldata.data?.patientMedicineAllergiesDto ?? []
            self?.PatientMedicineAllergiesName = modeldata.data?.patientMedicineAllergiesName ?? []
            self?.PatientFoodAllergiesDto = modeldata.data?.patientFoodAllergiesDto ?? []
            self?.PatientFoodAllergiesName = modeldata.data?.patientFoodAllergiesName ?? []
            self?.OtherAllergies = modeldata.data?.otherAllergies ?? ""
            self?.Iinjuries = modeldata.data?.iinjuries ?? ""
            self?.Prescriptions = modeldata.data?.prescriptions ?? ""
            self?.CurrentMedication = modeldata.data?.currentMedication ?? ""
            self?.PastMedication = modeldata.data?.pastMedication ?? ""
            self?.Iinjuries = modeldata.data?.iinjuries ?? ""
            self?.ChronicDiseases = modeldata.data?.chronicDiseases ?? ""
            self?.Surgeries = modeldata.data?.surgeries ?? ""
        }.store(in: &cancellables)
    }
}
 

extension PatientMedicalInfoViewModel:TargetType{
    var url: String {
        switch PatientMedicalOP{
    case .GetPatientMedicalInfo:
            return URLs().PatientGetMedicalInfo
    case .CreatePatientMedicalInfo:
            return URLs().PatientCreateMedicalInfo
    case .UpdatePatientMedicalInfo:
            return URLs().PatientUpdateMedicalInfo
        }
    }
    
    var method: httpMethod {
        switch PatientMedicalOP{
        case .GetPatientMedicalInfo:
            return .Get
        case .CreatePatientMedicalInfo, .UpdatePatientMedicalInfo:
            return .Post
        }
    }
    
    var parameter: parameterType {
        
        switch PatientMedicalOP{
        case .GetPatientMedicalInfo:
            return .plainRequest
        case .CreatePatientMedicalInfo, .UpdatePatientMedicalInfo:
            var parametersarr : [String : Any]  = ["Height" : Int(Height ) ?? 0, "Weight" : Int(Weight ) ?? 0
                                               ,
                          "Pressure" : Pressure, "SugarLevel" : SugarLevel,
                          "BloodTypeId" : BloodTypeId, "OtherAllergies" : OtherAllergies,
                          "Prescriptions" : Prescriptions, "CurrentMedication" : CurrentMedication,
                           "PastMedication" : PastMedication, "ChronicDiseases" : ChronicDiseases,
                           "Iinjuries": Iinjuries, "Surgeries" : Surgeries,
                            "PatientFoodAllergiesDto": PatientFoodAllergiesDto,
                            "PatientMedicineAllergiesDto" : PatientMedicineAllergiesDto,
                            ]
        if PatientId != 0 {
            PatientMedicalOP = .UpdatePatientMedicalInfo
            parametersarr["Id"] = PatientId
        }
        return .parameterRequest(Parameters: parametersarr, Encoding: JSONEncoding.default)
        }
    }
    
    var header: [String : String]? {
        let header = ["Authorization":Helper.getAccessToken()]
        return header
    }
    
    func execute(Operation:PatientInfoMedicalOp){
        UserCreated = false
        UserUpdated = false
        
        self.PatientMedicalOP = Operation
        switch Operation{
    case .GetPatientMedicalInfo:
            GetMedicalProfile()
    case .CreatePatientMedicalInfo:
            CreateMedicalProfile()
        case .UpdatePatientMedicalInfo:
            CreateMedicalProfile()
        }
    }

    func GetMedicalProfile(){
        if Helper.isConnectedToNetwork(){
            print(url)
            self.isLoading = true
            BaseNetwork.request(Target: self, responseModel: BaseResponse<PatientMedicalInfoModel>.self) { [self] (success, model, err) in
                if success{
                    //case of success
//                    DispatchQueue.main.async {
                        self.passthroughModelSubject.send( model!  )
                    print(model!)
//                    }
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
    
    func CreateMedicalProfile(){
        print(parameter)
        if Helper.isConnectedToNetwork(){
            self.isLoading = true
            BaseNetwork.request(Target: self, responseModel: BaseResponse<PatientMedicalInfoModel>.self) { [self] (success, model, err) in
                if success{
                    //case of success
//                    DispatchQueue.main.async {
                        self.passthroughModelSubject.send( model!  )
                  if PatientMedicalOP == .UpdatePatientMedicalInfo {
                    message = model?.message ?? "success"
                    isAlert = true
                    }
//                    }
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



// MARK: - Setup validations
extension PatientMedicalInfoViewModel{
    var validweight: AnyPublisher<Bool, Never> {
       $Weight
         .map { weight in
             guard String(weight ).count > 0 else {
                 return false
             }
                 return true
         }
         .eraseToAnyPublisher()
     }
    
    var validheight: AnyPublisher<Bool, Never> {
       $Height
         .map { Height in
             guard String(Height ).count > 0 else {
                 return false
             }
             return true
         }
         .eraseToAnyPublisher()
     }
    
    var validpresure: AnyPublisher<Bool, Never> {
       $Pressure
         .map { presure in
             guard "\(presure)".count > 0 else {
                 return false
             }
             return true
         }
         .eraseToAnyPublisher()
     }
    var validsuger: AnyPublisher<Bool, Never> {
       $SugarLevel
         .map { suger in
             guard "\(suger)".count > 0 else {
                 return false
             }
             return true
         }
         .eraseToAnyPublisher()
     }
    var validP1:AnyPublisher<Bool,Never>{
        Publishers.CombineLatest4(validheight,validweight,validpresure,validsuger)
            .map{ height, Weight, Pressure, suger in
                return height && Weight && Pressure && suger
            }
            .eraseToAnyPublisher()
    }
    
    var validBlood: AnyPublisher<Bool, Never> {
       $BloodTypeName
         .map { suger in
             guard "\(suger)".count > 0 else {
                 return false
             }
             return true
         }
         .eraseToAnyPublisher()
     }

    
    var isvalidMedicalInfoForm: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest (
        validP1,
        validBlood)
        .map { validP1, validBlood in
            return validP1 && validBlood
        }
        .eraseToAnyPublisher()
    }
    
    func checkvalidations(){
        isvalidMedicalInfoForm
          .receive(on: RunLoop.main)
          .assign(to: \.formIsValid, on: self)
          .store(in: &cancellables)
    }
   
    
}
