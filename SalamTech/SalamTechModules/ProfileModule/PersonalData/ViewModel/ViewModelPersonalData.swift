//
//  ViewModelPersonalData.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 31/03/2022.
//

import Foundation
import Combine
import Alamofire

class ViewModelCreatePatientProfile: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<ModelCreatePatientProfile, Error>()
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
    @Published  var Birthday: Date?              //  date format "yyyy/mm/dd"
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
   
//    @Published  var DoctorSubSpecialist : [Int] = []
    @Published  var profileImage = UIImage()
    
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
    @Published var publishedDoctorCreatedModel: ModelCreatePatientProfile? = nil
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
    

    
    func startCreatePatientProfile(  profileImage:  UIImage?) {

        
        let parametersarr : [String : Any]  = ["FirstName" : FirstName ,"FirstNameAr" : FirstNameAr,
                          "MiddelName" : MiddelName ,"MiddelNameAr" : MiddelNameAr,
                          "FamilyName" : FamilyName ,"FamilyNameAr" : FamilyNameAr,
                          "GenderId" : GenderId ?? 1 ,
                           "Birthdate" : datef.string(from: self.Birthday ?? Date()) ,
                           "NationalityId" : NationalityId, "CountryId" : NationalityId,
                           "EmergencyContact": EmergencyContact, "OccupationId" : OccupationId,
                                               "CityId": CityId, "AreaId" : AreaId,"Address": Address,
                                               "Latitude": String(Latitude), "Longitude": String(Longitude),
                                               "BlockNo": BlockNo, "FloorNo": FloorNo, "ApartmentNo": ApartmentNo
                            
                                               
                          ]
        
        if Helper.isConnectedToNetwork(){
//        if isValid == true {
            
            ApiService.CreatePatientProfile(passedparameters : parametersarr , profileImage: profileImage,completion: { (success, model, err) in
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
    
    
}
