//
//  ListUpdateMoneyVC.swift
//  Cherry
//
//  Created by 李旻峰 on 2023/1/28.
//

import UIKit

class ListUpdateMoneyVC: BasePushVC {
    /// 支出 / 收入
    @IBOutlet weak var scType: UISegmentedControl!
    
    /// 金額按鈕
    @IBOutlet weak var bMoney: UIButton!
    @IBOutlet weak var lMoney: UILabel!
    
    /// 類型按鈕
    @IBOutlet weak var bType: UIButton!
    /// 類型
    @IBOutlet weak var lType: UILabel!
    /// 類型選擇器 - 支出
    private var costPickerVC = TypePickerVC()
    /// 類型選擇器 - 收入
    private var incomePickerVC = TypePickerVC()
    /// 支出的索引
    private var indexCost: Int = Int()
    /// 收入的索引
    private var indexIncome: Int = Int()

    /// 日期按鈕
    @IBOutlet weak var bDate: UIButton!
    /// 日期
    @IBOutlet weak var lDate: UILabel!
    /// 日期選擇器
    private var datePickerVC = DatePickerVC()
    /// 金額彈出視窗
    private var moneyPopupVC = MoneyPopupVC()
    /// 判斷符號的flag
    private var isSpecial: Bool = false
    /// 判斷數字的flag
    private var isMath: Bool = false
    /// 判斷小數點的flag
    private var isDot: Bool = false
    /// 小數點的Map
    private var mapDot: [Int: Bool] = [:] {
        didSet {
            Dprint("arrDot: \(mapDot)")
        }
    }
    /// 特殊符號的陣列
    private var arySpecial: [String] = [] {
        didSet {
            Dprint("arrSpecail: \(arySpecial)")
        }
    }
    /// 特殊符號的正則
    private let regex = try? NSRegularExpression(pattern: "[+\\-x÷]$", options: .caseInsensitive)
    private let regexDot = try? NSRegularExpression(pattern: "[.]$", options: .caseInsensitive)
    private let regexAll = try? NSRegularExpression(pattern: "[+\\-x÷.]$", options: .caseInsensitive)
    
    /// 備註按鈕
    @IBOutlet weak var bRemark: UIButton!
    /// 備註
    @IBOutlet weak var lRemark: UILabel!
    /// 備註彈出視窗
    private var remarkPopupVC = RemarkPopupVC()

    /// 保存按鈕
    @IBOutlet weak var bSave: UIButton!
    
