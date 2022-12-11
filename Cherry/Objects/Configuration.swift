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
