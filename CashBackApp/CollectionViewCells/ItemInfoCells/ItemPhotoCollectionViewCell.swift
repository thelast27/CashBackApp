//
//  ItemPhotoCollectionViewCell.swift
//  CashBackApp
//
//  Created by Eldar Garbuzov on 13.10.22.
//

import UIKit

class ItemPhotoCollectionViewCell: UICollectionViewCell {
    
    static var key = "ItemPhotoCollectionViewCell"

    @IBOutlet weak var imagePhoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configuration(data: Product) {
        
        guard let itemImg = data.imageUrls else { return }
        
        itemImg.first?.stringToImage({ [weak self] (image)  in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.imagePhoto.image = image
            }
        })
    }
}
