//
//  DateExtension.swift
//  Cherry
//
//  Created by 李旻峰 on 2022/12/11.
//

import Foundation

extension Date {
    /**
     將Date轉成字串
     */
    func stringValue(_ formatStyle: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = formatStyle
        
        return formatter.string(from: self)
    }
    
}

