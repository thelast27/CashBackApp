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
    var hiddenSections = Set<Int>()
    var actionsArray: [Action] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemPhoto.delegate = self
        itemPhoto.dataSource = self
        itemPhoto.register(UINib(nibName: "ItemPhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ItemPhotoCollectionViewCell.key)
        
        conditionsTableView.delegate = self
        conditionsTableView.dataSource = self
        conditionsTableView.register(UINib(nibName: "ConditionsTableViewCell", bundle: nil), forCellReuseIdentifier: ConditionsTableViewCell.key)
        conditionsTableView.register(UINib(nibName: "ItemInfoTableViewCell", bundle: nil), forCellReuseIdentifier: ItemInfoTableViewCell.key)
        
        itemPhotoPageControl.numberOfPages = clickedElement?.imageUrls?.count ?? 1
        
        guard let firstAction = clickedElement?.actions?.first else { return }
        actionsArray.append(firstAction)
        
    }

}

extension ItemInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Создаем collectionView для clickedItem.imageUrls
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        clickedElement?.imageUrls?.count ?? 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemPhotoCollectionViewCell.key, for: indexPath) as? ItemPhotoCollectionViewCell else { return
            UICollectionViewCell() }
        
        
        if let clickedItem = clickedElement?.imageUrls?[indexPath.row] {
            clickedItem.stringToImage({ (image)  in
                DispatchQueue.main.async {
                    cell.imagePhoto.image = image
                }
            })
        }
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = round(itemPhoto.contentOffset.x/view.frame.width)
        itemPhotoPageControl.currentPage = Int(pageIndex)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 360, height: 190)
    }
    
    //MARK: - Создаем tableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // было 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return actionsArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemInfoTableViewCell.key, for: indexPath) as? ItemInfoTableViewCell else { return UITableViewCell() }
            if let productInfo = clickedElement {
                cell.configuration(data: productInfo)
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ConditionsTableViewCell.key, for: indexPath) as? ConditionsTableViewCell else { return UITableViewCell() }
            cell.cashBackLabel.text = actionsArray[indexPath.row].value
            cell.actionTextLabel.text = actionsArray[indexPath.row].text
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 270
        } else if indexPath.section == 2 && indexPath.row == 0 {
            return 0
        } else {
            return 40
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else if section == 1 {
            return 15
        } else {
            return 25
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let actionsQty = clickedElement?.actions?.count else { return UIView() }
        if actionsQty > 1 {
            let sectionButton = UIButton()
            sectionButton.setTitle(String("Развернуть"),
                                   for: .normal)
            sectionButton.setTitleColor(.blue, for: .normal)
            sectionButton.tag = section
            sectionButton.addTarget(self,
                                    action: #selector(self.hideRows(sender:)),
                                    for: .touchUpInside)
            return sectionButton
        } else {
            return UIView()
        }
        
        
    }
    
    @objc
    private func hideRows(sender: UIButton) {
        
        guard let newActions = clickedElement?.actions?.dropFirst() else { return }
        if actionsArray.count == 1 {
            actionsArray.insert(contentsOf: newActions, at: 1)
            conditionsTableView.reloadData()
        } else {
            actionsArray.removeLast(newActions.count)
            conditionsTableView.reloadData()
        }
        
        
    }
    
    
}
