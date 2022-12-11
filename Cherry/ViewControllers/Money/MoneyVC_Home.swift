//
//  MoneyVC_Home.swift
//  Cherry
//
//  Created by 李旻峰 on 2022/10/2.
//

import UIKit

class MoneyVC_Home: BaseVC {
    // 支出 / 收入
    @IBOutlet weak var m_scSegment: UISegmentedControl!
    // 金額按鈕
    @IBOutlet weak var m_bMoney: UIButton!
    // 類型按鈕
    @IBOutlet weak var m_bType: UIButton!
    // 日期按鈕
    @IBOutlet weak var m_bDate: UIButton!
    // 日期
    @IBOutlet weak var m_lDate: UILabel!
    // 日期選擇器
    private var m_datePicker = DatePickerVC()

    override func viewDidLoad() {
        super.viewDidLoad()
        m_scSegment.defaultConfiguration()
        m_scSegment.selectedConfiguration()
        
        m_datePicker.m_strPlaceholder = LString("MoneyMC:Date")
    }
    
    /**
     點擊生日
     */
    @IBAction func doClickDate(_ sender: Any) {
        m_datePicker.m_confirmAction = {
            self.m_datePicker.doClickDismiss()
            self.m_lDate.text = self.m_datePicker.selectedDate.stringValue(dTimeFormatDate)
        }
        m_datePicker.doPresent(vc: self)
    }
}
