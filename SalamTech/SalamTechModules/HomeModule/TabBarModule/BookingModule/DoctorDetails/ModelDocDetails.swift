//
//  ModelDocDetails.swift
//  SalamTech
//
//  Created by wecancity on 18/04/2022.
//


import Foundation
import SwiftUI
struct ModelDocDetails : Codable {
  
    let message: String?
        let messageCode: Int?
        let data: DocDetails?
        let success: Bool?

        enum CodingKeys: String, CodingKey {
            case message = "Message"
            case messageCode = "MessageCode"
            case data = "Data"
            case success = "Success"
        }
}

// MARK: - DataClass
struct DocDetails: Codable{
    var DoctorInfo : String?
    var DoctorScheduals : [ModelSched]?
    enum CodingKeys: String, CodingKey {
        case DoctorInfo = "DoctorInfo"
        case DoctorScheduals = "DoctorScheduals"
        
    }
}

struct ModelSched: Codable,Identifiable{
    
    var id,Fees: Int?
    var TimeFrom, TimeTo:String?
    var DoctorSchedualSlots :[Sched]?
    
    enum CodingKeys: String, CodingKey {
        case id = "ScheduleId"
        case Fees = "Fees"
        case TimeFrom = "TimeFrom"
        case TimeTo = "TimeTo"
        case DoctorSchedualSlots = "DoctorSchedualSlots"
        
    }
}



struct Sched: Codable, Hashable{
    
    var SlotTime: String?
    var IsAvailable:Bool?
    
    enum CodingKeys: String, CodingKey {
        case SlotTime = "SlotTime"
        case IsAvailable = "IsAvailable"
    }
}
