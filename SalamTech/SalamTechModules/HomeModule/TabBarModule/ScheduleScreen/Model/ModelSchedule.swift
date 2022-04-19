//
//  ModelGetMedicalState.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 12/04/2022.
//

import Foundation

struct ModelGetSchedule : Codable {
  
        let message: String?
        let messageCode: Int?
        let data: [AppointmentInfo]?
        let success: Bool?

        enum CodingKeys: String, CodingKey {
            case message = "Message"
            case messageCode = "MessageCode"
            case data = "Data"
            case success = "Success"
        }
}

// MARK: - DataClass
struct AppointmentInfo: Codable {
    let doctorId, medicalTypeId: Int?
    let doctorName,doctorImage,seniorityName,specialistName,medicalTypeName,appointmentDate,clinicName,clinicLatitude,clinicLongitude:String?
    let isCancel:Bool?
    
    enum CodingKeys: String, CodingKey {
       
        case doctorId = "DoctorId"
        case medicalTypeId = "MedicalExaminationTypeId"
        
        case doctorName = "DoctorName"
        case doctorImage = "DoctorImage"
        case seniorityName = "SeniorityLevelName"
        case specialistName = "SpecialistName"
        case medicalTypeName = "MedicalExaminationTypeName"
        case appointmentDate = "AppointmentDate"
        case clinicName = "ClinicName"
        case clinicLatitude = "ClinicLatitude"
        case clinicLongitude = "ClinicLongitude"
        
        case isCancel = "IsCancel"
       
    }
}
