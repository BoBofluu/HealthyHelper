//
//  EditTypeTVCell.swift
//  Cherry
//
//  Created by systex systex on 2023/1/13.
//

import UIKit

class EditTypeTVCell: UITableViewCell {

    @IBOutlet weak var lTypeTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    internal func configureCell(indexPath: IndexPath, aryData: [String]) {
        lTypeTitle.text = aryData[indexPath.row]
    }
}
