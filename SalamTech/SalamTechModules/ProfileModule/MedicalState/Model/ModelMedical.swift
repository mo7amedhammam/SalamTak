//
//  ModelPersonal.swift
//  SalamTech
//
//  Created by Mostafa Morsy on 31/03/2022.
//


import Foundation

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
