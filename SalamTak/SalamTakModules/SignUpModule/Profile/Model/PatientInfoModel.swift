//
//  PatientInfoModel.swift
//  SalamTak
//
//  Created by wecancity on 29/12/2022.
//

import Foundation
//MARK: ---- get patient info


// MARK: - PatientInfoModel
struct PatientInfoModel: Codable {
    var firstName, firstNameAr, middelName, middelNameAr: String?
    var familyName, familyNameAr, emergencyContact: String?
    var genderID, occupationID, nationalityID: Int?
    var birthdate: String?
    var countryID, cityID, areaID: Int?
    var address, latitude, longitude, blockNo: String?
    var floorNo: Int?
    var apartmentNo: String?
    var id: Int?
    var image, nationalityName, countryName, cityName: String?
    var areaName, occupationName: String?

    enum CodingKeys: String, CodingKey {
        case firstName = "FirstName"
        case firstNameAr = "FirstNameAr"
        case middelName = "MiddelName"
        case middelNameAr = "MiddelNameAr"
        case familyName = "FamilyName"
        case familyNameAr = "FamilyNameAr"
        case emergencyContact = "EmergencyContact"
        case genderID = "GenderId"
        case occupationID = "OccupationId"
        case nationalityID = "NationalityId"
        case birthdate = "Birthdate"
        case countryID = "CountryId"
        case cityID = "CityId"
        case areaID = "AreaId"
        case address = "Address"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case blockNo = "BlockNo"
        case floorNo = "FloorNo"
        case apartmentNo = "ApartmentNo"
        case id = "Id"
        case image = "Image"
        case nationalityName = "NationalityName"
        case countryName = "CountryName"
        case cityName = "CityName"
        case areaName = "AreaName"
        case occupationName = "OccupationName"
    }
}


// MARK: - CreatePatientInfoModel
struct CreatePatientInfoModel: Codable {
    var id, profileStatus: Int?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case profileStatus = "ProfileStatus"
    }
}

