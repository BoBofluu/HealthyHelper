//
//  UIContentTableView.swift
//  Cherry
//
//  Created by 李旻峰 on 2023/1/21.
//

import Foundation
import UIKit

class UIContentTableView: UITableView {
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return self.contentSize
    }
    
    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }
}
