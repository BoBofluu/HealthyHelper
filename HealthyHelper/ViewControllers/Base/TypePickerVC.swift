//
//  MoneyTypeVC.swift
//  Cherry
//  記帳頁面的類型彈出視窗
//  Created by 李旻峰 on 2022/12/29.
//

import UIKit

class TypePickerVC: UIViewController {
    /// 選單
    @IBOutlet weak var m_pvPicker: UIPickerView!
    /// 類型選單
    internal var aryType: [String] = []
    /// 預設的索引
    internal var UnSelectRow = Int()
    /// 類型索引
    internal var didSelectRow: Int = Int()
    /// 選單的提示字
    @IBOutlet weak var m_lPlaceholder: UILabel!
    /// 選單的提示字
    internal var m_strPlaceholder: String = String()
    /// 取消
    @IBOutlet weak var m_bCancel: UIButton!
    /// 取消事件
    internal var m_cancelAction: (() -> Void)? = nil
    /// 確認
    @IBOutlet weak var m_bConfirm: UIButton!
    /// 確認事件
    internal var m_confirmAction: (() -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 提示字
        m_lPlaceholder.text = m_strPlaceholder
        // self
        m_pvPicker.dataSource = self
        m_pvPicker.delegate = self
        // 設定位置
        if UnSelectRow < aryType.count {
            didSelectRow = UnSelectRow
            m_pvPicker.selectRow(UnSelectRow, inComponent: 0, animated: false)
        } else {
            didSelectRow = 0
            m_pvPicker.selectRow(0, inComponent: 0, animated: false)
        }
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
     關閉畫面
     */
    internal func doClickDismiss() {
        dismiss(animated: true, completion: nil)
    }
    /**
     點擊上方空白處
     */
    @IBAction func doClickDismiss(_ sender: Any) {
        m_confirmAction!()
    }
    /**
     彈出此視窗
     */
    internal func doPresent(vc: UIViewController) {
        self.modalPresentationStyle = .custom
        vc.present(self, animated: true)
    }
}

extension TypePickerVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return aryType.count
    }
}

extension TypePickerVC: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return aryType[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        didSelectRow = row
    }
}
