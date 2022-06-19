//
//  ModelArea.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 04/04/2022.
//

import Foundation

// MARK: - ModelSeniorityLevel
struct ModelAreas: Codable {
    
    
    let Message: String?
    let MessageCode: Int?
    let Data: [Area]?
    let Success: Bool?

  
}

// MARK: - Country
struct Area: Codable , Identifiable, Hashable {

    var id: Int?
    var Name: String?
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case Name = "Name"
    }}
