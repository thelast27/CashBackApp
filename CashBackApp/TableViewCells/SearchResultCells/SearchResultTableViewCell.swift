//
//  SearchResultTableViewCell.swift
//  CashBackApp
//
//  Created by Eldar Garbuzov on 11.10.22.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    static var key = "SearchResultTableViewCell"
    
    @IBOutlet weak var itemPic: UIImageView!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var marketPic: UIImageView!
    @IBOutlet weak var itemCost: UILabel!
    @IBOutlet weak var viewForCashBack: UIView!
    @IBOutlet weak var itemCashBack: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewForCashBack.layer.cornerRadius = 8
        viewForCashBack.clipsToBounds = true
        
        itemTitle.lineBreakMode = .byWordWrapping
        itemTitle.numberOfLines = 0
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    func configuration(data: Product) {
        
        guard let title = data.name,
              let cost = data.price,
              let cashBack = data.cashback,
              let itemImg = data.imageUrls,
              let marketPic = data.campaignImageURL
        else { return }
        
        itemTitle.text = title
        itemCost.text = cost
        itemCashBack.text = cashBack
        
        
        itemImg.first?.stringToImage({ [weak self] (image)  in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.itemPic.image = image
            }
            
        })
        marketPic.stringToImage { [weak self] (image) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.marketPic.image = image
            }
        }
    }
}


