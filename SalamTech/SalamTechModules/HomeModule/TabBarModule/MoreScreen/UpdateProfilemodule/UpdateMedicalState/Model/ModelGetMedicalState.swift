//
//  ModelGetMedicalState.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 12/04/2022.
//

import Foundation

struct ModelGetMedicalState : Codable {
  
        let message: String?
        let messageCode: Int?
        let data: MedicalState?
        let success: Bool?

        enum CodingKeys: String, CodingKey {
            case message = "Message"
            case messageCode = "MessageCode"
            case data = "Data"
            case success = "Success"
        }
}

// MARK: - DataClass
struct MedicalState: Codable {
    let height, weight,id,bloodTypeId,patientId: Int?
    let pressure,sugarLevel,bloodName:String?
    let otherAllergyies,prescriptions, currentMedication,pastMedication,chronicDiseases,injuires,surgries:String?
    let PatientFoodAllergiesDto:[Int]
    let PatientMedicineAllergiesDto:[Int]
    let PatientFoodAllergiesName:[String]
    let PatientMedicineAllergiesName:[String]
    
    enum CodingKeys: String, CodingKey {
       
        case height = "Height"
        case weight = "Weight"
        case bloodTypeId = "BloodTypeId"
        case bloodName = "BloodName"
        case pressure = "Pressure"
        case sugarLevel = "SugarLevel"
        case otherAllergyies = "OtherAllergies"
        case prescriptions = "Prescriptions"
        case currentMedication = "CurrentMedication"
        case pastMedication = "PastMedication"
        case chronicDiseases = "ChronicDiseases"
        case injuires = "Iinjuries"
        case surgries = "Surgeries"
        
        case PatientFoodAllergiesDto = "PatientFoodAllergiesDto"
        case PatientMedicineAllergiesDto = "PatientMedicineAllergiesDto"
        
        case PatientFoodAllergiesName = "PatientFoodAllergiesName"
        case PatientMedicineAllergiesName = "PatientMedicineAllergiesName"
        
        case id = "Id"
        case patientId = "PatientId"
       
    }
}
