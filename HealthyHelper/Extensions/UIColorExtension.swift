//
//  UIColorExtension.swift
//  Cherry
//
//  Created by 李旻峰 on 2022/10/2.
//

import Foundation
import UIKit

extension UIColor {
    class var background: UIColor {
        return UIColor(red: 1, green: 0.98, blue: 0.929, alpha: 1) /* #FFFAED */
    }
    class var toolBar: UIColor {
        return UIColor(red: 1, green: 0.949, blue: 0.817, alpha: 1) /* #FFF2D0 */
    }
    class var darkGray: UIColor {
        return UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1) /* #999999 */
    }
    class var lightGray: UIColor {
        return UIColor(red: 0.917, green: 0.917, blue: 0.917, alpha: 1) /* #EAEAEA */
    }
    class var placeholder: UIColor {
        return UIColor(red: 0.792, green: 0.792, blue: 0.792, alpha: 1) /* #CACACA */
    }
    class var pink: UIColor {
        return UIColor(red: 1, green: 0.65, blue: 0.65, alpha: 1) /* #FFA6A6 */
    }
    class var darkPink: UIColor {
        return UIColor(red: 0.7765, green: 0.5137, blue: 0.5137, alpha: 1.0) /* #c68383 */
    }
    class var keyboardGray: UIColor {
        return UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1) /* #EFEFF4 */
    }
    
    /// 會轉成sRGB的Hex
    func toHexString() -> String {
            cgColor.toHex() ?? ""
    }
    /// 會轉成DisplayP3的Hex
    func toDisplayP3HexString() -> String {
        guard let displayP3Color = self.cgColor.converted(to: CGColorSpace(name: CGColorSpace.displayP3)!, intent: .defaultIntent, options: nil) else {
            return ""
        }
        return displayP3Color.toHex() ?? ""
    }
}

extension CGColor {
    func toHex() -> String? {
        guard let components = components else { return nil }

        if components.count == 2 {
            let value = components[0]
            return String(format: "#%02lX%02lX%02lX", lroundf(Float(value*255)), lroundf(Float(value*255)), lroundf(Float(value*255)))
        }
        
        guard components.count == 4 else { return nil }
        
        let red   = components[0]
        let green = components[1]
        let blue  = components[2]
        
        let hexString = String(format: "#%02lX%02lX%02lX", lroundf(Float(red*255)), lroundf(Float(green*255)), lroundf(Float(blue*255)))
        
        return hexString
    }
}
