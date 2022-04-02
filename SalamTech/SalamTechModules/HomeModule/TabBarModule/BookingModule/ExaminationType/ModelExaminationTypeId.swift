//
//  ModelExaminationTypeId.swift
//  SalamTech
//
//  Created by wecancity on 02/04/2022.
//

import Foundation

struct ModelExaminationTypeId : Codable {
  
    let message: String?
        let messageCode: Int?
        let data: [ExaminationType]?
        let success: Bool?

        enum CodingKeys: String, CodingKey {
            case message = "Message"
            case messageCode = "MessageCode"
            case data = "Data"
            case success = "Success"
        }
}

// MARK: - DataClass
struct ExaminationType: Codable,Identifiable {
    
    let id: Int?
    let Name: String?
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case Name = "Name"
    }
}
