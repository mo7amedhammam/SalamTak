//
//  MAddReview.swift
//  SalamTech
//
//  Created by wecancity on 18/05/2022.
//

import Foundation

struct MAddReview : Codable {
  
    let message: String?
        let messageCode: Int?
        let data: rateSt?
        let success: Bool?

        enum CodingKeys: String, CodingKey {
            case message = "Message"
            case messageCode = "MessageCode"
            case data = "Data"
            case success = "Success"
        }
}

// MARK: - DataClass
struct rateSt: Codable{
    var Statues : String?
    enum CodingKeys: String, CodingKey {
        case Statues = "Statues"
    }
}



