//
//  PatientInfoViewModel.swift
//  SalamTak
//
//  Created by wecancity on 29/12/2022.
//

import Combine
import Alamofire
import Foundation
import UIKit
//import UIKit

class PatientInfoViewModel: ObservableObject {
    
    let passthroughSubject = PassthroughSubject<String, Error>()
    let passthroughModelSubject = PassthroughSubject<BaseResponse<PatientInfoModel>, Error>()
    private var cancellables: Set<AnyCancellable> = []
    
//    // ------- input
    @Published var PatientProfileOP : PatientInfoProfileOp = .GetPatientProfileInfo

    // ------- input
    @Published  var PatientId : Int = 0
    @Published  var profileImage : UIImage = UIImage()
    @Published  var profileImageStr = ""
    @Published  var FirstName : String = ""
    @Published  var FirstNameAr : String = ""
    @Published  var MiddelName : String = ""
    @Published  var MiddelNameAr : String = ""
    @Published  var FamilyName : String = ""
    @Published  var FamilyNameAr : String = ""
    @Published  var NationalityId : Int = 1111
    @Published  var CountryId : Int = 0
    @Published  var GenderId : Int?               // 1 for male  2 for female
    @Published  var GenderName : String?

    @Published  var Birthday = (Calendar.current.date(byAdding: .year, value: -18, to: Date()) ?? Date())              //  date format "yyyy/mm/dd"
    @Published  var BirthdayStr = ""
    @Published  var EmergencyContact : String = ""
    @Published  var OccupationId: Int = 0
    @Published  var CityId : Int = 0
    @Published  var AreaId : Int = 0
    @Published  var Address : String = ""
    @Published  var Latitude  = 0.0
    @Published  var Longitude = 0.0
    @Published  var FloorNo : String = ""
    @Published  var BlockNo : String = ""
    @Published  var ApartmentNo : String = ""
    
    @Published  var NationalityName: String = ""
    @Published  var countryName             : String = ""
    @Published  var cityName             : String = ""
    @Published  var areaName             : String = ""
    @Published  var occupationName       : String = ""
    
    //------- validation
    @Published  var errorFirstName : String = ""
    @Published  var errorFirstNameAr : String = ""
    @Published  var errorMiddelName : String = ""
    @Published  var errorMiddelNameAr : String = ""
    @Published  var errorLastName : String = ""
    @Published  var errorLastNameAr : String = ""
    @Published  var errorNationalityId : Int = 0
    @Published  var errorGenderId : Int?               // 1 for male  2 for female
    @Published  var errorSpecialistId : Int = 0
    @Published  var errorBirthday : String = ""              //  date format "yyyy/mm/dd"
    @Published  var errorSeniorityLevelId : Int = 0
    @Published  var errorWebsite : String = ""
    @Published  var errorDoctorInfo : String = ""
    @Published  var errorDoctorInfoAr : String = ""

    //    //------- output
    @Published var formIsValid : Bool = false
//    @Published var publishedDoctorModel: PatientInfoModel?
    @Published var UserCreated = false
    @Published var UserUpdated = false
    @Published var userexist = false

    @Published var isLoading : Bool? = false
    @Published var isAlert = false
    @Published var activeAlert : ActiveAlert = .NetworkError
    @Published var message = ""

    var Pamodel = BaseResponse<PatientInfoModel>()

