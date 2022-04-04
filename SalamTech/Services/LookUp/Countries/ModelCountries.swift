//
//  ModelCountries.swift
//  SalamTech-DR
//
//  Created by wecancity on 16/01/2022.
//

import Foundation


// MARK: - ModelSeniorityLevel
struct ModelCountries: Codable {
    
    
    let Message: String?
    let MessageCode: Int?
    let Data: [Country]?
    let Success: Bool?

  
}

// MARK: - Country
struct Country: Codable , Hashable {
    let Id: Int?
    let Name: String?
//    let check:Bool = false
}
