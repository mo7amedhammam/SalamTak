//
//  ViewModelPersonalData.swift
//  SalamTech
//
//  Created by Mohamed Hammam on 31/03/2022.
//

import Foundation
import Combine
import Alamofire

class ViewModelUpdateMedicalProfile: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<MedicalState>, Error>()
    
    private var cancellables: Set<AnyCancellable> = []
 
    @Published var updateMedicalInfoOperation : UpdateMedicalInfoOp = .getMedicalInfo
    
    @Published  var Id: Int = 0
    @Published  var Height: Int = 0
    @Published  var Weight: Int = 0
    @Published  var Pressure: String = ""              // 1 for male  2 for female
    @Published  var SugarLevel: String = ""              //  date format "yyyy/mm/dd"
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
    @Published var publishedDoctorCreatedModel: MedicalState? = nil
    @Published var UserCreated = false

    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    init() {
 
        passthroughModelSubject.sink { (completion) in
            //            print(completion)
        } receiveValue: { [self] (modeldata) in
            self.publishedDoctorCreatedModel = modeldata.data
            self.Height = publishedDoctorCreatedModel?.height ?? 0
            self.Weight = publishedDoctorCreatedModel?.weight ?? 0
            self.Pressure = publishedDoctorCreatedModel?.pressure ?? ""
            self.SugarLevel = publishedDoctorCreatedModel?.sugarLevel ?? ""
            self.PatientFoodAllergiesDto = publishedDoctorCreatedModel?.PatientFoodAllergiesDto ?? []
            self.PatientMedicineAllergiesDto = publishedDoctorCreatedModel?.PatientMedicineAllergiesDto ?? []
            self.PatientFoodAllergiesName = publishedDoctorCreatedModel?.PatientFoodAllergiesName ?? []
            self.PatientMedicineAllergiesName = publishedDoctorCreatedModel?.PatientMedicineAllergiesName ?? []
            self.BloodTypeName = publishedDoctorCreatedModel?.bloodName ?? "Blood Group"
            self.OtherAllergies = publishedDoctorCreatedModel?.otherAllergyies ?? ""
            self.Prescriptions = publishedDoctorCreatedModel?.prescriptions ?? ""
            self.CurrentMedication = publishedDoctorCreatedModel?.currentMedication ?? ""
            self.PastMedication = publishedDoctorCreatedModel?.pastMedication ?? ""
            self.ChronicDiseases = publishedDoctorCreatedModel?.chronicDiseases ?? ""
            self.Iinjuries = publishedDoctorCreatedModel?.injuires ?? ""
            self.Surgeries = publishedDoctorCreatedModel?.surgries ?? ""
            self.Id = publishedDoctorCreatedModel?.id ?? 0
        }.store(in: &cancellables)
        
    }

}

enum UpdateMedicalInfoOp{
    case getMedicalInfo, updateMedicalInfo
}

extension ViewModelUpdateMedicalProfile:TargetType{
    var url: String {
        switch updateMedicalInfoOperation{
        case .getMedicalInfo:
           return  URLs().PatientGetMedicalInfo
        case .updateMedicalInfo:
            return  URLs().PatientUpdateMedicalInfo
        }
    }
    
    var method: httpMethod {
        switch updateMedicalInfoOperation{
    case .getMedicalInfo:
            return .Get
    case .updateMedicalInfo:
            return .Post
    }
    }
    
    var parameter: parameterType {
        switch updateMedicalInfoOperation{
    case .getMedicalInfo:
            return .plainRequest
    case .updateMedicalInfo:
            let parametersarr : [String : Any]  = ["Height" : Height ,"Weight" : Weight,
                              "Pressure" : Pressure ,"SugarLevel" : SugarLevel,
                              "BloodTypeId" : BloodTypeId
                                                   ,"OtherAllergies" : OtherAllergies,
                              "Prescriptions" : Prescriptions ,
                               "CurrentMedication" : CurrentMedication ,
                               "PastMedication" : PastMedication, "ChronicDiseases" : ChronicDiseases,
                               "Iinjuries": Iinjuries, "Surgeries" : Surgeries,
                                "PatientFoodAllergiesDto": PatientFoodAllergiesDto, "PatientMedicineAllergiesDto" : PatientMedicineAllergiesDto,
                                                   "Id" : Id

                              ]
            return .parameterRequest(Parameters: parametersarr, Encoding: JSONEncoding.default)
    }
    }
    
    var header: [String : String]? {
        let header = ["Authorization":Helper.getAccessToken()]
        return header
    }
    
    
    func updateMedicalInfo(operation:UpdateMedicalInfoOp){
        updateMedicalInfoOperation = operation
        print(parameter)
        if Helper.isConnectedToNetwork(){
            self.isLoading = true
            BaseNetwork.request(Target: self, responseModel:BaseResponse<MedicalState>.self   ) { [self] (success, model, err) in
                if success{
                    //case of success
                    DispatchQueue.main.async {
                        self.passthroughModelSubject.send( model!  )
                        print(model!)
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