    init() {
        checkvalidations()
//        execute(Operation: .GetPatientProfileInfo)
        
//        passthroughModelSubject.sink { (completion) in
//        } receiveValue: {[weak self]  (modeldata) in
//            if self?.PatientProfileOP == .CreatePatientProfileInfo && modeldata.success ?? false{
////                self?.userexist = true
//                self?.UserCreated = true
//            }
////            self?.publishedDoctorModel = modeldata.data
////            DispatchQueue.main.async{
////            print(modeldata)
////            self?.profileImageStr = modeldata.data?.image ?? ""
////            self?.PatientId = modeldata.data?.id ?? 0
////            self?.FirstName = modeldata.data?.firstName ?? ""
////            self?.FirstNameAr = modeldata.data?.firstNameAr ?? ""
////            self?.MiddelName = modeldata.data?.middelName ?? ""
////            self?.MiddelNameAr = modeldata.data?.middelNameAr ?? ""
////            self?.FamilyName = modeldata.data?.familyName ?? ""
////            self?.FamilyNameAr = modeldata.data?.familyNameAr ?? ""
////            self?.GenderId = modeldata.data?.genderID ?? 0
////            self?.EmergencyContact = modeldata.data?.emergencyContact ?? ""
////            self?.OccupationId = modeldata.data?.occupationID ?? 0
////            self?.occupationName = modeldata.data?.occupationName ?? ""
////            self?.NationalityId = modeldata.data?.nationalityID ?? 0
////            self?.NationalityName = modeldata.data?.nationalityName ?? ""
////            self?.CountryId = modeldata.data?.countryID ?? 0
////            self?.countryName = modeldata.data?.countryName ?? ""
////            self?.CityId = modeldata.data?.cityID ?? 0
////            self?.cityName = modeldata.data?.cityName ?? ""
////            self?.AreaId = modeldata.data?.areaID ?? 0
////            self?.areaName = modeldata.data?.areaName ?? ""
////            self?.Address = modeldata.data?.address ?? ""
////            self?.Longitude = Double(modeldata.data?.longitude ?? "") ?? 0.0
////            self?.Latitude = Double(modeldata.data?.latitude ?? "") ?? 0.0
////            self?.BlockNo = modeldata.data?.blockNo ?? ""
////            self?.FloorNo = modeldata.data?.floorNo ?? 0 > 0 ? String(modeldata.data?.floorNo ?? 0 ):""
////            self?.ApartmentNo = modeldata.data?.apartmentNo ?? ""
////            self?.Birthday = ChangeFormate(NewFormat: "yyyy-MM-dd'T'hh:mm:ss").date(from:modeldata.data?.birthdate  ?? "") ?? Date()
////                Helper.setUserimage(userImage: URLs.BaseUrl+"\(modeldata.data?.image ?? "")")
////            }
//        }.store(in: &cancellables)
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
                                               "Birthdate" : ChangeFormate(NewFormat: "yyyy-MM-dd'T'HH:mm:ss").string(from: Birthday) ,
                                               "NationalityId" : CountryId, "CountryId" : CountryId,
                                               "EmergencyContact": EmergencyContact, "OccupationId" : OccupationId,
                                               "CityId": CityId, "AreaId" : AreaId,"Address": Address,
                                               "Latitude": String(Latitude), "Longitude": String(Longitude),
                                               "BlockNo": BlockNo, "FloorNo": Int(FloorNo) ?? 0, "ApartmentNo": ApartmentNo
                                                ]
            if PatientId != 0 && PatientProfileOP == .UpdatePatientProfileInfo{
                parametersarr["Id"] = PatientId
            }
            if profileImage.size.width > 0 && PatientProfileOP == .CreatePatientProfileInfo{
                parametersarr["profileImage"] = profileImage
            }
        return .parameterRequest(Parameters: parametersarr, Encoding: JSONEncoding.default)
        }
    }
    
    var header: [String : String]? {
        let header = ["Authorization":Helper.getAccessToken(),"accept":"text/plain","Content-Type":"application/json"]
        return header
    }
    
    func execute(Operation:PatientInfoProfileOp){
        UserCreated = false
        UserUpdated = false

        self.PatientProfileOP = Operation
        switch Operation{
    case .GetPatientProfileInfo:
            startFetchDoctorProfile()
            print(url)

        case .CreatePatientProfileInfo:
            startCreatingPatientInfo()
            print(url)

        case .UpdatePatientProfileInfo:
            startUpdatingPatientInfo()
            print(url)
        }
    }
    
    func startFetchDoctorProfile(){
        if Helper.isConnectedToNetwork(){
            self.isLoading = true
            BaseNetwork().makeRequest(Target: self, Model: BaseResponse<PatientInfoModel>.self)
//                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    // Handle the error here
                    print(error)
                    self.message = error.localizedDescription
                    self.isAlert = true
                    self.isLoading = false

                case .finished:
                    break
                }
                }, receiveValue: {[weak self]  model in
                        // model is of type MyModel
                        if self?.PatientProfileOP == .CreatePatientProfileInfo && model.success ?? false{
                            self?.UserCreated = true
                        }
//                        DispatchQueue.main.async{
                        print(model)
                        self?.profileImageStr = model.data?.image ?? ""
                        self?.PatientId = model.data?.id ?? 0
                        self?.FirstName = model.data?.firstName ?? ""
                        self?.FirstNameAr = model.data?.firstNameAr ?? ""
                        self?.MiddelName = model.data?.middelName ?? ""
                        self?.MiddelNameAr = model.data?.middelNameAr ?? ""
                        self?.FamilyName = model.data?.familyName ?? ""
                        self?.FamilyNameAr = model.data?.familyNameAr ?? ""
                        self?.GenderId = model.data?.genderID ?? 0
                        self?.EmergencyContact = model.data?.emergencyContact ?? ""
                        self?.OccupationId = model.data?.occupationID ?? 0
                        self?.occupationName = model.data?.occupationName ?? ""
                        self?.NationalityId = model.data?.nationalityID ?? 0
                        self?.NationalityName = model.data?.nationalityName ?? ""
                        self?.CountryId = model.data?.countryID ?? 0
                        self?.countryName = model.data?.countryName ?? ""
                        self?.CityId = model.data?.cityID ?? 0
                        self?.cityName = model.data?.cityName ?? ""
                        self?.AreaId = model.data?.areaID ?? 0
                        self?.areaName = model.data?.areaName ?? ""
                        self?.Address = model.data?.address ?? ""
                        self?.Longitude = Double(model.data?.longitude ?? "") ?? 0.0
                        self?.Latitude = Double(model.data?.latitude ?? "") ?? 0.0
                        self?.BlockNo = model.data?.blockNo ?? ""
                        self?.FloorNo = model.data?.floorNo ?? 0 > 0 ? String(model.data?.floorNo ?? 0 ):""
                        self?.ApartmentNo = model.data?.apartmentNo ?? ""
                        self?.Birthday = ChangeFormate(NewFormat: "yyyy-MM-dd'T'HH:mm:ss").date(from:model.data?.birthdate  ?? "") ?? Date()
                        self?.BirthdayStr = ChangeFormate(NewFormat: "dd/MM/yyyy").string(from: self?.Birthday ?? Date())

                            Helper.setUserimage(userImage: URLs.BaseUrl+"\(model.data?.image ?? "")")
//                        }
                    self?.isLoading = false
                }
                ).store(in: &cancellables)

            
