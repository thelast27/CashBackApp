//
//  ItemInfoViewController.swift
//  CashBackApp
//
//  Created by Eldar Garbuzov on 13.10.22.
//

import UIKit

class ItemInfoViewController: UIViewController {
    
    @IBOutlet weak var itemPhoto: UICollectionView!
    @IBOutlet weak var conditionsTableView: UITableView!
    @IBOutlet weak var itemPhotoPageControl: UIPageControl!
    
    var tableViewSearchResultArray: [SearchResult]?
    var searchResultModel: [Product]?
    var clickedElement: Product?
    var actionsArray: [Action] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //добавили делегаты и ячейку для коллекшнВью с фото предмета
        itemPhoto.delegate = self
        itemPhoto.dataSource = self
        itemPhoto.register(UINib(nibName: "ItemPhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ItemPhotoCollectionViewCell.key)
        
        //добавили делегаты и ячейки для табицы с инфо о предмете
        conditionsTableView.delegate = self
        conditionsTableView.dataSource = self
        conditionsTableView.register(UINib(nibName: "ConditionsTableViewCell", bundle: nil), forCellReuseIdentifier: ConditionsTableViewCell.key)
        conditionsTableView.register(UINib(nibName: "ItemInfoTableViewCell", bundle: nil), forCellReuseIdentifier: ItemInfoTableViewCell.key)
        
        itemPhotoPageControl.numberOfPages = clickedElement?.imageUrls?.count ?? 1
        
        guard let firstAction = clickedElement?.actions?.first else { return }
        actionsArray.append(firstAction)
        
    }

}
