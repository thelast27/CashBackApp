//
//  CompaniesTableViewCell+Extension.swift
//  CashBackApp
//
//  Created by Eldar Garbuzov on 25.10.22.
//

import Foundation
import UIKit

extension CompaniesTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchModelCompanies?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompaniesCollectionViewCell.key, for: indexPath) as? CompaniesCollectionViewCell else { return
            UICollectionViewCell() }
        if let companiesData = searchModelCompanies {
            cell.configuration(data: companiesData[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            
        return UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
}
