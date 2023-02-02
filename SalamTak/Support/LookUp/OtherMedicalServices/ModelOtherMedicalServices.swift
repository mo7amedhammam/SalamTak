//
//  ModelOtherMedicalServices.swift
//  SalamTak
//
//  Created by wecancity on 30/01/2023.
//

import Foundation

// MARK: - ModelOtherMedicalServices
struct ModelOtherMedicalServices: Codable,Hashable,Identifiable {
    let id: Int?
    let logo: String?
    let healthEntityPhoneDtos: [String]?
    let cityName, areaName: String?
    let healthEntityServices: [Int]?
    let healthEntityServiceName: [String]?
    let name, nameAr, email: String?
    let countryID, cityID, areaID: Int?
    let address, latitude, longitude, blockNo: String?
    let floorNo: Int?
    let apartmentNo: String?
    let fixedFee: Int?
    let inactive: Bool?
    let medicalExaminationTypeID: Int?
    let street: String?

    enum CodingKeys: String, CodingKey {
        case id = "ClinicId"
        case logo = "Logo"
        case healthEntityPhoneDtos = "HealthEntityPhoneDtos"
        case cityName = "CityName"
        case areaName = "AreaName"
        case healthEntityServices = "HealthEntityServices"
        case healthEntityServiceName = "HealthEntityServiceName"
        case name = "Name"
        case nameAr = "NameAr"
        case email = "Email"
        case countryID = "CountryId"
        case cityID = "CityId"
        case areaID = "AreaId"
        case address = "Address"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case blockNo = "BlockNo"
        case floorNo = "FloorNo"
        case apartmentNo = "ApartmentNo"
        case fixedFee = "FixedFee"
        case inactive = "Inactive"
        case medicalExaminationTypeID = "MedicalExaminationTypeId"
        case street = "Street"
    }
}
