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
struct Doc: Codable, Identifiable, Hashable{
    
    // Satisfy Hashable requirement
      var hashValue: Int {
          get {
              return id?.hashValue ?? 0115151551
          }
      }
    static func == (lhs: Doc, rhs: Doc) -> Bool {
        return lhs.id == rhs.id

    }

    var id, ClinicId, SumRate,  NumVisites, WaitingTime: Int?
    var FeesFrom, Rate, FeesTo :Double?
    var DoctorName, SpecialistName, SeniortyLevelName, ClinicName, ClinicAddress, Image,AvailableFrom: String?
    var SubSpecialistName: [String]?
    var MedicalExamationTypeImage: [Img]?
    var DoctorRate : [DoctorRate]?
  
    enum CodingKeys: String, CodingKey {
        case id = "DoctorId"
        case ClinicId = "ClinicId"
        case SumRate = "SumRate"
        case Rate = "Rate"
        case NumVisites = "NumVisites"
        case WaitingTime = "WaitingTime"
        
        case FeesFrom = "FeesFrom"
        case FeesTo = "FeesTo"
        
        case DoctorName = "DoctorName"
        case SpecialistName = "SpecialistName"
        case SeniortyLevelName = "SeniortyLevelName"
        case ClinicName = "ClinicName"
        case ClinicAddress = "ClinicAddress"
        case Image = "Image"
        case AvailableFrom = "AvailableFrom"
        case SubSpecialistName = "SubSpecialistName"
        case MedicalExamationTypeImage = "MedicalExamationTypes"
        case DoctorRate = "DoctorRate"

    }
}


struct Img:Codable,Identifiable, Hashable{
    
    var id :Int?
    var Name,Image: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case Name = "Name"
        case Image = "Image"

    }
    
}

struct DoctorRate:Codable,Identifiable, Hashable{
    var id,Rate :Int?
    var PatientName,Comment,StatueName:String?
    enum CodingKeys: String, CodingKey {
        case id = "RateId"
        case Rate = "Rate"
        case PatientName = "PatientName"
        case Comment = "Comment"
        case StatueName = "StatueName"
        
    }
}
