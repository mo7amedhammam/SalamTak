//
//  ModelAppointmentInfo.swift
//  SalamTak
//
//  Created by wecancity on 05/02/2023.
//
import Foundation

// MARK: - DataClass
struct AppointmentInfo: Codable,Identifiable , Hashable {
    var id,medicalTypeId,DoctorId:Int?
    var doctorName,doctorImage,seniorityName,specialistName,
        medicalTypeName,appointmentDate,clinicName,clinicLatitude,
        clinicLongitude:String?
    var isCancel,canRate:Bool?
    
    enum CodingKeys:String, CodingKey {
        case id = "AppointmentId"
        case DoctorId = "DoctorId"
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
