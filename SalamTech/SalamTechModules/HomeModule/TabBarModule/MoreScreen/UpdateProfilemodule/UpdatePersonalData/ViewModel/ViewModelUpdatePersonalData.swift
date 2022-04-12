//
//  ViewModelPersonalData.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 31/03/2022.
//

import Foundation
import Combine
import Alamofire

class ViewModelUpdatePatientProfile: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<ModelUpdatePatientProfile, Error>()
    let passthroughModelGetSubject = PassthroughSubject<ModelUpdatePatientProfile, Error>()
    private var cancellables: Set<AnyCancellable> = []
    
    // ------- input
    @Published  var FirstName : String = ""{
        didSet{
            if self.FirstName.isEmpty{
                self.errorFirstName = "*"
            } else {
                self.errorFirstName = ""
            }
        }
    }
    @Published  var FirstNameAr: String = "" {
        didSet{
            if self.FirstNameAr.isEmpty{
                self.errorFirstNameAr = "*"
            } else {
                self.errorFirstNameAr = ""
            }
        }
    }
    @Published  var MiddelName: String = ""{
        didSet{
            if self.MiddelName.isEmpty{
                self.errorMiddelName = "*"
            } else {
                self.errorMiddelName = ""
            }
        }
    }
    @Published  var MiddelNameAr: String = "" {
        didSet{
            if self.MiddelNameAr.isEmpty{
                self.errorMiddelNameAr = "*"
            } else {
                self.errorMiddelNameAr = ""
            }
        }
    }
    @Published  var FamilyName: String = "" {
        didSet{
            if self.FamilyName.isEmpty{
                self.errorLastName = "*"
            } else {
                self.errorLastName = ""
            }
        }
    }
    @Published  var FamilyNameAr: String = "" {
        didSet{
            if self.FamilyNameAr.isEmpty{
                self.errorLastNameAr = "*"
            } else {
                self.errorLastNameAr = ""
            }
        }
    }
    @Published  var NationalityId: Int = 0
    @Published  var CountryId: Int = 0
    @Published  var GenderId: Int?               // 1 for male  2 for female
    @Published  var Id: Int?
    @Published  var PatientId: Int?
    @Published  var Birthday:String = ""            //  date format "yyyy/mm/dd"
    @Published  var EmergencyContact : String = ""
    @Published  var OccupationId: Int = 0
    @Published  var CityId: Int = 0
    @Published  var AreaId: Int = 0
    @Published  var Address : String = ""
    @Published  var Latitude  = 0.0
    @Published  var Longitude = 0.0
    @Published  var FloorNo: Int = 0
    @Published  var BlockNo : String = ""
    @Published  var ApartmentNo : String = ""
    @Published var date: Date?
//    @Published  var DoctorSubSpecialist : [Int] = []
    @Published  var profileImage = UIImage()
    
    @Published  var NationalityName: String = ""
    @Published  var cityName             : String = ""
    @Published  var areaName             : String = ""
    @Published  var occupationName       : String = "Occupation"
    @Published var ImageUrl :String = ""
    
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
    @Published var publishedDoctorCreatedModel: ModelUpdatePatientProfile? = nil
    @Published var publishedPatientGetModel: ModelUpdatePatientProfile? = nil
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
        
        self.date = DateFormatter.formate.date(from: Birthday) ?? Date()
        passthroughModelGetSubject.sink { (completion) in
            //            print(completion)
        } receiveValue: { [self] (modeldata) in
            self.publishedPatientGetModel = modeldata
            self.FirstName = publishedPatientGetModel?.data?.firstName ?? ""
            self.FirstNameAr = publishedPatientGetModel?.data?.firstNameAr ?? ""
            self.MiddelName = publishedPatientGetModel?.data?.middleName ?? ""
            self.MiddelNameAr = publishedPatientGetModel?.data?.middleNameAr ?? ""
            self.FamilyName = publishedPatientGetModel?.data?.familyName ?? ""
            self.FamilyNameAr = publishedPatientGetModel?.data?.familyNameAr ?? ""
            self.EmergencyContact = publishedPatientGetModel?.data?.emergencyContact ?? ""
            self.GenderId = publishedPatientGetModel?.data?.genderId ?? 0
            self.NationalityId = publishedPatientGetModel?.data?.nationalityId ?? 0
            self.CityId = publishedPatientGetModel?.data?.cityId ?? 0
            self.AreaId = publishedPatientGetModel?.data?.areaId ?? 0
            self.CountryId = publishedPatientGetModel?.data?.nationalityId ?? 0
            self.OccupationId = publishedPatientGetModel?.data?.occupationId ?? 0
            self.ImageUrl = publishedPatientGetModel?.data?.image ?? ""
            self.Birthday = publishedPatientGetModel?.data?.birthdate ?? ""
            self.date = DateFormatter.formate.date(from: Birthday) ?? Date()
            self.Id = publishedPatientGetModel?.data?.id
            self.Address = publishedPatientGetModel?.data?.address ?? ""
            self.NationalityName = publishedPatientGetModel?.data?.nationalityName ?? "Nationality"
            self.cityName = publishedPatientGetModel?.data?.cityName ?? "City"
            self.areaName = publishedPatientGetModel?.data?.areaName ?? "Area"
            
            //self.PatientId = publishedPatientGetModel?.data.
//            self.Birthday = publishedPatientGetModel?.data?.birthdate ?? Date()

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
    

    
    func startUpdatePatientProfile() {

        
        let parametersarr : [String : Any]  = ["FirstName" : FirstName ,"FirstNameAr" : FirstNameAr,
                          "MiddelName" : MiddelName ,"MiddelNameAr" : MiddelNameAr,
                          "FamilyName" : FamilyName ,"FamilyNameAr" : FamilyNameAr,
                          "GenderId" : GenderId ?? 1 ,
                           "Birthdate" :  Fulldatef1.string(from: self.date ?? Date()) ,
                           "NationalityId" : NationalityId, "CountryId" : NationalityId,
                           "EmergencyContact": EmergencyContact, "OccupationId" : OccupationId,
                                               "CityId": CityId, "AreaId" : AreaId,"Address": Address,
                                               "Latitude": String(Latitude), "Longitude": String(Longitude),
                                               "BlockNo": BlockNo, "FloorNo": FloorNo, "ApartmentNo": ApartmentNo, "Id":Id ?? 0
                            
                                               
                          ]
        
        if Helper.isConnectedToNetwork(){
//        if isValid == true {
            
            UpdatePersonalApiService.UpdatePatientProfile(passedparameters : parametersarr , completion: { (success, model, err) in
                print(parametersarr)
                self.isLoading = true
            if success{
                DispatchQueue.main.async {
                    self.UserCreated = true
                    self.isLoading = false
                    self.passthroughModelSubject.send(model!)
                }
            }else{
                self.isLoading = false
                self.isError = true
                self.errorMsg = err ?? "You Must Compelete Your Data"
            }
//print(err ?? "")
        })
            self.isLoading = false

//        }else{
//            print("not validated")
//        }
        }else{
                   // Alert with no internet connection
            self.isLoading = false
          isNetworkError = true
               }
    }
    
    func startFetchPatientProfile() {

        if Helper.isConnectedToNetwork(){
            UpdatePersonalApiService.GetPatientProfile(
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
