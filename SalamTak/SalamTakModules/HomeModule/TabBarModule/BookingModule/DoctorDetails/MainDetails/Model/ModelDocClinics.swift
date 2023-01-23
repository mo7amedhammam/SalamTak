//
//  ModelDocClinics.swift
//  SalamTak
//
//  Created by wecancity on 23/01/2023.
//

import Foundation
//import Alamofire

// MARK: - ModelDocClinics
struct ModelDocClinics: Codable {
    let clinicID: Int?
    let name, logo, address, areaName: String?
    let cityName: String?
    let fixedFee: Int?
    let blockNo: String?
    let floorNo: Int?
    let apartmentNo: String?
    let email: String?
    let healthEntityPhoneDtos: [String]?
    let schedule: [Schedule]?

    enum CodingKeys: String, CodingKey {
        case clinicID = "ClinicId"
        case name = "Name"
        case logo = "Logo"
        case address = "Address"
        case areaName = "AreaName"
        case cityName = "CityName"
        case fixedFee = "FixedFee"
        case blockNo = "BlockNo"
        case floorNo = "FloorNo"
        case apartmentNo = "ApartmentNo"
        case email = "Email"
        case healthEntityPhoneDtos = "HealthEntityPhoneDtos"
        case schedule = "Schedule"
    }
}

// MARK: - Schedule
struct Schedule: Codable {
    let dayName: String?
    let schedualID: Int?
    let medicalExaminationTypeName, medicalExaminationTypeImage: String?
    let dayID: Int?
    let timeFrom, timeTo: String?
    let fees: Int?
    let followUpFees, durationMedicalExaminationID: Int?
    let inactive, overlapApproved: Bool?
    let maxNoOfPatients: Int?
    let medicalExaminationTypeID: Int?

    enum CodingKeys: String, CodingKey {
        case dayName = "DayName"
        case schedualID = "SchedualId"
        case medicalExaminationTypeName = "MedicalExaminationTypeName"
        case medicalExaminationTypeImage = "MedicalExaminationTypeImage"
        case dayID = "DayId"
        case timeFrom = "TimeFrom"
        case timeTo = "TimeTo"
        case fees = "Fees"
        case followUpFees = "FollowUp_Fees"
        case durationMedicalExaminationID = "DurationMedicalExaminationId"
        case inactive = "Inactive"
        case overlapApproved = "OverlapApproved"
        case maxNoOfPatients = "MaxNoOfPatients"
        case medicalExaminationTypeID = "MedicalExaminationTypeId"
    }
}
