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
struct FoodAllergy: Codable , Hashable {
    let Id: Int?
    let Name: String?
//    let check:Bool = false
}
