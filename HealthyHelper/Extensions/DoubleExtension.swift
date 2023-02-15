//
//  DoubleExtension.swift
//  Cherry
//
//  Created by 李旻峰 on 2022/12/24.
//

import Foundation
import UIKit

extension Double {
    var clearZero: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
