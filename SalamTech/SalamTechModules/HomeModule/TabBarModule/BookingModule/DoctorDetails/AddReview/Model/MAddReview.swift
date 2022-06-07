//
//  MAddReview.swift
//  SalamTech
//
//  Created by Mohamed Hammam on 18/05/2022.
//

import Foundation

// MARK: - DataClass
struct rateSt: Codable{
    var Statues : String?
    enum CodingKeys: String, CodingKey {
        case Statues = "Statues"
    }
}



