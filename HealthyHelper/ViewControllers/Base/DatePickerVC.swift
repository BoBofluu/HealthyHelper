//
//  DatePickerVC.swift
//  Cherry
//  記帳頁面的時間彈出視窗
//  Created by 李旻峰 on 2022/12/11.
//

import UIKit

class DatePickerVC: UIViewController {
    // 選單
    @IBOutlet weak var m_pvPicker: UIDatePicker!
    // 選單的提示字
    @IBOutlet weak var m_lPlaceholder: UILabel!
    internal var m_strPlaceholder: String = String()
    // 取消
    @IBOutlet weak var m_bCancel: UIButton!
    // 確認
    @IBOutlet weak var m_bConfirm: UIButton!
    // 確認的事件
    internal var m_confirmAction: (() -> Void)? = nil
    // 目前選擇的日期
    internal var selectedDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DprintLine(message: "日期視窗彈出")
        // 提示字
        m_lPlaceholder.text = m_strPlaceholder
        // self
        m_pvPicker.locale = Locale(identifier: Locale.preferredLanguages[0])
        m_pvPicker.maximumDate = Date()
        m_pvPicker.date = selectedDate
        m_pvPicker.addTarget(self, action: #selector(doClickDate), for: .valueChanged)
    }
    /**
     將 selectedDate 變成選單的日期
     */
    @objc private func doClickDate() {
        selectedDate = m_pvPicker.date
    }
    /**
     點擊取消
     */
    @IBAction func doClickCancel(_ sender: Any) {
        doClickDismiss()
    }
    /**
     點擊確認
     */
    @IBAction func doClickConfirm(_ sender: Any) {
        m_confirmAction!()
    }
    /**
     點擊上方空白處
     */
    @IBAction func doClickDismiss(_ sender: Any) {
        selectedDate = m_pvPicker.date
        m_confirmAction!()
    }
    /**
     彈出此視窗
     */
    internal func doPresent(vc: UIViewController) {
        self.modalPresentationStyle = .custom
        vc.present(self, animated: true)
    }
    /**
     關閉畫面
     */
    internal func doClickDismiss() {
        dismiss(animated: true, completion: nil)
    }
}
