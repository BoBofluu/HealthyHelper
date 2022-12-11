//
//  UISegmentedControlExtension.swift
//  Cherry
//
//  Created by 李旻峰 on 2022/12/11.
//

import UIKit

extension UISegmentedControl {
    /**
     使用文字檔
     */
    @IBInspectable private var Localize: Bool {
        get { return false }
        set { if (newValue) {
            for i in 0..<numberOfSegments {
                let title = LString(titleForSegment(at: i))
                setTitle(title, forSegmentAt: i)
            }
        }}
    }
    /**
     預設的樣式
     */
    func defaultConfiguration() {
        let defaultAttributes = [
            NSAttributedString.Key.font: UIFont(name: "Hannotate TC Bold", size: 16)!,
            NSAttributedString.Key.foregroundColor: UIColor.darkGray
        ]
        setTitleTextAttributes(defaultAttributes, for: .normal)
    }
    /**
     選定的樣式
     */
    func selectedConfiguration() {
        let selectedAttributes = [
            NSAttributedString.Key.font: UIFont(name: "Hannotate TC Bold", size: 16)!,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        setTitleTextAttributes(selectedAttributes, for: .selected)
    }
}
