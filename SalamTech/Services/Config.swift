//
//  Config.swift
//  SalamTech
//
//  Created by wecancity agency on 3/29/22.
//

import Foundation
import SwiftUI

//enum lang: String {
//
////    case russian = "ru"
//    case  CreateUser = "https://salamtech.azurewebsites.net/api/\(language)/User/CreateUser"
////    case spanish = "es"
////    case arabic = "ar"
//
//}

class URLs {
     
//    @ObservedObject var lang2 : lango.init()
    // get language from user default and pass it to BaseURL
    
    
//    static var language = Helper.getLanguage()
     static let BaseUrl = "https://salamtech.azurewebsites.net"
//    mutating func changelang(){
//        self.language = Helper.getLanguage()
//    }
    
    // MARK: -------- Authntication ------
    
//     func add(lang:String){
//        language = lang
//        print(language)
////        let CreateUser1 = BaseUrl + "/api/\(language)/User/CreateUser"
////        print(CreateUser1)
//    }
     var CreateUser = BaseUrl + "/api/\(Helper.getLanguage())/User/CreateUser"
     var RegisterUser = BaseUrl + "/api/\(Helper.getLanguage())/User/Register"
     var LoginUser = BaseUrl + "/api/\(Helper.getLanguage())/User/Login"
     var ResetPassword = BaseUrl + "/api/\(Helper.getLanguage())/User/ResetPassword"
     var UpdatePassword = BaseUrl + "/api/\(Helper.getLanguage())/User/UpdatePassword"
    
    
    // MARK: -------- Patient ------
    
    /// create patient profile >> needs token
    var PatientCreateProfile = BaseUrl + "/api/\(Helper.getLanguage())/Patient/CreateProfile"
    
    var GetBloodTypes = BaseUrl + "/api/\(Helper.getLanguage())/PatientLookUp/GetBloodTypes"
    
    var GetMedicineAllergy = BaseUrl + "/api/\(Helper.getLanguage())/PatientLookUp/GetMedicineAllergy"
    
    var GetFoodAllergy = BaseUrl + "/api/\(Helper.getLanguage())/PatientLookUp/GetFoodAllergy"
   
    
    
    
    // MARK: -------- Doctor ------
    
    /// get specialist >> needs token
    var GetSpecialist = BaseUrl + "/api/\(Helper.getLanguage())/Specialist/GetSpecialist"
   
    /// get sub specialist >> needs token
    var GetSubSpecialist = BaseUrl + "/api/\(Helper.getLanguage())/Specialist/GetSubSpecialist"
    
    /// get sub specialist >> needs token
    var GetSeniorityLevel = BaseUrl + "/api/\(Helper.getLanguage())/SeniorityLevel/GetSeniorityLevel"
    
    /// get country >> needs token
    var GetCountries = BaseUrl + "/api/\(Helper.getLanguage())/LookUp/GetCountries"
    
    var GetOccupation = BaseUrl + "/api/\(Helper.getLanguage())/LookUp/GetOccupation"
   
    /// get city>> needs countryid
    var GetCities = BaseUrl + "/api/\(Helper.getLanguage())/City/GetCities"
    /// get city>> needs countryid
    var GetCityById = BaseUrl + "/api/\(Helper.getLanguage())/City/GetCityById"
    
    /// get area  >> needs cityid
    var GetAreas = BaseUrl + "/api/\(Helper.getLanguage())/Area/GetAreasByCityId"

    var GetAreanameByAreaId = BaseUrl + "/api/\(Helper.getLanguage())/Area/GetAreaById"

    var GetDays = BaseUrl + "/api/\(Helper.getLanguage())/LookUp/GetDays"
    
    var GetDuration = BaseUrl + "/api/\(Helper.getLanguage())/LookUp/GetDurationMedicalExamination"
    
    
    
    // MARK: ------------------------------
 
    ///Post -multipart/form-data
    var DoctorCreateProfile = BaseUrl + "/api/\(Helper.getLanguage())/Doctor/CreateProfile"
    
    ///Post -multipart/form-data
    var DoctorCreateCertificate = BaseUrl + "/api/\(Helper.getLanguage())/Doctor/CreateDoctorCertificate"
    var DoctorUpdateCertificate = BaseUrl + "/api/\(Helper.getLanguage())/Doctor/UpdateDoctorCertificate"
    
    ///Post -multipart/form-data
    var DoctorGetCertificates = BaseUrl + "/api/\(Helper.getLanguage())/Doctor/GetDoctorCertificate"
    
    var DoctorDeleteCertificates = BaseUrl + "/api/\(Helper.getLanguage())/Doctor/DeleteDoctorCertificates"
    
    var DoctorCreateLegalDocuments = BaseUrl + "/api/\(Helper.getLanguage())/Doctor/CreateDoctorDocuments"
    
    var DoctorDeleteLegalDocuments = BaseUrl + "/api/\(Helper.getLanguage())/Doctor/DeleteDoctorDocument"
    
    var DoctorGetLegalDocuments = BaseUrl + "/api/\(Helper.getLanguage())/Doctor/GetDoctorDocuments"
    
    var DoctorGetProfile = BaseUrl + "/api/\(Helper.getLanguage())/Doctor/GetDoctorProfile"
    
