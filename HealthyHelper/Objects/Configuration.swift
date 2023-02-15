//
//  Configuration.swift
//  Cherry
//
//  Created by 李旻峰 on 2022/12/11.
//

import UIKit

/**
 讀取文字檔
 */
func LString(_ string: String?) -> String {
    return NSLocalizedString(string ?? "", comment: "")
}
/**
 讀取文字檔 - 使用參數
 */
func LStringFormat(_ string: String, _ arguments: CVarArg...) -> String {
    if arguments.count == 0 {
        return LString(string)
    }
    
    let strSentance: String = LString(string)
    let strText = String(format:strSentance, arguments:arguments)
    
    return strText
}
/**
 print
 */
func Dprint(_ item: @autoclosure () -> Any) {
    #if DEBUG
        print(item())
    #endif
}
/**
 print内容，包含class和所在行數
  - Parameters:
  - message:
  - file: print所屬class
  - lineNumber: print所在行數
 */
func DprintLine<T>(message: T, file: String = #file, lineNumber: Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("[ \(fileName) : \(lineNumber) ] - \(message)")
    #endif
}
/// 將Hex換成sRGB的UIColor
func colorWithHexString(hexString: String) -> UIColor {
    var colorString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
    colorString = colorString.replacingOccurrences(of: "#", with: "").uppercased()

    let alpha: CGFloat = 1.0
    let red: CGFloat = colorComponentFrom(colorString: colorString, start: 0, length: 2)
    let green: CGFloat = colorComponentFrom(colorString: colorString, start: 2, length: 2)
    let blue: CGFloat = colorComponentFrom(colorString: colorString, start: 4, length: 2)
    
    let color = UIColor(displayP3Red: red, green: green, blue: blue, alpha: alpha)
    
    return color
}
func colorComponentFrom(colorString: String, start: Int, length: Int) -> CGFloat {

    let startIndex = colorString.index(colorString.startIndex, offsetBy: start)
    let endIndex = colorString.index(startIndex, offsetBy: length)
    let subString = colorString[startIndex..<endIndex]
    let fullHexString = length == 2 ? subString : "\(subString)\(subString)"
    var hexComponent: UInt64 = 0

    guard Scanner(string: String(fullHexString)).scanHexInt64(&hexComponent) else {
        return 0
    }
    let hexFloat: CGFloat = CGFloat(hexComponent)
    let floatValue: CGFloat = CGFloat(hexFloat / 255.0)
    return floatValue
}
