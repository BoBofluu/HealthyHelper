//
//  UINavigationExtension.swift
//  Cherry
//
//  Created by 李旻峰 on 2022/10/2.
//

import UIKit

extension UINavigationController {
    /**
     設定主選單的顏色
     */
    func setNormalStyle() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .background
        appearance.shadowColor = .clear
        
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        
        navigationBar.isHidden = true
    }
}
