//
//  DefaultData.swift
//  HealthyHelper
//
//  Created by systex systex on 2023/2/4.
//

import Foundation
import CoreData

class DefaultData {
    
    /// 是否為第一次使用APP
    private var isFirstLogin: Bool {
        set {
            UserDefaults.saveValue(false, forKey: "isFirstLogin")
        }
        get {
            return UserDefaults.boolValue(forKey: "isFirstLogin")
        }
    }
    
    /// 支出陣列
    private let aryPay: [String] = [LString("DefaultData:Pay1"),
                                     LString("DefaultData:Pay2"),
                                     LString("DefaultData:Pay3"),
                                     LString("DefaultData:Pay4"),
                                     LString("DefaultData:Pay5"),
                                     LString("DefaultData:Pay6"),
                                     LString("DefaultData:Pay7")
    ]
    private let aryPayColor: [String] = ["#5AC4F7",
                                         "#C45FF6",
                                         "#D44A7A",
                                         "#F2A984",
                                         "#F3AF3D",
                                         "#FEF781",
                                         "#A3D16E"
    ]
    
    /// 收入陣列
    private let aryIncome: [String] = [LString("DefaultData:Income1"),
                                       LString("DefaultData:Income2"),
                                       LString("DefaultData:Income3")
    ]
    
    private let aryIncomeColor: [String] = ["#5AC4F7",
                                            "#C45FF6",
                                            "#D44A7A"
    ]
    
    internal func createDefaultData() {
        if isFirstLogin {
            guard let context = AppDelegate.shared?.persistentContainer.viewContext else { return }
            // 新增支出類別
            Dprint("開始新增支出")
            for i in 0..<aryPay.count {
                let pay = NSEntityDescription.insertNewObject(forEntityName: "PAY_TYPE_CUS", into: context) as! PAY_TYPE_CUS
                pay.type_name = aryPay[i]
                pay.type_color = aryPayColor[i]
                pay.order_seq = Int16(i+1)
                do {
                    try context.save()
                } catch let createError {
                    Dprint("Failed to create 支出 \(createError)")
                }
            }
            // 新增收入類別
            Dprint("開始新增收入")
            for i in 0..<aryIncome.count {
                let income = NSEntityDescription.insertNewObject(forEntityName: "INCOME_TYPE_CUS", into: context) as! INCOME_TYPE_CUS
                income.type_name = aryIncome[i]
                income.type_color = aryIncomeColor[i]
                income.order_seq = Int16(i+1)
                do {
                    try context.save()
                } catch let createError {
                    Dprint("Failed to create 收入 \(createError)")
                }
            }
            isFirstLogin = false
        } else {
            Dprint("已建立過")
        }
    }
}
