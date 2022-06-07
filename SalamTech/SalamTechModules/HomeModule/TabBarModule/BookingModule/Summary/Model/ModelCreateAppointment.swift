//
//  ModelCreateAppointment.swift
//  SalamTech
//
//  Created by wecancity on 25/04/2022.
//

import Foundation
import SwiftUI

// MARK: - DataClass
struct Statusmodel: Codable{
    var Statues : String?
    enum CodingKeys: String, CodingKey {
        case Statues = "Statues"
    }
}
