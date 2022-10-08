//
//  UILabelExtension.swift
//  Cherry
//
//  Created by 李旻峰 on 2022/10/2.
//

import Foundation
import UIKit

func LString(_ string: String?) -> String {
    return NSLocalizedString(string ?? "", comment: "")
}

func LStringFormat(_ string: String, _ arguments: CVarArg...) -> String {
    if arguments.count == 0 {
        return LString(string)
    }
    
    let strSentance: String = LString(string)
    let strText = String(format:strSentance, arguments:arguments)
    
    return strText
}

extension UILabel {
    @IBInspectable private var Localize: Bool {
        get { return false }
        set { if (newValue) {
            text = LString(text)
        }}
    }
}
