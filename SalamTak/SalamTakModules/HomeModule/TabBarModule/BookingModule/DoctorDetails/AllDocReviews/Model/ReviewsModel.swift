//
//  ReviewsModel.swift
//  SalamTech
//
//  Created by Mohamed Hammam on 11/05/2022.
//

import Foundation

// MARK: - DataClass
struct DocReview: Codable,Identifiable, Hashable{
    var id:Int?
    
    var DoctorInfo : String?
    var DoctorScheduals : [ModelSched]?
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case DoctorInfo = "DoctorInfo"
        case DoctorScheduals = "DoctorScheduals"
        
    }
}
