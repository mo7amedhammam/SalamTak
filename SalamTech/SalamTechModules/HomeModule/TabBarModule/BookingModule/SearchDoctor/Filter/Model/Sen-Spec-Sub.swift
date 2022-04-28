//
//  Sen-Spec-Sub.swift
//  SalamTech
//
//  Created by wecancity on 28/04/2022.
//

import Foundation


// MARK: ------ ModelSeniorityLevel---------
struct ModelSeniorityLevel: Codable {
    let Message: String?
    let MessageCode: Int?
    let Data: [seniority]?
    let Success: Bool?

  
}

// MARK: - Datum
struct seniority: Codable {
    let id: Int?
    let Name: String?
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case Name = "Name"
    }

}


//// MARK: - ModelSpecialist
//struct ModelSpecialist: Codable {
//
//    let Message: String?
//    let MessageCode: Int?
//    let Data: [Speciality]?
//    let Success: Bool?
//
//  
//}
//
//// MARK: - Datum
//struct Speciality: Codable {
//    
//    
//    let id: Int?
//    let Name: String?
//    enum CodingKeys: String, CodingKey {
//        case id = "Id"
//        case Name = "Name"
//    }
//
//
//}



// MARK: ------ ModelSpecialist --------
struct ModelSubSpecialist: Codable {
    let Message: String?
    let MessageCode: Int?
    let Data: [subspeciality]?
    let Success: Bool?

  
}

// MARK: - Datum
struct subspeciality: Codable, Identifiable {

    let id: Int?
    let Name: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case Name = "Name"
    }

}
