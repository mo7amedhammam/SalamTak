//
//  ModelOccupation.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 04/04/2022.
//

import Foundation


// MARK: - ModelSeniorityLevel
struct ModelFoodAllergy: Codable {
    
    
    let Message: String?
    let MessageCode: Int?
    let Data: [FoodAllergy]?
    let Success: Bool?

  
}

// MARK: - Country
struct FoodAllergy: Codable, Identifiable {
    let id: Int?
    let Name: String?
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case Name = "Name"
    }
//    let check:Bool = false
}
