//
//  HomeVC_Home.swift
//  Cherry
//
//  Created by 李旻峰 on 2022/10/2.
//

import UIKit

class HomeVC_Home: BaseVC {
    
    @IBOutlet weak var vCircle: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        vCircle.layer.cornerRadius = (dScreenSize.width - 60.0) / 2.0
        print("viewDidLayoutSubviews: \(dScreenSize)")
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
//        m_vCircle.layer.cornerRadius = (kSize_Screen.width - 40.0) / 2.0
    }
}
