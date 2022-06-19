//
//  ModelCreateUser.swift
//  Salamtech-Dr
//
//  Created by wecancity on 08/01/2022.
//

import Foundation

// MARK: - UserData
struct CreateUserModel: Codable {
    let Id: Int?
    let Phone, Token, Image: String?
}
