//
//  ModelPersonal.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 31/03/2022.
//


import Foundation

    struct ModelCreateMedicalState : Codable {
      
            let message: String?
            let messageCode: Int?
            let data: MedicalInfo?
            let success: Bool?

            enum CodingKeys: String, CodingKey {
                case message = "Message"
                case messageCode = "MessageCode"
                case data = "Data"
                case success = "Success"
            }
    }

    // MARK: - DataClass
    struct MedicalInfo: Codable {
        let height, weight,id,bloodTypeId,patientId: Int?
        let pressure,sugarLevel:String?
//        let otherAllergyies,prescriptions, currentMedication,pastMedication,chronicDiseases,injuires,surgries:String?
//        let PatientFoodAllergiesDto:[Int]
//        let PatientMedicineAllergiesDto:[Int]
        
        enum CodingKeys: String, CodingKey {
           
            case height = "Height"
            case weight = "Weight"
            case bloodTypeId = "BloodTypeId"
            
            case pressure = "Pressure"
            case sugarLevel = "SugarLevel"
//            case otherAllergyies = "OtherAllergies"
//            case prescriptions = "Prescriptions"
//            case currentMedication = "CurrentMedication"
//            case pastMedication = "PastMedication"
//            case chronicDiseases = "ChronicDiseases"
//            case injuires = "Iinjuries"
//            case surgries = "Surgeries"
            
//            case PatientFoodAllergiesDto = "PatientFoodAllergiesDto"
//            case PatientMedicineAllergiesDto = "PatientMedicineAllergiesDto"
            
            case id = "Id"
            case patientId = "PatientId"
           
        }
    }

//{
//  "Height": 0,
//  "Weight": 0,
//  "Pressure": "string",
//  "SugarLevel": "string",
//  "BloodTypeId": 0,
//  "OtherAllergies": "string",
//  "Prescriptions": "string",
//  "CurrentMedication": "string",
//  "PastMedication": "string",
//  "ChronicDiseases": "string",
//  "Iinjuries": "string",
//  "Surgeries": "string",
//  "PatientFoodAllergiesDto": [
//    0
//  ],
//  "PatientMedicineAllergiesDto": [
//    0
//  ],
//  "Id": 0,
//  "PatientId": 0
//}

//{
//  "Message": "Success",
//  "MessageCode": 200,
//  "Data": {
//    "Id": 36,
//    "PatientId": 85,
//    "Height": 12,
//    "Weight": 12,
//    "Pressure": "string",
//    "SugarLevel": "string",
//    "BloodTypeId": 1,
//    "OtherAllergies": "string",
//    "Prescriptions": "string",
//    "CurrentMedication": "string",
//    "PastMedication": "string",
//    "ChronicDiseases": "string",
//    "Iinjuries": "string",
//    "Surgeries": "string",
//    "PatientFoodAllergiesDto": null,
//    "PatientMedicineAllergiesDto": null
//  },
//  "Success": true
