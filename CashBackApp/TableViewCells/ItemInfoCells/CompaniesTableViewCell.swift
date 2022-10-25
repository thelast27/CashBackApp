//
//  CompaniesTableViewCell.swift
//  CashBackApp
//
//  Created by Eldar Garbuzov on 24.10.22.
//

import UIKit

class CompaniesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var companiesCollectionView: UICollectionView!
    var searchModelCompanies: [Product]?
    
    static var key = "CompaniesTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        companiesCollectionView.delegate = self
        companiesCollectionView.dataSource = self
        companiesCollectionView.register(UINib(nibName: "CompaniesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CompaniesCollectionViewCell.key)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
