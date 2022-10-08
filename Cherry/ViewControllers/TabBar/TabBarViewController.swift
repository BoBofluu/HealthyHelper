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
        self.selectedIndex = 1
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
//        self.navigationController?.isNavigationBarHidden = true
    }
    func setShoppingTabBar() {
        // 存錢豬豬
        let storeTabBar = MoneyVC_Home()
        let storeController = UINavigationController(rootViewController: storeTabBar)
        storeController.tabBarItem = UITabBarItem(
            title: LString("TabBarVC:Money"),
            image: UIImage(named: "TabBar_Money")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "TabBar_Money")?.withRenderingMode(.alwaysOriginal)
        )
        // 首頁
        let receiptScanTabBar = HomeVC_Home()
        let receiptScanController = UINavigationController(rootViewController: receiptScanTabBar)
        receiptScanController.tabBarItem = UITabBarItem(
            title: LString("TabBarVC:Home"),
            image: UIImage(named: "TabBar_Home")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "TabBar_Home")?.withRenderingMode(.alwaysOriginal)
        )
        // 清單
        let homeTabBar = ListVC_Home()
        let homeTabBarController = UINavigationController(rootViewController: homeTabBar)
        homeTabBarController.tabBarItem = UITabBarItem(
            title: LString("TabBarVC:List"),
            image: UIImage(named: "TabBar_List")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "TabBar_List")?.withRenderingMode(.alwaysOriginal)
        )
        // 設定
        let receiptInfoTabBar = SettingVC_Home()
        let receiptInfoController = UINavigationController(rootViewController: receiptInfoTabBar)
        receiptInfoController.tabBarItem = UITabBarItem(
            title: LString("TabBarVC:Setting"),
            image: UIImage(named: "TabBar_Setting")?.withRenderingMode(.alwaysOriginal),
            selectedImage: UIImage(named: "TabBar_Setting")?.withRenderingMode(.alwaysOriginal)
        )
        // setting tabbarView
        self.viewControllers = [storeController, receiptScanController, homeTabBarController, receiptInfoController]
        self.tabBar.tintColor = .D64F40
        // setting css
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .FBEEDD
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .bold)]
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        } else {
            tabBar.barTintColor = .FBEEDD
        }
    }
}

