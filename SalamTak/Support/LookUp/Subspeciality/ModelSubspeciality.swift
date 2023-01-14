//
//  ModelSubspeciality.swift
//  SalamTak
//
//  Created by Mohamed Hammam on 06/06/2022.
//

import Foundation

// MARK: - Datum
struct subspeciality: Codable, Identifiable , Hashable{

    let id: Int?
    let Name: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case Name = "Name"
    }

}
