//
//  ViewModelPersonalData.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 31/03/2022.
//

import Foundation
import Combine
import Alamofire

class ViewModelGetAppointmentInfo: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelGetSubject = PassthroughSubject<ModelGetSchedule, Error>()
    let passthroughModelSubject = PassthroughSubject<ModelGetSchedule, Error>()
    
    private var cancellables: Set<AnyCancellable> = []
    
    
    
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
    
//    @Published  var SpecialityName: String = "CompeleteProfile_Screen_Speciality"
//    @Published  var SubSpecialityName: [String] = []
//    @Published  var SeniorityName: String = "CompeleteProfile_Screen_Seniority"

    
    
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
    @Published var publishedDoctorCreatedModel: ModelGetSchedule? = nil
    @Published var isLoading:Bool? = false
    @Published var isError = false
    @Published var errorMsg = ""
    @Published var UserCreated = false
    @Published var isNetworkError = false
    
    
    init() {
//     validations()
        //-----------------------------------------------------------------
        
        passthroughModelSubject.sink { (completion) in
            //            print(completion)
        } receiveValue: { (modeldata) in
            self.publishedDoctorCreatedModel = modeldata

        }.store(in: &cancellables)
        
        passthroughModelGetSubject.sink { (completion) in
            //            print(completion)
        } receiveValue: { [self] (modeldata) in
            self.publishedDoctorCreatedModel = modeldata
//            self.Height = publishedDoctorCreatedModel?.data?.height ?? 0
//            self.Weight = publishedDoctorCreatedModel?.data?.weight ?? 0
//            self.Pressure = publishedDoctorCreatedModel?.data?.pressure ?? ""
//            self.SugarLevel = publishedDoctorCreatedModel?.data?.sugarLevel ?? ""
//            self.PatientFoodAllergiesDto = publishedDoctorCreatedModel?.data?.PatientFoodAllergiesDto ?? []
//            self.PatientMedicineAllergiesDto = publishedDoctorCreatedModel?.data?.PatientMedicineAllergiesDto ?? []
//            self.PatientFoodAllergiesName = publishedDoctorCreatedModel?.data?.PatientFoodAllergiesName ?? []
//            self.PatientMedicineAllergiesName = publishedDoctorCreatedModel?.data?.PatientMedicineAllergiesName ?? []
//            self.BloodTypeName = publishedDoctorCreatedModel?.data?.bloodName ?? "Blood Group"
//            self.OtherAllergies = publishedDoctorCreatedModel?.data?.otherAllergyies ?? ""
//            self.Prescriptions = publishedDoctorCreatedModel?.data?.prescriptions ?? ""
//            self.CurrentMedication = publishedDoctorCreatedModel?.data?.currentMedication ?? ""
//            self.PastMedication = publishedDoctorCreatedModel?.data?.pastMedication ?? ""
//            self.ChronicDiseases = publishedDoctorCreatedModel?.data?.chronicDiseases ?? ""
//            self.Iinjuries = publishedDoctorCreatedModel?.data?.injuires ?? ""
//            self.Surgeries = publishedDoctorCreatedModel?.data?.surgries ?? ""
//            self.Id = publishedDoctorCreatedModel?.data?.id ?? 0
        }.store(in: &cancellables)
        
        //-----------------------------------------------------------------
        //        passthroughSubject
        //            .dropFirst(2)
        //            .filter({ (value) -> Bool in
        //                value != "5"
        //            })
        //            .map { value in
        //                return value + " seconds"
        //            }
        //            .sink { (completion) in
        //                switch completion {
        //                case .finished:
        //                    self.time = "Finished"
        //                case .failure(let err):
        //                    self.time = err.localizedDescription
        //                }
        //            } receiveValue: { (value) in
        //                self.time = value
        //            }
        //            .store(in: &cancellables)
        //
        //-------------------------------------------------------
        
    }
    
    
    

    
//    func startUpdateMedicalProfile( ) {
//
//
//
//        let parametersarr : [String : Any]  = ["Height" : Height ,"Weight" : Weight,
//                          "Pressure" : Pressure ,"SugarLevel" : SugarLevel,
//                          "BloodTypeId" : BloodTypeId
//                                               ,"OtherAllergies" : OtherAllergies,
//                          "Prescriptions" : Prescriptions ,
//                           "CurrentMedication" : CurrentMedication ,
//                           "PastMedication" : PastMedication, "ChronicDiseases" : ChronicDiseases,
//                           "Iinjuries": Iinjuries, "Surgeries" : Surgeries,
//                            "PatientFoodAllergiesDto": PatientFoodAllergiesDto, "PatientMedicineAllergiesDto" : PatientMedicineAllergiesDto,
//                                               "Id" : Id
//
//                          ]
//
//        if Helper.isConnectedToNetwork(){
////        if isValid == true {
//
//            UpdateMedicalStateApiService.UpdatePatientMedicalState(passedparameters: parametersarr, completion: {(success, model, err) in
//                print("data")
//                print(parametersarr)
//                self.isLoading = true
//            if success{
//                DispatchQueue.main.async {
//                    self.UserCreated = true
//                    self.isLoading = false
//                    self.passthroughModelSubject.send(model!)
//                    print(model?.message)
//                }
//            }else{
//                print(model?.message)
//                self.isLoading = false
//                self.isError = true
//                self.errorMsg = model?.message ?? "Please Compelete Your Data"
//            }
////print(err ?? "")
//        })
//            self.isLoading = false
//
////        }else{
////            print("not validated")
////        }
//        }else{
//                   // Alert with no internet connection
//            self.isLoading = false
//          isNetworkError = true
//               }
//    }
 
    func startFetchAppointmentInfo() {

        if Helper.isConnectedToNetwork(){
            ScheduleApiService.GetPatientAppointmentInfo(medicalExaminationTypeId:Id,
                completion:  { (success, model, err) in
                
            
                self.isLoading = true
            if success{
                DispatchQueue.main.async {
                    self.UserCreated = true
                    self.isLoading = false
                    self.passthroughModelGetSubject.send(model!)
//                    print(model!)
                }
            }else{
                self.isLoading = false
                self.isError = true
                print(model?.message ?? "")
                self.errorMsg = err ?? ""
            }
        })

        }else{
                   // Alert with no internet connection
            self.isLoading = false
          isNetworkError = true
               }
    }
    
}
