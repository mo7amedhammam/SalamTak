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
    @Published  var DoctorName: String = ""              // 1 for male  2 for female
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
    @Published var publishedDoctorCreatedModel: [AppointmentInfo] = []
    @Published var isLoading:Bool? = false
    @Published var isError = false
    @Published var errorMsg = ""
    @Published var UserCreated = false
    @Published var isNetworkError = false
    @Published var noschedules = false

    
    init() {
        

        
        passthroughModelGetSubject.sink { (completion) in
            //            print(completion)
        } receiveValue: { [self] (modeldata) in
            noschedules = false
            self.publishedDoctorCreatedModel = modeldata.data ?? []
            self.DoctorName = publishedDoctorCreatedModel.first?.doctorName ?? ""
            if publishedDoctorCreatedModel.count == 0 || publishedDoctorCreatedModel == [] {
                noschedules = true
            }
        }.store(in: &cancellables)
        
 
        
    }
    
    func startFetchAppointmentInfo(medicalTypeId:Int) {

        if Helper.isConnectedToNetwork(){
            self.isLoading = true

            ScheduleApiService.GetPatientAppointmentInfo(medicalExaminationTypeId:medicalTypeId,
                completion:  { (success, model, err) in
            if success{
                DispatchQueue.main.async {
                    self.UserCreated = true
                    self.isLoading = false
                    self.passthroughModelGetSubject.send(model!)
                    print(model!)
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
