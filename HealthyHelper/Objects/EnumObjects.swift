//
//  EnumObjects.swift
//  Cherry
//
//  Created by systex systex on 2023/1/13.
//

import Foundation

// MARK: - Language
enum Language: Equatable {
    case english
    case chinese
}

extension Language {
    var code: String {
        switch self {
        case .english:
            return "en"
        case .chinese:
            return "zh-Hant"
        }
    }
}

extension Language {
    init?(languageCode: String?) {
        guard let languageCode = languageCode else { return nil }
        switch languageCode {
            case "en", "en-US":     self = .english
            case "zh-Hant":         self = .chinese
            default:                return nil
        }
    }
}