    var DoctorUpdateProfile = BaseUrl + "/api/\(Helper.getLanguage())/Doctor/UpdateProfile"
    
    var GetDoctorDashboard = BaseUrl + "/api/\(Helper.getLanguage())/DoctorDashboard/GetDoctorDashboard"

    
    // MARK: -------- Doctor Clinic ------
    ///post
    var DoctorCreateClinicInfo = BaseUrl + "/api/\(Helper.getLanguage())/DoctorClinic/CreateDoctorClinic"
    
    ///post
    var UpdateDoctorClinic = BaseUrl + "/api/\(Helper.getLanguage())/DoctorClinic/UpdateDoctorClinic"

    ///Get
    var DoctorGetClinics = BaseUrl + "/api/\(Helper.getLanguage())/DoctorClinic/GetDoctorClinics"
    ///Get
    var DoctorGetClinicInfoByClinicId = BaseUrl + "/api/\(Helper.getLanguage())/DoctorClinic/GetDoctorClinicByClinicId"

    /// get >  ClinicId : int
    var GetClinicGallery = BaseUrl + "/api/\(Helper.getLanguage())/DoctorClinic/GetClinicGalleryByClinicId"
    var ClinicCreateGallery = BaseUrl + "/api/\(Helper.getLanguage())/DoctorClinic/CreateClinicGallery"
    var DoctorDeleteClinicGalleryId = BaseUrl + "/api/\(Helper.getLanguage())/DoctorClinic/DeleteClinicGallery"

    
    
    /// post
    var DoctorCreateClinicSchedual = BaseUrl + "/api/\(Helper.getLanguage())/DoctorClinic/CreateDoctorClinicSchedual"

    /// get >  ClinicId : int
    var GetClinicSchedualByClinicId = BaseUrl + "/api/\(Helper.getLanguage())/DoctorClinic/GetClinicSchedualByClinicId"

    /// get >  ClinicId : int & Dayid : int
    var GetClinicSchedualByClinicDayId = BaseUrl + "/api/\(Helper.getLanguage())/DoctorClinic/GetClinicSchedualByClinicDayId"
    
    /// get >  ClinicId : int & Dayid : int
    var UpdateDoctorClinicSchedual = BaseUrl + "/api/\(Helper.getLanguage())/DoctorClinic/UpdateDoctorClinicSchedual"
    
    /// get >
    var Getservices = BaseUrl + "/api/\(Helper.getLanguage())/Services/GetServices"


    
    //MARK: ------ Appointments ----
    
    /// get >
    var GetHistoryDoctorAppointment = BaseUrl + "/api/\(Helper.getLanguage())/DoctorAppointment/GetHistoryDoctorAppointment"
    
    /// get >
    var GetCurrentDoctorAppointmen = BaseUrl + "/api/\(Helper.getLanguage())/DoctorAppointment/GetCurrentDoctorAppointment"
    
    /// get >
    var CancelAppointmen = BaseUrl + "/api/\(Helper.getLanguage())/DoctorAppointment/CancelAppointment"
    
    /// post >
    var SearchDoctorAppointmen = BaseUrl + "/api/\(Helper.getLanguage())/DoctorAppointment/SearchForDoctorAppointment"
  
    /// post >
    var GetPatientProfileBYAppointmentId = BaseUrl + "/api/\(Helper.getLanguage())/Patient/GetPatientDetails"
    /// post >
    var GetPatientEmrHistoryWithDetails = BaseUrl + "/api/\(Helper.getLanguage())/Patient/GetPatientEmrHistoryWithDetails"
    
    /// post >
    var CreatePatientEMRinstruction = BaseUrl + "/api/\(Helper.getLanguage())/Patient/CreatePatientEmr"
        /// post >
    var CreatePatientEMRDetails = BaseUrl + "/api/\(Helper.getLanguage())/Patient/CreatePatientEmrDetails"
    /// post >
    var CreatePatientEMRDocument = BaseUrl + "/api/\(Helper.getLanguage())/Patient/CreatePatientEmrDocument"
    /// post >
    var DeletePatientEMRDocument = BaseUrl + "/api/\(Helper.getLanguage())/Patient/DeletePatientDocumentEmr"
    /// post >
    var DeletePatientEMRDetails = BaseUrl + "/api/\(Helper.getLanguage())/Patient/DeletePatientEmrDetails"
    
        /// post >
    var GetMedicalExaminationType = BaseUrl + "/api/\(Helper.getLanguage())/LookUp/GetMedicalExaminationType"
    
    /// post >
    var GetDoctorSchedualByServiceId = BaseUrl + "/api/\(Helper.getLanguage())/DoctorService/GetDoctorSchedualByServiceId" // main list
    
    /// post >
    var GetDoctorSchedualByServiceDayId = BaseUrl + "/api/\(Helper.getLanguage())/DoctorService/GetDoctorServiceSchedualByServiceDayId"  // inside list by day Id

    /// post >
    var CreateDoctorSchedualByServiceId = BaseUrl + "/api/\(Helper.getLanguage())/DoctorService/CreateDoctorServiceSchedualByServiceId" // Create Schedual

    
   
    /// Get Services by dayid & service id
//static let GetDoctorServiceSchedualByServiceDayId = BaseUrl + "/api/\(language)/DoctorService/GetDoctorServiceSchedualByServiceDayId"



    
    
    
}

