//
//  ModelSlidingAds.swift
//  SalamTak
//
//  Created by wecancity on 05/02/2023.
//

import Foundation

// MARK: - ModelAds
struct ModelSlidingAds: Codable, Hashable{
    static func == (lhs: ModelSlidingAds, rhs: ModelSlidingAds) -> Bool {
        lhs.videoLink == rhs.videoLink
    }
    func hash(into hasher: inout Hasher) {
            hasher.combine(videoLink)
        }
    let videoLink: String?
    let isVideo: Bool?

    enum CodingKeys: String, CodingKey {
        case videoLink = "VideoLink"
        case isVideo = "IsVideo"
    }
}
