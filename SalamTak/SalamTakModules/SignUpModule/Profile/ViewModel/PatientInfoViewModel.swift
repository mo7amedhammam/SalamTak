//
//  PatientInfoViewModel.swift
//  SalamTak
//
//  Created by wecancity on 29/12/2022.
//

import Combine
import Alamofire

class PatientInfoViewModel: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<PatientInfoModel>, Error>()
    private var cancellables: Set<AnyCancellable> = []
    
//    // ------- input
    @Published var PatientProfileOP : PatientInfoProfileOp = .GetPatientProfileInfo

    // ------- input
    @Published  var PatientId: Int = 0
    @Published  var profileImage = UIImage()
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
    @Published  var GenderName: String?

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
    
    
    @Published  var NationalityName: String = ""
    @Published  var countryName             : String = ""
    @Published  var cityName             : String = ""
    @Published  var areaName             : String = ""
    @Published  var occupationName       : String = ""
    
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

    //    //------- output
    @Published var publishedDoctorModel: PatientInfoModel?
    @Published var UserUpdated = false
    @Published var isLoading:Bool? = false
    @Published var isAlert = false
    @Published var activeAlert: ActiveAlert = .NetworkError
    @Published var message = ""
    
    init() {
        DocProfileOperation(Operation: .GetPatientProfileInfo)
        passthroughModelSubject.sink { (completion) in
        } receiveValue: {[weak self]  (modeldata) in
//            self?.publishedDoctorModel = modeldata.data
            print(modeldata)
            self?.PatientId = modeldata.data?.id ?? 0
            self?.FirstName = modeldata.data?.firstName ?? ""
            self?.FirstNameAr = modeldata.data?.firstNameAr ?? ""
            self?.MiddelName = modeldata.data?.middelName ?? ""
            self?.MiddelNameAr = modeldata.data?.middelNameAr ?? ""
            self?.FamilyName = modeldata.data?.familyName ?? ""
            self?.FamilyNameAr = modeldata.data?.familyNameAr ?? ""
            self?.GenderId = modeldata.data?.genderID ?? 0
            self?.EmergencyContact = modeldata.data?.emergencyContact ?? ""
            self?.OccupationId = modeldata.data?.occupationID ?? 0
            self?.occupationName = modeldata.data?.occupationName ?? ""
            self?.NationalityId = modeldata.data?.nationalityID ?? 0
            self?.NationalityName = modeldata.data?.nationalityName ?? ""
            self?.CountryId = modeldata.data?.countryID ?? 0
            self?.countryName = modeldata.data?.countryName ?? ""
            self?.CityId = modeldata.data?.cityID ?? 0
            self?.cityName = modeldata.data?.cityName ?? ""
            self?.AreaId = modeldata.data?.areaID ?? 0
            self?.areaName = modeldata.data?.areaName ?? ""
            self?.Address = modeldata.data?.address ?? ""
            self?.Longitude = Double(modeldata.data?.longitude ?? "") ?? 0.0
            self?.Latitude = Double(modeldata.data?.latitude ?? "") ?? 0.0
            self?.BlockNo = modeldata.data?.blockNo ?? ""
            self?.FloorNo = modeldata.data?.floorNo ?? 0
            self?.ApartmentNo = modeldata.data?.apartmentNo ?? ""
            self?.Birthday =  ChangeFormate(NewFormat: "yyyy-MM-dd'T'hh:mm:ss").date(from:modeldata.data?.birthdate ?? "")
//            DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
//                self?.date =  (self?.publishedDoctorModel?.birthday ?? "").StrToDate(format: "yyyy-MM-dd'T'hh:mm:ss")
            DispatchQueue.global(qos: .userInitiated).async{[unowned self] in
                Helper.setUserimage(userImage: URLs.BaseUrl+"\(self?.publishedDoctorModel?.image ?? "")")
            }
//            })
        }.store(in: &cancellables)
    }
}


