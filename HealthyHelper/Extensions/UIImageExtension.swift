//
//  UIImageExtension.swift
//  Cherry
//
//  Created by 李旻峰 on 2022/12/18.
//

import UIKit

extension UIImage {
    convenience init(color: UIColor) {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: image!.cgImage!)
      }
}
