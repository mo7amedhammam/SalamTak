//
//  ModelUpdatePassword.swift
//  SalamTech-DR
//
//  Created by Mostafa Morsy on 03/03/2022.
//

import Foundation
// MARK: - Create user
struct ModelUpdatePassword : Codable{
    let Message: String?
    let MessageCode: Int?
    let Data: UpdatePassword?
    let Success: Bool?
}

// MARK: - UserData
struct UpdatePassword: Codable {
    let Id: Int?
    let Phone, Token,Name: String?
}
