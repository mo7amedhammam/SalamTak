//
//  ModelLogin.swift
//  Salamtech-Dr
//
//  Created by Mohamed Hammam on 06/01/2022.
//

import Foundation

// MARK: - DataClass
struct LoginModel: Codable {
    let Id,ProfileStatus: Int?
    let Name,Image, Phone, Token: String?
}
