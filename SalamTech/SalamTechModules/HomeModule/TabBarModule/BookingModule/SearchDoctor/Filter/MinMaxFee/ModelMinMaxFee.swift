//
//  ModelMinMaxFee.swift
//  SalamTech
//
//  Created by wecancity on 11/05/2022.
//

import Foundation
struct ModelMinMaxFee : Codable {
  
    let message: String?
        let messageCode: Int?
        let data: MinMaxFee?
        let success: Bool?

        enum CodingKeys: String, CodingKey {
            case message = "Message"
            case messageCode = "MessageCode"
            case data = "Data"
            case success = "Success"
        }
}

struct MinMaxFee:Codable{
    var MinimumFees,MaximumFees: Int?
    enum CodingKeys: String, CodingKey {
        case MinimumFees = "MinimumFees"
        case MaximumFees = "MaximumFees"
    }
    
}
