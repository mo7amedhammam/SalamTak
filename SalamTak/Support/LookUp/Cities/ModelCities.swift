//
//  ModelCities.swift
//  SalamTech-DR
//
//  Created by Mohamed Hammam on 27/01/2022.
//

import Foundation



// MARK: - City
struct City: Codable , Hashable {
    let Id: Int?
    let Name: String?
}


//MARK:     city by cityId
//struct ModelCitYByCityId: Codable {
//    let Message: String?
//    let MessageCode: Int?
//    let Data: CityInfo?
//    let Success: Bool?
//
//    enum CodingKeys: String, CodingKey {
//        case Message = "Message"
//        case MessageCode = "MessageCode"
//        case Data = "Data"
//        case Success = "Success"
//    }
//}

//struct CityInfo: Codable  {
//    let Id,CountryId: Int?
//    let Name,NameAr: String?
//    let CountryName: String?
//    let Inactive:Bool?
//    
//    enum CodingKeys: String, CodingKey {
//        case Id = "Message"
//        case CountryId = "CountryId"
//        case Name = "Name"
//        case NameAr = "NameAr"
//        case CountryName = "CountryName"
//        case Inactive = "Inactive"
//    }
//}

