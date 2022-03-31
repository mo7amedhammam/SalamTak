//
//  ModelLogin.swift
//  Salamtech-Dr
//
//  Created by Mohamed Hammam on 06/01/2022.
//

import Foundation

// MARK: - ModelLogin
struct ModelLogin: Codable {
    let Message: String?
    let MessageCode: Int?
    let Data: DataClass?
    let Success: Bool?
}

// MARK: - DataClass
struct DataClass: Codable {
    let Id,ProfileStatus: Int?
    let Name,Image, Phone, Token: String?
}