//            BaseNetwork.DoRequest(Target: self,responseModel: BaseResponse<PatientInfoModel>.self) { [self] result in
//                switch result {
//                case .success(let model):
//                    // model is of type MyModel
//                                    print(model)
//                    self.passthroughModelSubject.send(model)
//                case .failure(let error):
//                    // Handle the error here
//                                        print(error)
//                }
//                isLoading = false
//            }
            
//            BaseNetwork.request(Target: self, responseModel: BaseResponse<PatientInfoModel>.self) { [self] (success, model, err) in
//                if success{
//                    //case of success
////                    DispatchQueue.main.async {
//                        self.passthroughModelSubject.send(model!)
////                    }
//                }else{
//                    if model != nil{
//                        //case of model with error
//                        message = model?.message ?? "Bad Request"
//                        isAlert = true
////                        print(model)
//                    }else{
//                        if err == "Unauthorized"{
//                            //case of Empty model (unauthorized)
//                            activeAlert = .unauthorized
//                            message = "Session_expired\nlogin_again".localized(language)
//                        }else{
//                            isAlert = true
//                            message = err ?? "there is an error"
//                        }
//                    }
//                    isAlert = true
//                }
//                isLoading = false
//            }
        
        }else{
            //case of no internet connection
            message = "Check_Your_Internet_Connection".localized(language)
            isAlert = true
        }
    }

    func startCreatingPatientInfo(){
        if Helper.isConnectedToNetwork(){
            print(parameter)
            self.isLoading = true
            
            
            BaseNetwork().makeMultipartRequest(Target: self, Model: BaseResponse<PatientInfoModel>.self)
//                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    // Handle the error here
                    print(error)
                    self.message = error.localizedDescription
                    self.isAlert = true
                    self.isLoading = false

                case .finished:
                    break
                }
                }, receiveValue: {[weak self]  model in
                        // model is of type MyModel
                        if self?.PatientProfileOP == .CreatePatientProfileInfo && model.success ?? false{
                            self?.UserCreated = true
                        }else{
                        print(model)
                        }
                    self?.isLoading = false
                }
                ).store(in: &cancellables)
            
            
            
//            BaseNetwork.multipartRequest(Target: self, image: profileImage, imageName: "profileImage", responseModel: BaseResponse<PatientInfoModel>.self) { [self] (success, model, err) in
//                if success{
//                    //case of success
////                    DispatchQueue.main.async {
//                        self.passthroughModelSubject.send( model! )
////                    }
//                }else{
//                    if model != nil{
//                        //case of model with error
//                        message = model?.message ?? "Bad Request"
//                        isAlert = true
//                    }else{
//                        if err == "Unauthorized"{
//                            //case of Empty model (unauthorized)
//                            message = "Session_expired\nlogin_again".localized(language)
//                        }else if err == "imageError"{
//                            message = "can't get image data"
//                        }else{
//                            isAlert = true
//                            message = err ?? "there is an error"
//                        }
//                    }
////                    isAlert = true
//                }
//                isLoading = false
//            }
            
        }else{
            //case of no internet connection
            message = "Check_Your_Internet_Connection".localized(language)
            isAlert = true
            isLoading = false
        }
    }
    func startUpdatingPatientInfo(){
        if Helper.isConnectedToNetwork(){
            self.isLoading = true
            BaseNetwork().makeRequest(Target: self, Model: BaseResponse<PatientInfoModel>.self)
//                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    // Handle the error here
                    print(error)
                    self.message = error.localizedDescription
                    self.isAlert = true
                    self.isLoading = false

                case .finished:
                    break
                }
                }, receiveValue: {[weak self]  model in
                        // model is of type MyModel
                        if model.success ?? false{
                            self?.UserUpdated = true
                        }else {
                        print(model)
                        }
                    self?.message = model.message ?? ""
                    self?.isAlert = true

                    self?.isLoading = false
                }
                ).store(in: &cancellables)
            
            
