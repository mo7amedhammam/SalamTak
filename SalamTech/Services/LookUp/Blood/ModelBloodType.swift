//
//  ModelOccupation.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 04/04/2022.
//

import Foundation


// MARK: - ModelSeniorityLevel
struct ModelBloodType: Codable {
    
    
    let Message: String?
    let MessageCode: Int?
    let Data: [BloodTYpe]?
    let Success: Bool?

  
}

// MARK: - Country
struct BloodTYpe: Codable , Hashable {
    let Id: Int?
    let Name: String?
//    let check:Bool = false
}
