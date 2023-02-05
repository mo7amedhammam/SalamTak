//
//  ModelPromotions.swift
//  SalamTak
//
//  Created by wecancity on 05/02/2023.
//

// MARK: - ModelAds
struct ModelPromotions: Codable ,Identifiable, Hashable{
    static func == (lhs: ModelPromotions, rhs: ModelPromotions) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    var id: Int?
    let compName, videoLink: String?
    let isVideo, deleted, isDoctor: Bool?
    let pageID, categoryID: Int?
    let discription, url: String?
    let isDefault: Bool?
    let adOrder: Int?
    let getAdImagesDtos: [GetAdImagesDto]?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case compName = "CompName"
        case videoLink = "VideoLink"
        case isVideo = "IsVideo"
        case deleted = "Deleted"
        case isDoctor = "IsDoctor"
        case pageID = "PageID"
        case categoryID = "CategoryID"
        case discription = "Discription"
        case url = "URL"
        case isDefault = "IsDefault"
        case adOrder = "AdOrder"
        case getAdImagesDtos = "getAd_ImagesDtos"
    }
}

// MARK: - GetAdImagesDto
struct GetAdImagesDto: Codable,Identifiable,Hashable {
    static func == (lhs: GetAdImagesDto, rhs: GetAdImagesDto) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }

    var id: Int?
    let adID: Int?
    let imageURL: String?
    let imageOrder: Int?
    let deleted: Bool?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case adID = "AdID"
        case imageURL = "ImageURL"
        case imageOrder = "ImageOrder"
        case deleted = "Deleted"
    }
}
