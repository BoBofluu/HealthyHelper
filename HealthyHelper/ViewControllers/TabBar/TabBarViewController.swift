//
//  TabBarViewController.swift
//  Cherry
//
//  Created by 李旻峰 on 2022/10/2.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setShoppingTabBar()
        self.selectedIndex = 0
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
//        self.navigationController?.isNavigationBarHidden = true
    }
    func setShoppingTabBar() {
        // 首頁
        let storeTabBar = HomeVC_Home()
        let storeController = UINavigationController(rootViewController: storeTabBar)
        storeController.tabBarItem = UITabBarItem(
            title: LString("TabBarVC:Home"),
            image: UIImage(systemName: "house")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray),
            selectedImage: UIImage(systemName: "house.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.pink)
        )
        // 紀錄
        let receiptScanTabBar = MoneyVC_Home()
        let receiptScanController = UINavigationController(rootViewController: receiptScanTabBar)
        receiptScanController.tabBarItem = UITabBarItem(
            title: LString("TabBarVC:Record"),
            image: UIImage(systemName: "pencil.line")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray),
            selectedImage: UIImage(systemName: "pencil.line")?.withRenderingMode(.alwaysOriginal).withTintColor(.pink)
        )
        // 清單
        let homeTabBar = ListVC_Home()
        let homeTabBarController = UINavigationController(rootViewController: homeTabBar)
        homeTabBarController.tabBarItem = UITabBarItem(
            title: LString("TabBarVC:List"),
            image: UIImage(systemName: "list.clipboard")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray),
            selectedImage: UIImage(systemName: "list.clipboard.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.pink)
        )
        // 設定
        let receiptInfoTabBar = SettingVC_Home()
        let receiptInfoController = UINavigationController(rootViewController: receiptInfoTabBar)
        receiptInfoController.tabBarItem = UITabBarItem(
            title: LString("TabBarVC:Setting"),
            image: UIImage(systemName: "gearshape")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray),
            selectedImage: UIImage(systemName: "gearshape.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.pink)
        )
        // setting tabbarView
        self.viewControllers = [storeController, receiptScanController, homeTabBarController, receiptInfoController]
        self.tabBar.tintColor = .pink
        // setting css
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .toolBar
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .bold)]
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        } else {
            tabBar.barTintColor = .pink
        }
    }
}

