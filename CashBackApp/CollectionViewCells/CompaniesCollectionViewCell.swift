//
//  CompaniesCollectionViewCell.swift
//  CashBackApp
//
//  Created by Eldar Garbuzov on 24.10.22.
//

import UIKit

class CompaniesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cashBackBackgound: UIView!
    @IBOutlet weak var cashBackLabel: UILabel!
    
    static var key = "CompaniesCollectionViewCell"
    var searchResultCompanies: [Product]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cashBackBackgound.layer.cornerRadius = 12
        cashBackBackgound.clipsToBounds = true
        
        //настроили тени для ячейки
        self.layer.cornerRadius = 15.0
        self.layer.borderWidth = 1.0
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = true
    }
    
    func configuration(data: Product) {
        guard let persentLabel = data.cashback,
              let image = data.campaignImageURL
        else { return }
        cashBackLabel.text = persentLabel
        
        image.stringToImage { [weak self] (image) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
    
    
}
