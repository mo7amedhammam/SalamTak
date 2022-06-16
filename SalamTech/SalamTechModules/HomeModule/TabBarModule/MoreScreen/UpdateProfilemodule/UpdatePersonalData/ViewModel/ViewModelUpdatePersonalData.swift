//
//  ViewModelPersonalData.swift
//  SalamTech
//
//  Created by Mohamed Hammam on 31/03/2022.
//

import Foundation
import Combine
import Alamofire

class ViewModelUpdatePatientProfile: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<Patient>, Error>()
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var updatePersonalInfoOperation : UpdatePersonalInfoOp = .getPersonalInfo

    // ------- input
    @Published  var FirstName : String = ""
    {
        didSet{
            if self.FirstName.isEmpty{
                self.errorFirstName = "*"
            } else {
                self.errorFirstName = ""
            }
        }
    }
    @Published  var FirstNameAr: String = ""
    {
        didSet{
            if self.FirstNameAr.isEmpty{
                self.errorFirstNameAr = "*"
            } else {
                self.errorFirstNameAr = ""
            }
        }
    }
    @Published  var MiddelName: String = ""
    {
        didSet{
            if self.MiddelName.isEmpty{
                self.errorMiddelName = "*"
            } else {
                self.errorMiddelName = ""
            }
        }
    }
    @Published  var MiddelNameAr: String = ""
    {
        didSet{
            if self.MiddelNameAr.isEmpty{
                self.errorMiddelNameAr = "*"
            } else {
                self.errorMiddelNameAr = ""
            }
        }
    }
    @Published  var FamilyName: String = ""
    {
        didSet{
            if self.FamilyName.isEmpty{
                self.errorLastName = "*"
            } else {
                self.errorLastName = ""
            }
        }
    }
    @Published  var FamilyNameAr: String = ""
    {
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
    @Published var date: Date? = Date()
    @Published  var profileImage = UIImage()
    
    @Published  var NationalityName: String = ""
    @Published  var cityName             : String = ""
    @Published  var areaName             : String = ""
    @Published  var occupationName       : String = "Occupation"
    @Published var ImageUrl :String = ""
    
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
    @Published var publishedPatientGetModel: Patient?

    @Published var UserCreated = false

    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""

    
    init() {
                
        passthroughModelSubject.sink { (completion) in
            //            print(completion)
        } receiveValue: { [self] (modeldata) in
            publishedPatientGetModel = modeldata.data
            
            FirstName = publishedPatientGetModel?.firstName ?? ""
            FirstNameAr = publishedPatientGetModel?.firstNameAr ?? ""
            MiddelName = publishedPatientGetModel?.middleName ?? ""
            MiddelNameAr = publishedPatientGetModel?.middleNameAr ?? ""
            FamilyName = publishedPatientGetModel?.familyName ?? ""
            FamilyNameAr = publishedPatientGetModel?.familyNameAr ?? ""
            EmergencyContact = publishedPatientGetModel?.emergencyContact ?? ""
            GenderId = publishedPatientGetModel?.genderId ?? 0
            NationalityId = publishedPatientGetModel?.nationalityId ?? 0
            CityId = publishedPatientGetModel?.cityId ?? 0
            AreaId = publishedPatientGetModel?.areaId ?? 0
            CountryId = publishedPatientGetModel?.nationalityId ?? 0
            OccupationId = publishedPatientGetModel?.occupationId ?? 0
            occupationName = publishedPatientGetModel?.OccupationName ?? ""
            ImageUrl = publishedPatientGetModel?.image ?? ""
            Birthday = publishedPatientGetModel?.birthdate ?? ""
            date = ChangeFormate(NewFormat: "yyyy-MM-dd'T'HH:mm:ss").date(from: Birthday)
            Id = publishedPatientGetModel?.id
            Address = publishedPatientGetModel?.address ?? ""
            NationalityName = publishedPatientGetModel?.nationalityName ?? "Nationality"
            cityName = publishedPatientGetModel?.cityName ?? "City"
            areaName = publishedPatientGetModel?.areaName ?? "Area"
            FloorNo = publishedPatientGetModel?.floorNo ?? 0
            BlockNo = publishedPatientGetModel?.blockNo ?? ""
            ApartmentNo = publishedPatientGetModel?.apartNo ?? ""

        }.store(in: &cancellables)
        
    }
}

enum UpdatePersonalInfoOp{
    case getPersonalInfo, updatePersonalInfo
}

extension ViewModelUpdatePatientProfile:TargetType{
    var url: String {
        switch updatePersonalInfoOperation{
        case .getPersonalInfo:
           return  URLs().PatientGetProfile
        case .updatePersonalInfo:
            return  URLs().PatientUpdateProfile
        }
    }
    
    var method: httpMethod {
        switch updatePersonalInfoOperation{
    case .getPersonalInfo:
            return .Get
    case .updatePersonalInfo:
            return .Post
    }
    }
    
    var parameter: parameterType {
        switch updatePersonalInfoOperation{
    case .getPersonalInfo:
            return .plainRequest
    case .updatePersonalInfo:
            let parametersarr : [String : Any]  = ["FirstName" : FirstName ,
                                                   "FirstNameAr" : FirstNameAr,
                                                   "MiddelName" : MiddelName ,
                                                   "MiddelNameAr" : MiddelNameAr,
                                                   "FamilyName" : FamilyName ,
                                                   "FamilyNameAr" : FamilyNameAr,
                                                   "GenderId" : GenderId ?? 1 ,
                                                   "Birthdate" : ChangeFormate(NewFormat: "yyyy-MM-dd'T'HH:mm:ss").string(from: date ?? Date()),
//                                                    ConvertDateFormateToStr(inp: date ?? Date(), FormatTo: "yyyy-MM-dd'T'HH:mm:ss") ,
                                                   "NationalityId" : NationalityId,
                                                   "CountryId" : NationalityId,
                                                   "EmergencyContact": EmergencyContact,
                                                   "OccupationId" : OccupationId,
                                                   "CityId": CityId, "AreaId" : AreaId,
                                                   "Address": Address, "Latitude": String(Latitude),
                                                   "Longitude": String(Longitude),
                                                   "BlockNo": BlockNo, "FloorNo": FloorNo,
                                                   "ApartmentNo": ApartmentNo, "Id":Id ?? 0
                                                    ]
            
            return .parameterRequest(Parameters: parametersarr, Encoding: JSONEncoding.default)
    }
    }
    
    var header: [String : String]? {
        let header = ["Authorization":Helper.getAccessToken()]
        return header
    }
    
    
    func updatePersonalInfo(operation:UpdatePersonalInfoOp){
        updatePersonalInfoOperation = operation
        print(parameter)
        if Helper.isConnectedToNetwork(){
            self.isLoading = true
            BaseNetwork.request(Target: self, responseModel: BaseResponse<Patient>.self   ) { [self] (success, model, err) in
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
