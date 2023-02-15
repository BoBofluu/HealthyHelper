//
//  PlusTypeVC.swift
//  Cherry
//
//  Created by 李旻峰 on 2023/1/14.
//

import UIKit

class PlusTypeVC: BasePushVC {

    @IBOutlet weak var tfType: UITextField!
    @IBOutlet weak var vColor: UIView!
    private var displayP3Color: String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 設定標題
        navigationTitle = LString("PlusTypeVC:Title")
        
        // 設定邊框
        tfType.borderStyle = .none
        
        // 設定顏色
        guard let color = vColor.backgroundColor else { return }
        displayP3Color = color.toDisplayP3HexString()
    }
    /// 點擊顏色
    @IBAction func doClickColor(_ sender: Any) {
        let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.delegate = self
        colorPickerVC.supportsAlpha = false
        if displayP3Color != String() {
            colorPickerVC.selectedColor = colorWithHexString(hexString: displayP3Color)
        }
        present(colorPickerVC, animated: true)
    }
    /// 點擊保存
    @IBAction func doClickSave(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension PlusTypeVC: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        vColor.backgroundColor = color
        
        displayP3Color = color.toDisplayP3HexString()
        Dprint("colorPickerViewControllerDidSelectColor: \(displayP3Color)")
    }
}
