//
//  UILabelExtension.swift
//  Cherry
//
//  Created by 李旻峰 on 2022/10/2.
//

import UIKit

extension UILabel {
    /**
     使用文字檔
     */
    @IBInspectable private var Localize: Bool {
        get { return false }
        set { if (newValue) {
            text = LString(text)
        }}
    }
}
