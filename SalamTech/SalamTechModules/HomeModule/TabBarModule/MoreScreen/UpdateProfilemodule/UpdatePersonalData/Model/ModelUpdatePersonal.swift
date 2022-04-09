//
//  ModelPersonal.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 31/03/2022.
//


import Foundation

    struct ModelUpdatePatientProfile : Codable {
      
        let message: String?
            let messageCode: Int?
            let data: Patient?
            let success: Bool?

            enum CodingKeys: String, CodingKey {
                case message = "Message"
                case messageCode = "MessageCode"
                case data = "Data"
                case success = "Success"
            }
    }

    // MARK: - DataClass
    struct Patient: Codable {
        let id, genderId,occupationId,nationalityId,countryId,cityId,areaId,floorNo: Int?
        let image,firstName,middleName,familyName,firstNameAr,middleNameAr,familyNameAr,emergencyContact,birthdate,address,longitude,latitude,apartNo,blockNo:String?

        enum CodingKeys: String, CodingKey {
            case id = "Id"
            case image = "Image"
            case firstName = "FirstName"
            case firstNameAr = "FirstNameAr"
            case genderId = "GenderId"
            case occupationId = "OccupationId"
            case nationalityId = "NationalityId"
            case countryId = "CountryId"
            case cityId = "CityId"
            case areaId = "AreaId"
            case floorNo = "FloorNo"
            case middleName = "MiddelName"
            case familyName = "FamilyName"
            case middleNameAr = "MiddelNameAr"
            case familyNameAr = "FamilyNameAr"
            case emergencyContact = "EmergencyContact"
            case birthdate = "Birthdate"
            case address = "Address"
            case longitude = "Longitude"
            case latitude = "Latitude"
            case apartNo = "ApartmentNo"
            case blockNo = "BlockNo"
        }
    }