enum PatientInfoProfileOp{
    case GetPatientProfileInfo, CreatePatientProfileInfo, UpdatePatientProfileInfo
}

extension PatientInfoViewModel:TargetType{
    
    var url: String {
        switch PatientProfileOP{
        case .GetPatientProfileInfo:
            return URLs().PatientGetProfile
        case .CreatePatientProfileInfo:
            return URLs().PatientCreateProfile
        case .UpdatePatientProfileInfo:
            return URLs().PatientUpdateProfile
        }
    }
    
    var method: httpMethod {
        switch PatientProfileOP{
    case .GetPatientProfileInfo:
        return  .Get
        case .CreatePatientProfileInfo,.UpdatePatientProfileInfo:
        return .Post
        }
    }
    var parameter: parameterType {
        switch PatientProfileOP{
    case .GetPatientProfileInfo:
            return .plainRequest
        case .CreatePatientProfileInfo, .UpdatePatientProfileInfo :
        var parametersarr : [String : Any]  = ["FirstName" : FirstName ,"FirstNameAr" : FirstNameAr,
                                               "MiddelName" : MiddelName ,"MiddelNameAr" : MiddelNameAr,
                                               "FamilyName" : FamilyName ,"FamilyNameAr" : FamilyNameAr,
                                               "GenderId" : GenderId ?? 1 ,
                                               "Birthdate" : ChangeFormate(NewFormat: "dd/MM/yyyy").string(from: Birthday ?? Date()) ,
                                               "NationalityId" : NationalityId, "CountryId" : CountryId,
                                               "EmergencyContact": EmergencyContact, "OccupationId" : OccupationId,
                                               "CityId": CityId, "AreaId" : AreaId,"Address": Address,
                                               "Latitude": String(Latitude), "Longitude": String(Longitude),
                                               "BlockNo": BlockNo, "FloorNo": FloorNo, "ApartmentNo": ApartmentNo
                                                ]
            if PatientId != 0 {
                PatientProfileOP = .UpdatePatientProfileInfo
                parametersarr["Id"] = PatientId
            }
        return .parameterRequest(Parameters: parametersarr, Encoding: JSONEncoding.default)
        }
    }
    
    var header: [String : String]? {
        let header = ["Authorization":Helper.getAccessToken()]
        return header
    }
    
    func DocProfileOperation(Operation:PatientInfoProfileOp){
        self.PatientProfileOP = Operation
        switch Operation{
    case .GetPatientProfileInfo:
            startFetchDoctorProfile()
    case .CreatePatientProfileInfo:
            startUpdatingPatientInfo()
        case .UpdatePatientProfileInfo:
            startUpdatingPatientInfo()
        }
    }
    
    func startFetchDoctorProfile(){
        if Helper.isConnectedToNetwork(){
            self.isLoading = true
            BaseNetwork.request(Target: self, responseModel: BaseResponse<PatientInfoModel>.self) { [self] (success, model, err) in
                if success{
                    //case of success
//                    DispatchQueue.main.async {
                        self.passthroughModelSubject.send(model!)
//                    }
                }else{
                    if model != nil{
                        //case of model with error
                        message = model?.message ?? "Bad Request"
                        isAlert = true
                        print(model)
                        
                    }else{
                        if err == "Unauthorized"{
                            //case of Empty model (unauthorized)
                            activeAlert = .unauthorized
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

    func startUpdatingPatientInfo(){
        if Helper.isConnectedToNetwork(){
            self.isLoading = true
            BaseNetwork.multipartRequest(Target: self, image: profileImage, responseModel: BaseResponse<PatientInfoModel>.self) { [self] (success, model, err) in
                if success{
                    //case of success
//                    DispatchQueue.main.async {
                        self.passthroughModelSubject.send( model!  )
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
                        }else if err == "imageError"{
                            message = "can't get image data"
                        }else{
                            isAlert = true
                            message = err ?? "there is an error"
                        }
                    }
//                    isAlert = true
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
