//
//  ModelSearchDoc.swift
//  SalamTech
//
//  Created by wecancity on 05/04/2022.
//

import Foundation

struct ModelSearchDoc : Codable {
  
    let message: String?
        let messageCode: Int?
        let data: ModelDoc?
        let success: Bool?

        enum CodingKeys: String, CodingKey {
            case message = "Message"
            case messageCode = "MessageCode"
            case data = "Data"
            case success = "Success"
        }
}

struct ModelDoc:Codable{
    var TotalCount: Int?
    var Items: [Doc]?
    enum CodingKeys: String, CodingKey {
        case TotalCount = "TotalCount"
        case Items = "Items"
    }
    
}


// MARK: - DataClass
struct Doc: Codable, Identifiable , Hashable{
    
    var id, SumRate, Rate, NumVisites, WaitingTime: Int?
    var Fees:Double?
    var DoctorName, SpecialistName, SeniortyLevelName, ClinicAddress, Image: String?
    var SubSpecialistName: [String]?
   
  
    enum CodingKeys: String, CodingKey {
        case id = "DoctorId"
        case Fees = "Fees"
        case SumRate = "SumRate"
        case Rate = "Rate"
        case NumVisites = "NumVisites"
        case WaitingTime = "WaitingTime"
        case DoctorName = "DoctorName"
        case SpecialistName = "SpecialistName"
        case SeniortyLevelName = "SeniortyLevelName"
        case ClinicAddress = "ClinicAddress"
        case Image = "Image"
        case SubSpecialistName = "SubSpecialistName"

        
    }
}