    // MARK: 以下為view init事件 ------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 設定標題
        navigationTitle = LString("ListUpdateMoneyVC:Title")
        // 設定頁籤
        scType.defaultConfiguration()
        scType.selectedConfiguration()
        // 設定類型 - 支出
        bindTypePickerAction(type: .pay, picker: costPickerVC, UnSelectRow: indexCost, aryType: ["吃飯", "交通", "衣服"])
        // 設定類型 - 收入
        bindTypePickerAction(type: .income, picker: incomePickerVC, UnSelectRow: indexIncome, aryType: ["薪水", "小費", "樂透", "撿到的", "偷來的"])
        // 設定時間
        datePickerVC.m_strPlaceholder = LString("MoneyVC:DateChoose")
        lDate.text = Date().stringValue(dDateFormat)
        // 設定金額計算機
        bindMoneyAction()
        // 設定保存按鈕
        bSave.setBackgroundImage(UIImage(color: .pink), for: .normal)
        bSave.setTitleColor(.white, for: .normal)
        bSave.setBackgroundImage(UIImage(color: .darkPink), for: .highlighted)
        bSave.setTitleColor(.lightGray, for: .highlighted)
    }
    
    // MARK: 以下為類別事件 ------------------------------------------
    
    /// 綁定類型事件
    private func bindTypePickerAction(type: RecordType, picker: TypePickerVC, UnSelectRow: Int, aryType: [String]) {
        picker.m_strPlaceholder = LString("MoneyVC:TypeChoose")
        picker.UnSelectRow = UnSelectRow
        picker.aryType = aryType
        picker.m_confirmAction = {
            picker.doClickDismiss()
            switch type {
            case .pay:
                self.indexCost = picker.didSelectRow
            case .income:
                self.indexIncome = picker.didSelectRow
            }
            self.lType.text = picker.aryType[picker.didSelectRow]
        }
    }
    
    // MARK: 以下為計算機事件 ------------------------------------------
    
    /// 綁定金額事件
    private func bindMoneyAction() {
        // 點擊空白處
        moneyPopupVC.confirmAction = {
            self.resultMoney(isDismiss: true)
            self.moneyPopupVC.doClickDismiss()
        }
        // 清空
        moneyPopupVC.clearAction = {
            self.clearMoney()
        }
        // 減一位
        moneyPopupVC.cancelAction = {
            self.cancelMoney()
        }
        // 等於
        moneyPopupVC.equalAction = {
            self.resultMoney()
        }
        // 數字
        moneyPopupVC.mathAction = { math in
            self.calculatorMoney(math)
        }
        // 特殊符號
        moneyPopupVC.specialAction = { special in
            self.calculatorSpecial(special)
        }
        moneyPopupVC.multiplicationAction = { multiplication in
            self.calculatorSpecial(multiplication, isChange: "*")
        }
        moneyPopupVC.divisionAction = { division in
            self.calculatorSpecial(division, isChange: "/")
        }
        moneyPopupVC.dotAction = { dot in
            self.calculatorDot(dot)
        }
    }

    /// 清空金額
    private func clearMoney() {
        lMoney.text = LString("MoneyVC:Money")
        clearValue()
    }
    /// 減一位數
    private func cancelMoney() {
        // 判斷是否能減數
        if checkEmpty() {
            // 刪掉了特殊符號
            if checkSpecial() { // 123+123
                arySpecial.removeLast()
                changeBool(special: false, math: true, dot: mapDot[arySpecial.count])
            }
            // 刪掉了小數點
            else if checkDot() { // 123.23
                mapDot[arySpecial.count] = false
                changeBool(special: false, math: true, dot: mapDot[arySpecial.count])
            }
            
            lMoney.text = lMoney.text!.substring(to: lMoney.text!.count-1)
            
            // 減完後判斷
            if !checkEmpty() { // 如果為空
                lMoney.text = LString("MoneyVC:Money")
                clearValue()
            }
        }
    }
    /// 按等於或跳出視窗
    private func resultMoney(isDismiss: Bool = false) {
        let check = checkAll()
        
        if checkEmpty() && !check {
            Dprint("數字等於 = \(lMoney.text!)")
            
            // 處理數字
            let split = try? NSRegularExpression(pattern: "\\d+(?:\\.\\d+)?", options: .caseInsensitive)
            var arrArgument: [Double] = []
            
            if let matches = split?.matches(in: lMoney.text!, options: [], range: NSRange(location: 0, length: lMoney.text!.utf16.count)) {
                for match in matches {
                    let numberString = (lMoney.text! as NSString).substring(with: match.range)
                    arrArgument.append(Double(numberString) ?? 0.0)
                }
            }
            // 處理特殊符號
            var strFormat = "%@"
            for special in arySpecial {
                strFormat += " \(special) %@"
            }
            
            let expression = NSExpression(format: strFormat, argumentArray: arrArgument)
            let double = expression.expressionValue(with: nil, context: nil) as! NSNumber
            lMoney.text = String(double.stringValue)
            // 重置
            clearValue()
            if lMoney.text?.contains(".") == true {
                mapDot[0] = true
            }
            
        } else if check {
            if isDismiss {
//                m_lMoney.text = LString("MoneyVC:Money")
                // 重置
//                clearValue()
            } else {
                moneyPopupVC.doAlert()
            }
        }
    }
    /// 加數字（過程）
    private func calculatorMoney(_ math: String) {
        // 一開始的值
        if lMoney.text == LString("MoneyVC:Money") {
            lMoney.text = ""
        }
        // 轉換
        lMoney.text = (lMoney.text ?? "") + math
        changeBool(special: false, math: true, dot: nil)
    }
    /// 加特殊符號（過程）
    private func calculatorSpecial(_ special: String, isChange: String = "") {
        guard let text = lMoney.text else { return }
        
        if checkEmpty() && isMath { // 不為空 且 前面為數字時
            lMoney.text = text + special
            changeBool(special: true, math: false, dot: false)
            
            // 最後append
            if isChange != "" {
                arySpecial.append(isChange)
            } else {
                arySpecial.append(special)
            }
        } else if arySpecial.count > 0 {
            lMoney.text = text.substring(to: text.count-1) + special
            arySpecial.removeLast()
            
            // 最後append
            if isChange != "" {
                arySpecial.append(isChange)
            } else {
                arySpecial.append(special)
            }
        }
    }
    /// 加小數點（過程）
    private func calculatorDot(_ dot: String) {
        if checkEmpty() && isMath && !isDot { // 不為空 且 前面為數字時 且 這個數字沒出現小數點時
            lMoney.text = lMoney.text! + dot
            mapDot[arySpecial.count] = true
            changeBool(special: nil, math: false, dot: true)
        }
    }
    
    // MARK: 以下為判斷式 ------------------------------------------
    
    /// 檢查金額是否為空或是等於金額字串
    private func checkEmpty() -> Bool {
        let text = lMoney.text
        if text == "" || text == LString("MoneyVC:Money") {
            return false
        } else {
            return true
        }
    }
    /// 更改
    private func changeBool(special: Bool?, math: Bool?, dot: Bool?) {
        // 有的話才更改
        if let special = special {
            isSpecial = special
        }
        if let math = math {
            isMath = math
        }
        if let dot = dot {
            isDot = dot
        }
        Dprint("isSpecail : \(isSpecial), isMath : \(isMath), isDot : \(isDot)")
    }
    /// 檢查特殊符號
    private func checkSpecial() -> Bool {
        if let _ = regex?.firstMatch(in: lMoney.text!, options: [], range: NSRange(location: 0, length: lMoney.text!.utf16.count))  {
            // 如果字符串的最後一位為 +、-、* 或 /，則會執行此代碼塊
            return true
        } else {
            // 如果字符串的最後一位不是 +、-、* 或 /，則會執行此代碼塊
            return false
        }
    }
    /// 檢查小數點
    private func checkDot() -> Bool {
        if let _ = regexDot?.firstMatch(in: lMoney.text!, options: [], range: NSRange(location: 0, length: lMoney.text!.utf16.count))  {
            // 如果字符串的最後一位為 .，則會執行此代碼塊
            return true
        } else {
            // 如果字符串的最後一位不是 .，則會執行此代碼塊
            return false
        }
    }
    /// 檢查全部（送出時使用）
    private func checkAll() -> Bool {
        if let _ = regexAll?.firstMatch(in: lMoney.text!, options: [], range: NSRange(location: 0, length: lMoney.text!.utf16.count))  {
            return true
        } else {
            return false
        }
    }
    /// 清除資料
    private func clearValue() {
        arySpecial = []
        mapDot = [:]
        changeBool(special: false, math: true, dot: false)
    }
    
    // MARK: 以下為點擊方法 ------------------------------------------
    
    /// 點擊支出 收入
    @IBAction func doClickSegment(_ sender: UISegmentedControl) {
        lType.text = LString("MoneyVC:TypeChoose")
    }
    /// 點擊金額
    @IBAction func doClickMoney(_ sender: Any) {
        DprintLine(message: "Money")
        // 彈出
        moneyPopupVC.doPresent(vc: self)
    }
    /// 點擊清空
    @IBAction func doClickClear(_ sender: Any) {
        clearMoney()
    }
    /// 點擊新增種類
    @IBAction func doClickPlusType(_ sender: Any) {
        pushVC(vc: EditTypeVC())
    }
    /// 點擊種類
    @IBAction func doClickType(_ sender: Any) {
        if scType.selectedSegmentIndex == RecordType.pay.rawValue {
            costPickerVC.doPresent(vc: self)
            
        } else if scType.selectedSegmentIndex == RecordType.income.rawValue {
            
            incomePickerVC.doPresent(vc: self)
        }
    }
    /// 點擊日期
    @IBAction func doClickDate(_ sender: Any) {
        datePickerVC.m_confirmAction = {
            self.datePickerVC.doClickDismiss()
            self.lDate.text = self.datePickerVC.selectedDate.stringValue(dDateFormat)
        }
        datePickerVC.doPresent(vc: self)
    }
    @IBAction func doClickRemark(_ sender: Any) {
        remarkPopupVC.doPresent(vc: self)
        remarkPopupVC.confirmAction = { text in
            self.remarkPopupVC.doClickDismiss()
            self.lRemark.text = text == "" ? LString("MoneyVC:RemarkChoose") : text
        }
    }
    
    /// 點擊保存
    @IBAction func doClickSave(_ sender: Any) {
    }
}
