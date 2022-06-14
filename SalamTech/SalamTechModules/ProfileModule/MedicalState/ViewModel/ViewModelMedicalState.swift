//
//  ViewModelPersonalData.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 31/03/2022.
//

import Foundation
import Combine
import Alamofire

class ViewModelCreateMedicalProfile: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<MedicalInfo>, Error>()
    private var cancellables: Set<AnyCancellable> = []
  
    @Published  var Height: Int = 0
    @Published  var Weight: Int = 0
    @Published  var Pressure: String = ""              // 1 for male  2 for female
    @Published  var SugarLevel: String = ""              //  date format "yyyy/mm/dd"
    @Published  var OtherAllergies : String = ""
    @Published  var BloodTypeId: Int = 0
    @Published  var BloodTypeName: String = "Blood Group"
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
    @Published var publishedDoctorCreatedModel: MedicalInfo? = nil
    @Published var UserCreated = false
    
    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
    init() {
        //-----------------------------------------------------------------
        passthroughModelSubject.sink { (completion) in
            //            print(completion)
        } receiveValue: {[self] (modeldata) in
            self.publishedDoctorCreatedModel = modeldata.data
            if publishedDoctorCreatedModel != nil{
                UserCreated = true
                
            }

        }.store(in: &cancellables)
            
    }

    
}
 

extension ViewModelCreateMedicalProfile:TargetType{
    var url: String {
        return URLs().PatientCreateMedicalInfo
    }
    
    var method: httpMethod {
        return .Post
    }
    
    var parameter: parameterType {
        let parametersarr : [String : Any]  = ["Height" : Height, "Weight" : Weight,
                          "Pressure" : Pressure, "SugarLevel" : SugarLevel,
                          "BloodTypeId" : BloodTypeId, "OtherAllergies" : OtherAllergies,
                          "Prescriptions" : Prescriptions, "CurrentMedication" : CurrentMedication,
                           "PastMedication" : PastMedication, "ChronicDiseases" : ChronicDiseases,
                           "Iinjuries": Iinjuries, "Surgeries" : Surgeries,
                            "PatientFoodAllergiesDto": PatientFoodAllergiesDto,
                            "PatientMedicineAllergiesDto" : PatientMedicineAllergiesDto,
                            ]
        return .parameterRequest(Parameters: parametersarr, Encoding: JSONEncoding.default)
    }
    
    var header: [String : String]? {
        let header = ["Authorization":Helper.getAccessToken()]
        return header
    }
    
    func startCreateMedicalProfile(){
        print(parameter)
        if Helper.isConnectedToNetwork(){
            self.isLoading = true
            BaseNetwork.request(Target: self, responseModel: BaseResponse<MedicalInfo>.self) { [self] (success, model, err) in
                if success{
                    //case of success
                    DispatchQueue.main.async {
                        self.passthroughModelSubject.send( model!  )
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
