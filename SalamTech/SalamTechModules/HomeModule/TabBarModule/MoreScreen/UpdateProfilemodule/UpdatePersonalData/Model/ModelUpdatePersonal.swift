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
        let image,firstName,middleName,familyName,firstNameAr,middleNameAr,familyNameAr,emergencyContact,birthdate,address,longitude,latitude,apartNo,blockNo,nationalityName,cityName,areaName:String?

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
            case nationalityName = "NationalityName"
            case cityName = "CityName"
            case areaName = "AreaName"
        }
        init(){
            self.id = 0
            self.image = "Image"
            self.firstName = "FirstName"
            self.firstNameAr = "FirstNameAr"
            self.genderId = 0
            self.occupationId = 0
            self.nationalityId = 0
            self.countryId = 0
            self.cityId = 0
            self.areaId = 0
            self.floorNo = 0
            self.middleName = "MiddelName"
            self.familyName = "FamilyName"
            self.middleNameAr = "MiddelNameAr"
            self.familyNameAr = "FamilyNameAr"
            self.emergencyContact = "EmergencyContact"
            self.birthdate = "Birthdate"
            self.address = "Address"
            self.longitude = "Longitude"
            self.latitude = "Latitude"
            self.apartNo = "ApartmentNo"
            self.blockNo = "BlockNo"
            self.nationalityName = "NationalityName"
            self.cityName = "CityName"
            self.areaName = "AreaName"
        }
    }

