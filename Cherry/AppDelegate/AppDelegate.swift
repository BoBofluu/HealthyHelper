//
//  AppDelegate.swift
//  Cherry
//
//  Created by 李旻峰 on 2022/8/27.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 視窗
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.clear
        self.window?.rootViewController = TabBarViewController()
        self.window?.makeKeyAndVisible()
        
        // 鍵盤
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.placeholderFont = UIFont.systemFont(ofSize: 16)
        
        
        return true
    }

}

