//
//  ModelDocDetails.swift
//  SalamTech
//
//  Created by Mohamed Hammam on 18/04/2022.
//


import Foundation
import SwiftUI

// MARK: - DataClass
struct DocDetails: Codable{
    var DoctorInfo : String?
    var DoctorScheduals : [ModelSched]?
    enum CodingKeys: String, CodingKey {
        case DoctorInfo = "DoctorInfo"
        case DoctorScheduals = "DoctorScheduals"
        
    }
}

struct ModelSched: Codable,Identifiable, Hashable{
    
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
    
    static func == (lhs: ModelSched, rhs: ModelSched) -> Bool {
            lhs.id == rhs.id
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
}



struct Sched: Codable, Hashable, Identifiable{
    var id :Int?
    var SlotTime: String?
    var IsAvailable:Bool?
    
    enum CodingKeys: String, CodingKey {
        case id = "SlotId"
        case SlotTime = "SlotTime"
        case IsAvailable = "IsAvailable"
    }
    
    static func == (lhs: Sched, rhs: Sched) -> Bool {
            lhs.id == rhs.id
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
}
