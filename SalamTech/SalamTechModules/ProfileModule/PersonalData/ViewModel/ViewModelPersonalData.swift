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
    let passthroughModelSubject = PassthroughSubject<BaseResponse<PatientInfo>, Error>()
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
    
    @Published  var profileImage = UIImage()
    
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
    @Published var publishedDoctorCreatedModel: PatientInfo? = nil
    
    @Published var UserCreated = false
    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
    
    init() {
        //     validations()
        //-----------------------------------------------------------------
        passthroughModelSubject.sink { (completion) in
            //            print(completion)
        } receiveValue: {[self] (modeldata) in
            self.publishedDoctorCreatedModel = modeldata.data
            if publishedDoctorCreatedModel != nil {
                UserCreated = true
            }
            
        }.store(in: &cancellables)
        
    }
    
}


extension ViewModelCreatePatientProfile:TargetType{
    var url: String {
        return URLs().PatientCreateProfile
    }
    
    var method: httpMethod {
        return .Post
    }
    
    var parameter: parameterType {
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
        return .parameterRequest(Parameters: parametersarr, Encoding: JSONEncoding.default)
    }
    
    var header: [String : String]? {
        let header = ["Content-Type":"multipart/form-data" ,
                      "Authorization":Helper.getAccessToken()]
        return header
    }
    
    func startCreatePatientProfile(profileImage:  UIImage?){
        print(parameter)
        if Helper.isConnectedToNetwork(){
            self.isLoading = true
            BaseNetwork.multipartRequest(Target: self, image: profileImage, responseModel: BaseResponse<PatientInfo>.self) { [self] (success, model, err) in
                if success{
                    //case of success
                    DispatchQueue.main.async {
                        self.passthroughModelSubject.send( model!  )
                        //                        print(model!)
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
