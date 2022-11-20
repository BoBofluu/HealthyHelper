//
//  BaseVC.swift
//  Cherry
//
//  Created by 李旻峰 on 2022/10/2.
//

import UIKit

class BaseVC: UIViewController {
    // 導覽列標題
    var navigationTitle: String = "" {
        didSet {
            let title = UILabel()
            title.backgroundColor = .clear
            title.textColor = .toolBar
            title.textAlignment = .center
            title.text = navigationTitle
            self.navigationItem.titleView = title
        }
    }
    
    var tabBarHeight: CGFloat {
        return self.tabBarController?.tabBar.frame.height ?? 83.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .background
        self.edgesForExtendedLayout = [] // 當navigation為透明時還能讓navigation佔版面
        navigationController?.setNormalStyle()
    }
}
