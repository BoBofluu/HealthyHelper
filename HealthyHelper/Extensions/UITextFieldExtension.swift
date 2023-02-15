//
//  UITextFieldExtension.swift
//  Cherry
//
//  Created by 李旻峰 on 2022/12/10.
//

import UIKit

enum SValidateType: Int {
    case `default`
    case money // 手機號碼
    
    var expression: String {
        switch self {
        case .default:          return "^[^\\r]{0,}$"
        case .money:            return "^[0-9+*÷-]{0,}$"
        }
    }
    /**
     判斷正則
     */
    func checkRegex(_ text: String) -> Bool {
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", self.expression)
        return predicate.evaluate(with: text)
    }
}

extension UITextField {
    /**
     使用文字檔
     */
    @IBInspectable private var Localize: Bool {
        get { return false }
        set { if (newValue) {
            text = LString(text)
            placeholder = LString(placeholder)
        }}
    }
    /**
     限制可輸入的字串
     */
    func canInput(text: String, validateType: SValidateType = .default) -> Bool {
        let newText = (self.text ?? "") + text
        return validateType.checkRegex(newText)
    }
    /**
     左邊的Padding
     */
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    /**
     右邊的Padding
     */
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

