//
//  ConditionsTableViewCell.swift
//  CashBackApp
//
//  Created by Eldar Garbuzov on 17.10.22.
//

import UIKit

class ConditionsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cashBackLabel: UILabel!
    @IBOutlet weak var actionTextLabel: UILabel!
    
    static var key = "ConditionsTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        cashBackLabel.text = ""
        actionTextLabel.text = ""
        actionTextLabel.lineBreakMode = .byWordWrapping
        actionTextLabel.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
