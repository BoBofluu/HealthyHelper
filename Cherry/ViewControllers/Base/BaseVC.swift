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
            title.textColor = .D64F40
            title.textAlignment = .center
            title.text = navigationTitle
            self.navigationItem.titleView = title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .E79786
        navigationController?.setNormalStyle()
    }
}
