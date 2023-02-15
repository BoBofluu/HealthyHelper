//
//  BasePushVC.swift
//  Cherry
//
//  Created by systex systex on 2023/1/13.
//

import UIKit

class BasePushVC: UIViewController {
    /// 導覽列標題
    internal var navigationTitle: String = "" {
        didSet {
            let title = UILabel()
            title.backgroundColor = .clear
            title.textColor = .white
            title.textAlignment = .center
            title.text = navigationTitle
            self.navigationItem.titleView = title
        }
    }
    /// tabBar高
    internal var tabBarHeight: CGFloat {
        return self.tabBarController?.tabBar.frame.height ?? 83.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .background
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNormalStyle()
    }
}
