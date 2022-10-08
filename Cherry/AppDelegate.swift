//
//  AppDelegate.swift
//  Cherry
//
//  Created by 李旻峰 on 2022/8/27.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.red

        self.window?.rootViewController = TabBarViewController()
        self.window?.makeKeyAndVisible()
        return true
    }

}

