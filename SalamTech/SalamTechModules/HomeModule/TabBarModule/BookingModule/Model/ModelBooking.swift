//
//  ModelBooking.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 31/03/2022.
//
//
//  ModelDashBoard.swift
//  SalamTech-DR
//
//  Created by Mostafa Morsy on 03/03/2022.
//

import Foundation
struct ModelDashboard : Codable {
  
    let message: String?
        let messageCode: Int?
        let data: DoctorDashboard
        let success: Bool?

        enum CodingKeys: String, CodingKey {
            case message = "Message"
            case messageCode = "MessageCode"
            case data = "Data"
            case success = "Success"
        }
}

// MARK: - DataClass
struct DoctorDashboard: Codable{
    
    let totalAppointmentCount,upcomingAppointmentCount,todayAppointmentCount: Int?
    var getMedicalExaminationDots:[MedicalExamination]?
    
    enum CodingKeys: String, CodingKey {
        case totalAppointmentCount = "TotalAppointmentCount"
        case upcomingAppointmentCount = "UpComingAppointmentCount"
        case todayAppointmentCount = "TodayAppointmentCount"
        case getMedicalExaminationDots = "getMedicalEximationListDtos"
        
    }
}

struct MedicalExamination: Codable,Identifiable{
    let id = UUID()
    let medicalTypeCount: Int?
    var medicalTypeName:String?
    
    enum CodingKeys: String, CodingKey {
        case medicalTypeCount = "MedicalTypeCount"
        case medicalTypeName = "MedicalTypeName"
       
        
    }
}


