//
//  Config.swift
//  SalamTech
//
//  Created by Mohamed Hammam on 3/29/22.
//

import Foundation
import SwiftUI

class URLs {
     static let BaseUrl = "https://salamtakapitest.azurewebsites.net"
    
    // MARK: -------- Patient ------
    var CreateUser = BaseUrl + "/api/\(Helper.getLanguage())/User/CreateUser"
     var RegisterUser = BaseUrl + "/api/\(Helper.getLanguage())/User/Register"
     var LoginUser = BaseUrl + "/api/\(Helper.getLanguage())/User/Login"
     var ResetPassword = BaseUrl + "/api/\(Helper.getLanguage())/User/ResetPassword"
     var UpdatePassword = BaseUrl + "/api/\(Helper.getLanguage())/User/UpdatePassword"
    
    /// create patient profile >> needs token
    var PatientCreateProfile = BaseUrl + "/api/\(Helper.getLanguage())/Patient/CreateProfile"
    var PatientGetProfile = BaseUrl + "/api/\(Helper.getLanguage())/Patient/GetPatient"
    var PatientUpdateProfile = BaseUrl + "/api/\(Helper.getLanguage())/Patient/UpdateProfile"

    var PatientCreateMedicalInfo = BaseUrl + "/api/\(Helper.getLanguage())/Patient/CreatePatientMedicallInfo"
    var PatientGetMedicalInfo = BaseUrl + "/api/\(Helper.getLanguage())/Patient/GetPatientMedicalInfo"
    var PatientUpdateMedicalInfo = BaseUrl + "/api/\(Helper.getLanguage())/Patient/UpdatePatientMedicalInfo"

    var GetBloodTypes = BaseUrl + "/api/\(Helper.getLanguage())/PatientLookUp/GetBloodTypes"
    var GetMedicineAllergy = BaseUrl + "/api/\(Helper.getLanguage())/PatientLookUp/GetMedicineAllergy"
    var GetFoodAllergy = BaseUrl + "/api/\(Helper.getLanguage())/PatientLookUp/GetFoodAllergy"
    var GetOccupation = BaseUrl + "/api/\(Helper.getLanguage())/LookUp/GetOccupation"
    var GetSeniorityLevel = BaseUrl + "/api/\(Helper.getLanguage())/SeniorityLevel/GetSeniorityLevel"
    var GetSpecialist = BaseUrl + "/api/\(Helper.getLanguage())/Specialist/GetSpecialist"
    var GetSubSpecialist = BaseUrl + "/api/\(Helper.getLanguage())/Specialist/GetSubSpecialist"
    var GetCountries = BaseUrl + "/api/\(Helper.getLanguage())/LookUp/GetCountries"
    var GetCities = BaseUrl + "/api/\(Helper.getLanguage())/City/GetCities"
    var GetCityById = BaseUrl + "/api/\(Helper.getLanguage())/City/GetCityById"
    var GetAreas = BaseUrl + "/api/\(Helper.getLanguage())/Area/GetAreasByCityId"
    var GetAreanameByAreaId = BaseUrl + "/api/\(Helper.getLanguage())/Area/GetAreaById"
    var GetDays = BaseUrl + "/api/\(Helper.getLanguage())/LookUp/GetDays"
    var GetDuration = BaseUrl + "/api/\(Helper.getLanguage())/LookUp/GetDurationMedicalExamination"
    var Getservices = BaseUrl + "/api/\(Helper.getLanguage())/Services/GetServices"
    var GetMedicalExaminationType = BaseUrl + "/api/\(Helper.getLanguage())/LookUp/GetMedicalExaminationType"
    
    //search Doctor
    var DoctorSearch = BaseUrl + "/api/\(Helper.getLanguage())/DoctorSearch/DoctorSearch"
    var DoctorDetails = BaseUrl + "/api/\(Helper.getLanguage())/DoctorSearch/GetDoctorDetail"
    var FilteredFees = BaseUrl + "/api/\(Helper.getLanguage())/DoctorSearch/FilteredFees"

    //Doctor Rate
    var CreateDoctorRate = BaseUrl + "/api/\(Helper.getLanguage())/DoctorRate/CreateDoctorRate"
    var DoctorRate = BaseUrl + "/api/\(Helper.getLanguage())/DoctorRate/GetDoctorReviews"

    //Create appointment
    var CreatePatientAppointment = BaseUrl + "/api/\(Helper.getLanguage())/Patient/CreatePatientAppointment"
    var GetPatientAppointment =  BaseUrl + "/api/\(Helper.getLanguage())/PatientAppointment/GetPatientAppointmentes"
    var CancelAppointmen = BaseUrl + "/api/\(Helper.getLanguage())/DoctorAppointment/CancelAppointment"

    var TermsAndConditionsURL =  "https://salamtechfront.azurewebsites.net/Terms"

    
}