//            BaseNetwork.request(Target: self, responseModel: BaseResponse<PatientInfoModel>.self) { [self] (success, model, err) in
//                if success{
//                    //case of success
////                    DispatchQueue.main.async {
//                        self.passthroughModelSubject.send( model! )
////                    }
//                }else{
//                    if model != nil{
//                        //case of model with error
//                        message = model?.message ?? "Bad Request"
//                        isAlert = true
//                    }else{
//                        if err == "Unauthorized"{
//                            //case of Empty model (unauthorized)
//                            message = "Session_expired\nlogin_again".localized(language)
//                        }else if err == "imageError"{
//                            message = "can't get image data"
//                        }else{
//                            isAlert = true
//                            message = err ?? "there is an error"
//                        }
//                    }
////                    isAlert = true
//                }
//                isLoading = false
//            }
            
        }else{
            //case of no internet connection
            message = "Check_Your_Internet_Connection".localized(language)
            isAlert = true
            isLoading = false
        }
    }
}

// MARK: - Setup validations
extension PatientInfoViewModel{
    var validIProfileImage: AnyPublisher<Bool, Never> {
       $profileImage
         .map { image in
             guard (image.size.width ) > 0 else {
                 return false
             }
             return true
         }
         .eraseToAnyPublisher()
     }
    var validIProfileImageStr: AnyPublisher<Bool, Never> {
       $profileImageStr
         .map { image in
             guard image != "" else {
                 return false
             }
             return true
         }
         .eraseToAnyPublisher()
     }
    
    var validImage: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(validIProfileImage,validIProfileImageStr)
            .map{ first, second in
                return first || second
            }

         .eraseToAnyPublisher()
     }
    
    var validfirstEnName: AnyPublisher<Bool, Never> {
        $FirstName
         .map { name in
             guard "\(name)".count > 0 else {
                 return false
             }
             return true
         }
         .eraseToAnyPublisher()
     }
    var validmiddleEnName: AnyPublisher<Bool, Never> {
        $MiddelName
         .map { name in
             guard "\(name)".count > 0 else {
                 return false
             }
             return true
         }
         .eraseToAnyPublisher()
     }
    var validfamilyEnName: AnyPublisher<Bool, Never> {
        $FamilyName
         .map { name in
             guard "\(name)".count > 0 else {
                 return false
             }
             return true
         }
         .eraseToAnyPublisher()
     }
    var validfirstArName: AnyPublisher<Bool, Never> {
        $FirstNameAr
         .map { name in
             guard "\(name)".count > 0 else {
                 return false
             }
             return true
         }
         .eraseToAnyPublisher()
     }
    var validmiddleArName: AnyPublisher<Bool, Never> {
        $MiddelNameAr
         .map { name in
             guard "\(name)".count > 0 else {
                 return false
             }
             return true
         }
         .eraseToAnyPublisher()
     }
    var validfamilyArName: AnyPublisher<Bool, Never> {
        $FamilyNameAr
         .map { name in
             guard "\(name)".count > 0 else {
                 return false
             }
             return true
         }
         .eraseToAnyPublisher()
     }
    
    
    var validEnName:AnyPublisher<Bool,Never>{
        Publishers.CombineLatest3(validfirstEnName,validmiddleEnName,validfamilyEnName)
            .map{ first, second, third in
                return first && second && third
            }
            .eraseToAnyPublisher()
    }
    var validArName:AnyPublisher<Bool,Never>{
        Publishers.CombineLatest3(validfirstArName,validmiddleArName,validfamilyArName)
            .map{ first, second, third in
                return first && second && third
            }
            .eraseToAnyPublisher()
    }

    var validName:AnyPublisher<Bool,Never>{
        Publishers.CombineLatest(validEnName,validArName)
            .map{ first, second in
                return first && second
            }
            .eraseToAnyPublisher()
    }

    

    
    var isvalidForm: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest (
        validImage,
        validName)
        .map { first, Second in
            return first && Second && (self.GenderId != 0)
        }
        .eraseToAnyPublisher()
    }
    
    func checkvalidations(){
        isvalidForm
          .receive(on: RunLoop.main)
          .assign(to: \.formIsValid, on: self)
          .store(in: &cancellables)
    }
   
    
}
