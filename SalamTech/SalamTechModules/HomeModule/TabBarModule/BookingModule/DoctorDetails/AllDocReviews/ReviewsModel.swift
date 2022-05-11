//
//  ReviewsModel.swift
//  SalamTech
//
//  Created by wecancity on 11/05/2022.
//

import Foundation
struct ReviewsModel : Codable {
  
    let message: String?
        let messageCode: Int?
        let data: [DocReview]?
        let success: Bool?

        enum CodingKeys: String, CodingKey {
            case message = "Message"
            case messageCode = "MessageCode"
            case data = "Data"
            case success = "Success"
        }
}

// MARK: - DataClass
struct DocReview: Codable,Identifiable, Hashable{
    var id:Int?
    
    var DoctorInfo : String?
    var DoctorScheduals : [ModelSched]?
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case DoctorInfo = "DoctorInfo"
        case DoctorScheduals = "DoctorScheduals"
        
    }
}
