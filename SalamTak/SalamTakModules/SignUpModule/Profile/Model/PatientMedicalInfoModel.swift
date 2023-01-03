//
//  PatientMedicalInfoModel.swift
//  SalamTak
//
//  Created by wecancity on 29/12/2022.
//
import Foundation

// MARK: - PatientMedicalInfoModel
struct PatientMedicalInfoModel: Codable {
    var height, weight: Int?
    var pressure, sugarLevel: String?
    var bloodTypeID: Int?
    var otherAllergies, prescriptions, currentMedication, pastMedication: String?
    var chronicDiseases, iinjuries, surgeries: String?
    var patientFoodAllergiesDto, patientMedicineAllergiesDto: [Int]?
    var id, patientID: Int?
    var bloodName: String?
    var patientFoodAllergiesName, patientMedicineAllergiesName: [String]?

    enum CodingKeys: String, CodingKey {
        case height = "Height"
        case weight = "Weight"
        case pressure = "Pressure"
        case sugarLevel = "SugarLevel"
        case bloodTypeID = "BloodTypeId"
        case otherAllergies = "OtherAllergies"
        case prescriptions = "Prescriptions"
        case currentMedication = "CurrentMedication"
        case pastMedication = "PastMedication"
        case chronicDiseases = "ChronicDiseases"
        case iinjuries = "Iinjuries"
        case surgeries = "Surgeries"
        case patientFoodAllergiesDto = "PatientFoodAllergiesDto"
        case patientMedicineAllergiesDto = "PatientMedicineAllergiesDto"
        case id = "Id"
        case patientID = "PatientId"
        case bloodName = "BloodName"
        case patientFoodAllergiesName = "PatientFoodAllergiesName"
        case patientMedicineAllergiesName = "PatientMedicineAllergiesName"
    }
}
