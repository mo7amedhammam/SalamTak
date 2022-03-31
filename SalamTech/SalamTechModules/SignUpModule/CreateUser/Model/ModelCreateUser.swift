//
//  ModelCreateUser.swift
//  Salamtech-Dr
//
//  Created by wecancity on 08/01/2022.
//

import Foundation


// MARK: - Create user
struct ModelCreateUser : Codable{
    let Message: String?
    let MessageCode: Int?
    let Data: UserData?
    let Success: Bool?
}

// MARK: - UserData
struct UserData: Codable {
    let Id: Int?
    let Phone, Token, Image: String?
}



//passing Data for creating User
struct createUserWith {
    var name: String
    var email: String
    var Phone: String
    var password: String
    var OTP :Int
}

