//
//  MoneyPopupVC.swift
//  Cherry
//  計算機
//  Created by 李旻峰 on 2022/12/18.
//

import UIKit

class MoneyPopupVC: UIViewController {
    /// 上方的透明視窗
    @IBOutlet weak var vClear: UIView!
    /// 清空
    @IBOutlet weak var bClear: UIButton!
    /// 減一位
    @IBOutlet weak var bCancel: UIButton!
    /// 等於
    @IBOutlet weak var bEqual: UIButton!
    // 0~9
    @IBOutlet weak var bOne: UIButton!
    @IBOutlet weak var bTwo: UIButton!
    @IBOutlet weak var bThree: UIButton!
    @IBOutlet weak var bFour: UIButton!
    @IBOutlet weak var bFive: UIButton!
    @IBOutlet weak var bSix: UIButton!
    @IBOutlet weak var bSeven: UIButton!
    @IBOutlet weak var bEight: UIButton!
    @IBOutlet weak var bNine: UIButton!
    @IBOutlet weak var bZero: UIButton!
    @IBOutlet weak var bDoubleZero: UIButton!
    @IBOutlet weak var bDot: UIButton!
    /// 加
    @IBOutlet weak var bPlus: UIButton!
    /// 減
    @IBOutlet weak var bMinus: UIButton!
    /// 乘
    @IBOutlet weak var bMultiplication: UIButton!
    /// 除
    @IBOutlet weak var bDivision: UIButton!
    /// 空白事件
    internal var confirmAction: (() -> Void)? = nil
    /// 清空欄位
    internal var clearAction: (() -> Void)? = nil
    /// 減一位
    internal var cancelAction: (() -> Void)? = nil
    /// 等於
    internal var equalAction: (() -> Void)? = nil
    /// 數字
    internal var mathAction: ((_ math: String) -> Void)? = nil
    /// 符號
    internal var specialAction: ((_ special: String) -> Void)? = nil
    /// 小數點
    internal var dotAction: ((_ dot: String) -> Void)? = nil
    /// 乘號
    internal var multiplicationAction: ((_ multiplication: String) -> Void)? = nil
    /// 除號
    internal var divisionAction: ((_ division: String) -> Void)? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // 數字
        changeHighlightedColor(bOne)
        changeHighlightedColor(bTwo)
        changeHighlightedColor(bThree)
        changeHighlightedColor(bFour)
        changeHighlightedColor(bFive)
        changeHighlightedColor(bSix)
        changeHighlightedColor(bSeven)
        changeHighlightedColor(bEight)
        changeHighlightedColor(bNine)
        changeHighlightedColor(bZero)
        changeHighlightedColor(bDoubleZero)
        changeHighlightedColor(bDot)
        // 符號
        changeHighlightedColorSpecial(bClear)
        changeHighlightedColorSpecial(bCancel)
        changeHighlightedColorSpecial(bEqual)
        changeHighlightedColorSpecial(bPlus)
        changeHighlightedColorSpecial(bMinus)
        changeHighlightedColorSpecial(bMultiplication)
        changeHighlightedColorSpecial(bDivision)
    }
    /// 設定數字的Highlighted
    private func changeHighlightedColor(_ button: UIButton) {
        button.setBackgroundImage(UIImage(color: .white), for: .normal)
        button.setBackgroundImage(UIImage(color: .pink), for: .highlighted)
    }
    /// 設定符號的Highlighted
    private func changeHighlightedColorSpecial(_ button: UIButton) {
        button.setBackgroundImage(UIImage(color: .pink), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(UIImage(color: .white), for: .highlighted)
        button.setTitleColor(.black, for: .highlighted)
    }
    /// 點擊上方空白處
    @IBAction func doClickDismiss(_ sender: Any) {
        confirmAction!()
    }
    /// 清除全部 AC
    @IBAction func doClickClear(_ sender: Any) {
        Dprint("點擊清空")
        clearAction!()
    }
    /// 點擊箭頭減一位 ←
    @IBAction func doClickCancel(_ sender: Any) {
        cancelAction!()
    }
    /// 點擊等於 =
    @IBAction func doClickEqual(_ sender: Any) {
        Dprint("點擊等於")
        equalAction!()
    }
    /// 點擊數字 0-9
    @IBAction func doClickMath(_ sender: UIButton) {
        if let title = sender.title(for: .normal) {
            Dprint("點擊數字： \(title)")
            mathAction!(title)
        }
    }
    /// 點擊小數點
    @IBAction func doClickDot(_ sender: UIButton) {
        if let title = sender.title(for: .normal) {
            Dprint("點擊小數點： \(title)")
            dotAction!(title)
        }
    }
    /// 點擊加號
    @IBAction func doClickPlus(_ sender: UIButton) {
        if let title = sender.title(for: .normal) {
            Dprint("點擊加號 或 減號： \(title)")
            specialAction!(title)
        }
    }
    /// 點擊乘號
    @IBAction func doClickMultiplication(_ sender: UIButton) {
        if let title = sender.title(for: .normal) {
            Dprint("點擊乘號： \(title)")
            multiplicationAction!(title)
        }
    }
    /// 點擊除號
    @IBAction func doClickDivision(_ sender: UIButton) {
        if let title = sender.title(for: .normal) {
            Dprint("點擊除號： \(title)")
            divisionAction!(title)
        }
    }
    /// 彈出此視窗
    internal func doPresent(vc: UIViewController) {
        self.modalPresentationStyle = .custom
        vc.present(self, animated: true)
    }
    /// 關閉畫面
    internal func doClickDismiss() {
        dismiss(animated: true, completion: nil)
    }
    /// 錯誤訊息
    internal func doAlert() {
        let alert = UIAlertController(title: "錯誤", message: "請輸入正確的金額", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "確定", style: .default, handler: nil)
        alert.addAction(okAction)

        present(alert, animated: true, completion: nil)
    }
}

