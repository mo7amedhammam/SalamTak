//
//  ModelGetMedicalState.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 12/04/2022.
//

import Foundation

// MARK: - DataClass
struct AppointmentInfo: Codable,Identifiable , Hashable {
    var id,medicalTypeId:Int?
    var doctorName,doctorImage,seniorityName,specialistName,
        medicalTypeName,appointmentDate,clinicName,clinicLatitude,
        clinicLongitude:String?
    var isCancel,canRate:Bool?
    
    enum CodingKeys:String, CodingKey {
       
        case id = "DoctorId"
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
        case canRate = "CanRate"

    }
}



//MARK: Cancel appointment

struct CancelBody: Codable {
    let Statues: Bool?

    enum CodingKeys: String, CodingKey {
        case Statues = "Statues"
    }
}
