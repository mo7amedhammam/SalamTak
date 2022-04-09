//
//  ModelResetPassword.swift
//  SalamTech-DR
//
//  Created by Mostafa Morsy on 03/03/2022.
//

import Foundation
struct ModelResetPassword : Codable {
  
        let message: String?
        let messageCode: Int?
        let data: ResetPassword?
        let success: Bool?

        enum CodingKeys: String, CodingKey {
            case message = "Message"
            case messageCode = "MessageCode"
            case data = "Data"
            case success = "Success"
        }
}

// MARK: - DataClass
struct ResetPassword: Codable {
    let code, userId, resendCounter: Int?

    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case userId = "UserId"
        case resendCounter = "ReSendCounter"
    }
}
