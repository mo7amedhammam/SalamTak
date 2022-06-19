//
//  ModelResetPassword.swift
//  SalamTech-DR
//
//  Created by Mohamed Hammam on 03/03/2022.
//

import Foundation
// MARK: - DataClass
struct ResetPassword: Codable {
    let code, userId, resendCounter: Int?
    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case userId = "UserId"
        case resendCounter = "ReSendCounter"
    }
}
