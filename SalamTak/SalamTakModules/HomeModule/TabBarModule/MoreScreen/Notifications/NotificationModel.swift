//
//  Model.swift
//  SalamTak
//
//  Created by wecancity on 05/01/2023.
//


import Foundation


// MARK: - NotificationCount
struct NotificationCount: Codable {
    let NewNotificationCount: Int?


    enum CodingKeys: String, CodingKey {
        case NewNotificationCount = "NewNotificationCount"
    }
}


// MARK: - NotificationModel
struct NotificationModel: Codable , Identifiable, Hashable{
    let id, doctorID: Int?
    let doctorName, doctorImage, seniorityLevelName, specialistName: String?
    let medicalExaminationTypeID: Int?
    let medicalExaminationTypeName, appointmentDate, clinicName, clinicLatitude: String?
    let clinicLongitude: String?
    let isCancel, isSeen, canRate: Bool?

    enum CodingKeys: String, CodingKey {
        case id = "AppointmentId"
        case doctorID = "DoctorId"
        case doctorName = "DoctorName"
        case doctorImage = "DoctorImage"
        case seniorityLevelName = "SeniorityLevelName"
        case specialistName = "SpecialistName"
        case medicalExaminationTypeID = "MedicalExaminationTypeId"
        case medicalExaminationTypeName = "MedicalExaminationTypeName"
        case appointmentDate = "AppointmentDate"
        case clinicName = "ClinicName"
        case clinicLatitude = "ClinicLatitude"
        case clinicLongitude = "ClinicLongitude"
        case isCancel = "IsCancel"
        case isSeen = "IsSeen"
        case canRate = "CanRate"
    }
}
