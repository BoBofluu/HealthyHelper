//
//  BaseVC.swift
//  Cherry
//  底層模板
//  Created by 李旻峰 on 2022/10/2.
//

import UIKit

class BaseVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .background
        self.edgesForExtendedLayout = [] // 當navigation為透明時還能讓navigation佔版面
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setHiddenStyle()
    }
}
