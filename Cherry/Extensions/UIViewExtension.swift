//
//  UIViewExtension.swift
//  Cherry
//
//  Created by 李旻峰 on 2022/12/3.
//

import UIKit

extension UIView {
    /**
     Cell載入的時侯
     */
    public class func loadFromNib() -> UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    /**
     移除所有子畫面
     */
    public func removeAllsubviews() {
        for v in subviews {
            v.removeFromSuperview()
        }
    }
    /**
     圓角
     */
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    /**
     邊框寬度
     */
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    /**
     邊框顏色
     */
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}

