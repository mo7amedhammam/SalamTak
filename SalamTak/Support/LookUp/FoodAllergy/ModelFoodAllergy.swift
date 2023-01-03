//
//  ModelOccupation.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 04/04/2022.
//

import Foundation

// MARK: - Country
struct FoodAllergy: Codable, Identifiable,Hashable {
    let id: Int?
    let Name: String?
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case Name = "Name"
    }
}
