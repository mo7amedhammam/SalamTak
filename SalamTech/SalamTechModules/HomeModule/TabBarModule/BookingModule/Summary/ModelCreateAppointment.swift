//
//  ModelCreateAppointment.swift
//  SalamTech
//
//  Created by wecancity on 25/04/2022.
//

import Foundation
import SwiftUI
struct ModelCreateAppointment : Codable {
  
    let message: String?
        let messageCode: Int?
        let data: Statusmodel?
        let success: Bool?

        enum CodingKeys: String, CodingKey {
            case message = "Message"
            case messageCode = "MessageCode"
            case data = "Data"
            case success = "Success"
        }
}

// MARK: - DataClass
struct Statusmodel: Codable{
    var Statues : String?
    enum CodingKeys: String, CodingKey {
        case Statues = "Statues"
    }
}
