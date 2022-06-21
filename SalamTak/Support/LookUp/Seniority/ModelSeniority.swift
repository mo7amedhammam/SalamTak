//
//  ModelSeniority.swift
//  SalamTak
//
//  Created by wecancity on 06/06/2022.
//

import Foundation

// MARK: - Datum
struct seniority: Codable, Hashable {
    let id: Int?
    let Name: String?
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case Name = "Name"
    }

}
