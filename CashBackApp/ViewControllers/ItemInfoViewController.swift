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
        
        
        if let clickedItem = clickedElement?.imageUrls {
            clickedItem.first?.stringToImage({ (image)  in
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        } else {
            if hiddenSections.contains(section) {
                return 0
            }
            return clickedElement?.actions?.count ?? 1
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemInfoTableViewCell.key, for: indexPath) as? ItemInfoTableViewCell else { return UITableViewCell() }
            if let productInfo = clickedElement {
                cell.configuration(data: productInfo)
            }
            return cell
            
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ConditionsTableViewCell.key, for: indexPath) as? ConditionsTableViewCell else { return UITableViewCell() }
            cell.cashBackLabel.text = clickedElement?.actions?.first?.value
            cell.actionTextLabel.text = clickedElement?.actions?.first?.text
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ConditionsTableViewCell.key, for: indexPath) as? ConditionsTableViewCell else { return UITableViewCell() }
            cell.cashBackLabel.text = clickedElement?.actions?[indexPath.row].value
            cell.actionTextLabel.text = clickedElement?.actions?[indexPath.row].text
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
        
        if section == 0 {
            return nil
        } else if section == 1 {
            
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 20))
            
            let label = UILabel()
            label.frame = CGRect.init(x: 16, y: 0, width: headerView.frame.width, height: headerView.frame.height)
            label.text = "Условия"
            label.font = .boldSystemFont(ofSize: 20)
            label.textColor = .black
            
            headerView.addSubview(label)
            
            return headerView
        } else {
            
            let sectionButton = UIButton()
            
            sectionButton.setTitle(String("Развернуть"),
                                   for: .normal)
            sectionButton.setTitleColor(.blue, for: .normal)
            
            sectionButton.tag = section
            sectionButton.addTarget(self,
                                    action: #selector(self.hideSection(sender:)),
                                    for: .touchUpInside)
            
            return sectionButton
        }
        
    }
    
    @objc
    private func hideSection(sender: UIButton) {
        let section = sender.tag
        
        func indexPathsForSection() -> [IndexPath] {
            var indexPaths = [IndexPath]()
            
            for row in 0..<(self.clickedElement?.actions?.count ?? 1) {
                indexPaths.append(IndexPath(row: row,
                                            section: section))
            }
            
            return indexPaths
        }
        
        if self.hiddenSections.contains(section) {
            self.hiddenSections.remove(section)
            self.conditionsTableView.insertRows(at: indexPathsForSection(),
                                                with: .fade)
        } else {
            self.hiddenSections.insert(section)
            self.conditionsTableView.deleteRows(at: indexPathsForSection(),
                                                with: .fade)
        }
    }
    
    
}
