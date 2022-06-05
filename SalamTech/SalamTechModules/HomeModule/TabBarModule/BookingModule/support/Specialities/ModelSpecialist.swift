//
//  ModelSpecialist.swift
//  SalamTech
//
//  Created by Mohamed hammam on 02/04/2022.
//


import Foundation

// MARK: - Datum
struct Speciality: Codable ,Identifiable, Hashable {
    let id: Int?
    let Name,image: String?
    let Inactive: Bool?
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case Name = "Name"
        case image = "Image"
        case Inactive = "Inactive"
    }
    init(){
        self.id = 0
        self.Name = ""
        self.image = ""
        self.Inactive = false
    }
}
