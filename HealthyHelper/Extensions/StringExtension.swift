//
//  StringExtension.swift
//  Cherry
//
//  Created by 李旻峰 on 2022/12/24.
//

import Foundation
import UIKit

extension String {
    func distance(to : Index) -> Int {
        distance(from: startIndex, to: to)
    }
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
    var htmlString:NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            let attributedString = try NSMutableAttributedString(data: data,
                                                                 options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue],
                                                                 documentAttributes: nil)
            let range = NSRange(location: 0, length: attributedString.length)
            
            attributedString.enumerateAttribute(.font, in: range) { value, range, pointer in
                
                let replacementAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
                attributedString.addAttributes(replacementAttribute as [NSAttributedString.Key : Any], range: range)
            }
                            
            return attributedString
            
        } catch {
            return nil
        }
    }
    
    func dateValue(_ formatStyle: String) -> Date? {
        if self.isEmpty == true {
            return nil
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = formatStyle
        
        return formatter.date(from: self)
    }
    
    func numberFormat() -> String {
        let amt = Int(self) ?? 0
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        
        return formatter.string(from: NSNumber(value: amt))!
    }
    
    func numberFormatUnit() -> String {
        let amt = Int(self) ?? 0
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        
        return formatter.string(from: NSNumber(value: amt))! + LString("Base:Unit")
    }
    
    func mobileFormat() -> String {
        guard self.count == 10 else {
            return ""
        }
        return self.substring(to: 4) + "****" + self.substring(with: 8..<10)
    }
    
    func emailFormat() -> String {
        if let index = self.firstIndex(of: "@") {
            var strFormat = ""
            let suffix = self.distance(to: index)
            
            strFormat = self.substring(to: 4)
            
            var loop = suffix - 4
            if loop > 6 {
                loop = 6
            } else if loop <= 0 {
                strFormat = self.substring(to: suffix)
                loop = 2
            }
            
            for _ in 0..<loop {
                strFormat += "*"
            }
            strFormat += self.substring(from: suffix)
            
            return strFormat
        } else {
            return ""
        }
    }
}

extension StringProtocol {
    
    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.lowerBound
    }
    func endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.upperBound
    }
    func indices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
        ranges(of: string, options: options).map(\.lowerBound)
    }
    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...]
                .range(of: string, options: options) {
                result.append(range)
                startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}
