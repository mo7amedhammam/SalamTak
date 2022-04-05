//
//  ModelOccupation.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 04/04/2022.
//

import Foundation


// MARK: - ModelSeniorityLevel
struct ModelMedicineAllergy: Codable {
    
    
    let Message: String?
    let MessageCode: Int?
    let Data: [MedicineAllergy]?
    let Success: Bool?

  
}

// MARK: - Country
struct MedicineAllergy: Codable ,Identifiable {
    let id: Int?
    let Name: String?
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case Name = "Name"
    }
//    let check:Bool = false
}
