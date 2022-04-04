//
//  ModelSpecialist.swift
//  SalamTech
//
//  Created by wecancity on 02/04/2022.
//


import Foundation


// MARK: - ModelSpecialist
struct ModelSpecialist: Codable {
    let Message: String?
    let MessageCode: Int?
    let Data: [Speciality]?
    let Success: Bool?
  
    enum CodingKeys: String, CodingKey {
        case Message = "Message"
        case MessageCode = "MessageCode"
        case Data = "Data"
        case Success = "Success"

    }
}

// MARK: - Datum
struct Speciality: Codable ,Identifiable {
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
