//
//  ModelMinMaxFee.swift
//  SalamTech
//
//  Created by wecancity on 11/05/2022.
//

import Foundation

struct MinMaxFee:Codable{
    var MinimumFees,MaximumFees: Int?
    enum CodingKeys: String, CodingKey {
        case MinimumFees = "MinimumFees"
        case MaximumFees = "MaximumFees"
    }
    
}
