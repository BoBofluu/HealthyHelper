//
//  UITextViewExtension.swift
//  Cherry
//
//  Created by 李旻峰 on 2022/12/11.
//

import UIKit

extension UITextView {
    /**
     限制可輸入的字串
     */
    func canInput(text: String, validateType: SValidateType = .default) -> Bool {
        let newText = (self.text ?? "") + text
        return validateType.checkRegex(newText)
    }
}
