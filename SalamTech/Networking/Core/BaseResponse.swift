//
//  BaseResponse.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 01/06/2022.
//

import Foundation

struct BaseResponse<T:Codable> : Codable {
        let message: String?
        let messageCode: Int?
        let data: T?
        let success: Bool?

        enum CodingKeys: String, CodingKey {
            case message = "Message"
            case messageCode = "MessageCode"
            case data = "Data"
            case success = "Success"
        }    
    
    init() {
        self.message = ""
        self.messageCode = 0
        self.success = false
        self.data = T.self as? T
    }
}
