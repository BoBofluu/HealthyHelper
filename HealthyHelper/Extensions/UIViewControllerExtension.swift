//
//  UIViewControllerExtension.swift
//  Cherry
//
//  Created by systex systex on 2023/1/12.
//

import UIKit

extension UIViewController {
    func presentToFade() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.fade
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        if let window = self.view.window {
            window.layer.add(transition, forKey: kCATransition)
        }
//        self.view.window!.layer.add(transition, forKey: kCATransition)
    }
    func pushVC(vc: UIViewController, animated: Bool = true) {
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: animated)
    }
}
