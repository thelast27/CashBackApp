//
//  PreviousSearchTableViewCell.swift
//  CashBackApp
//
//  Created by Eldar Garbuzov on 11.10.22.
//

import UIKit

class PreviousSearchTableViewCell: UITableViewCell {
    
    static var key = "PreviousSearchTableViewCell"

    @IBOutlet weak var previousSearchedItem: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        previousSearchedItem.text = ""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
