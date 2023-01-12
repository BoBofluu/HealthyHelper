//
//  RemarkPopupVC.swift
//  Cherry
//
//  Created by systex systex on 2023/1/12.
//

import UIKit

class RemarkPopupVC: UIViewController {
    /// 備註
    @IBOutlet weak var tvRemark: UITextView!
    /// 空白事件
    internal var confirmAction: ((_ text: String) -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.tvRemark.becomeFirstResponder()
        }
    }
    
    /// 點擊周圍的空白
    @IBAction func doClickDismiss(_ sender: Any) {
        let text = tvRemark.text ?? ""
        confirmAction!(text)
    }
    /// 彈出此視窗
    internal func doPresent(vc: UIViewController) {
        vc.presentToFade()
        self.modalPresentationStyle = .custom
        vc.present(self, animated: false)
    }
    /// 關閉畫面
    internal func doClickDismiss() {
        presentToFade()
        dismiss(animated: false, completion: nil)
    }
}
