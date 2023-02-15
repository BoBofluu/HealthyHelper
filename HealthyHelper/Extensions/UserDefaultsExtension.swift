//
//  UserDefaultsExtension.swift
//  HealthyHelper
//
//  Created by systex systex on 2023/2/4.
//

import Foundation

extension UserDefaults {
    // MARK: - Basic
    static func removeValue(forKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    static func anyValue(forKey key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }
    
    static func saveValue(_ value: Any?, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    // MARK: - Setter
    static func saveCodableArray<Element: Codable>(_ value: [Element], forKey key: String) {
        let data = try? JSONEncoder().encode(value)
        
        UserDefaults.saveValue(data, forKey: key)
    }
    
    static func saveCodable<Element: Codable>(_ value: Element, forKey key: String) {
        let data = try? JSONEncoder().encode(value)
        
        UserDefaults.saveValue(data, forKey: key)
    }
    
    // MARK: - Getter
    static func stringValue(forKey key: String) -> String {
        return UserDefaults.anyValue(forKey: key) as? String ?? ""
    }
    
    static func boolValue(forKey key: String) -> Bool {
        return UserDefaults.anyValue(forKey: key) as? Bool ?? true
    }
    
    static func dateValue(forKey key: String) -> Date? {
        return UserDefaults.anyValue(forKey: key) as? Date
    }
    
    static func stringArray(forKey key: String) -> [String] {
        return UserDefaults.anyValue(forKey: key) as? [String] ?? []
    }
    
    static func firstRunValue(forKey key: String) -> Bool {
        let bValue = UserDefaults.boolValue(forKey: key)
        UserDefaults.saveValue(true, forKey: key)
        
        return !bValue
    }
    
    static func codableArray<Element: Codable>(forKey key: String) -> [Element]? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        
        let element = try? JSONDecoder().decode([Element].self, from: data)
        
        return element
    }
    
    static func codable<Element: Codable>(forKey key: String) -> Element? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        
        let element = try? JSONDecoder().decode(Element.self, from: data)
        
        return element
    }
}
