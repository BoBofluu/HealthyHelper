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
    func setHiddenStyle() {
//        let appearance = UINavigationBarAppearance()
//        appearance.backgroundColor = .background
//        appearance.shadowColor = .clear
//
//        navigationBar.standardAppearance = appearance
//        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
//
        navigationBar.isHidden = true
    }
    /**
     設定主選單的顏色
     */
    func setNormalStyle() {
        navigationBar.isHidden = false
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .pink
        appearance.shadowColor = .clear
        
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        
        // 返回鍵
//        navigationItem.leftBarButtonItem?.tintColor = .white
//        navigationItem.backButtonTitle = ""
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .white
        navigationBar.topItem?.backBarButtonItem = backButton
    }
}
