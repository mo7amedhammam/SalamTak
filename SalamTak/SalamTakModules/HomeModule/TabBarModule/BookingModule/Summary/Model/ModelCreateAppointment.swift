//
//  ModelCreateAppointment.swift
//  SalamTech
//
//  Created by Mohamed Hammam on 25/04/2022.
//

import Foundation
import SwiftUI

// MARK: - DataClass
struct ModelCreateAppointment: Codable{
    var DoctorName,PatientName,PatientNumber,HealthentityName,AppointmentDate,HealthentityAddress : String?
    var Fees, DurationMedicalExaminationId : Int?
    var HealthEntityPhoneDtos:[String]?
    
    enum CodingKeys: String, CodingKey {
        case DoctorName = "DoctorName"
        case PatientName = "PatientName"
        case PatientNumber = "PatientNumber"
        case HealthentityName = "HealthentityName"
        case AppointmentDate = "AppointmentDate"
        case HealthentityAddress = "HealthentityAddress"
        case Fees = "Fees"
        case DurationMedicalExaminationId = "DurationMedicalExaminationId"
        case HealthEntityPhoneDtos = "HealthEntityPhoneDtos"
    }
}
