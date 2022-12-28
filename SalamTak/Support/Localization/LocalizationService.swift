//
//  LocalizationService.swift
//  SalamTech
//
//  Created by wecancity agency on 3/29/22.
//

import Foundation

class LocalizationService {

    static let shared = LocalizationService()
    static let changedLanguage = Notification.Name("changedLanguage")

    private init() {}
    
    var language: Language {
        get {
            guard let languageString = UserDefaults.standard.string(forKey: "languageKey") else {
                return .english_us
            }
            return Language(rawValue: languageString) ?? .english_us
        } set {
            if newValue != language {
                UserDefaults.standard.setValue(newValue.rawValue, forKey: "languageKey")
                NotificationCenter.default.post(name: LocalizationService.changedLanguage, object: nil)
            }
        }
    }
}
