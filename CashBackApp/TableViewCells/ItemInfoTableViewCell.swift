//
//  ItemInfoTableViewCell.swift
//  CashBackApp
//
//  Created by Eldar Garbuzov on 18.10.22.
//

import UIKit

class ItemInfoTableViewCell: UITableViewCell {
    
    static var key = "ItemInfoTableViewCell"
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var marketLogo: UIImageView!
    @IBOutlet weak var productCost: UILabel!
    @IBOutlet weak var viewForCashback: UIView!
    @IBOutlet weak var cashBachValue: UILabel!
    @IBOutlet weak var cashBackPaymentTime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        productTitle.lineBreakMode = .byWordWrapping
        productTitle.numberOfLines = 0
        
        viewForCashback.layer.cornerRadius = 15
        viewForCashback.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configuration(data: Product?) {
        guard let title = data?.name,
              let cost = data?.price,
              let cashBackValue = data?.cashback,
              let paymentTime = data?.paymentTime,
              let logo = data?.campaignImageURL
        else { return }
        
        productTitle.text = title
        productCost.text = cost
        cashBachValue.text = cashBackValue
        cashBackPaymentTime.text = paymentTime
        
        logo.stringToImage { [weak self] (image) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.marketLogo.image = image
            }
        }
        
    }
    
}
