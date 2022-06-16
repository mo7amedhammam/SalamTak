//
//  ModelExaminationTypeId.swift
//  SalamTech
//
//  Created by Mohamed Hammam on 02/04/2022.
//

import Foundation

// MARK: - DataClass
struct ExaminationType: Codable,Identifiable, Hashable {
    
    let id: Int?
    let Name,image: String?
    let Inactive: Bool?
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case Name = "Name"
        case image = "Image"
        case Inactive = "Inactive"
    }
}
