//
//  UIButtonExtension.swift
//  Cherry
//
//  Created by 李旻峰 on 2022/12/11.
//

import UIKit

extension UIButton {
    @IBInspectable private var Localize: Bool {
        get { return false }
        set { if (newValue) {
            setTitle(LString(title(for: .normal)), for: .normal)
            // 設定空字串特殊狀態會導致button不會顯示normal狀態title，設定前先檢查
            if let selectedTitle = title(for: .selected), selectedTitle.isEmpty == false {
                setTitle(LString(selectedTitle), for: .selected)
            }
            if let highlightedTitle = title(for: .highlighted), highlightedTitle.isEmpty == false {
                setTitle(LString(highlightedTitle), for: .highlighted)
            }
            if let disabledTitle = title(for: .disabled), disabledTitle.isEmpty == false {
                setTitle(LString(disabledTitle), for: .disabled)
            }
        }}
    }
    
    private var states: [UIControl.State] {
        return [.normal, .selected, .highlighted, .disabled]
    }
    
    func setImageForAllStates(_ image: UIImage) {
        states.forEach { setImage(image, for: $0) }
    }
}
