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
struct MedicineAllergy: Codable , Hashable {
    let Id: Int?
    let Name: String?
//    let check:Bool = false
}
