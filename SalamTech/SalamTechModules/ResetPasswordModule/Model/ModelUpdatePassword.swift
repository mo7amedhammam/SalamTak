//
//  ModelUpdatePassword.swift
//  SalamTech-DR
//
//  Created by Mohamed Hammam on 03/03/2022.
//

import Foundation
// MARK: - UserData
struct UpdatePassword: Codable {
    let Id: Int?
    let Phone, Token,Name: String?
    enum CodingKeys: String, CodingKey {
        case Id = "Id"
        case Phone = "Phone"
        case Token = "Token"
        case Name = "Name"
    }
}
