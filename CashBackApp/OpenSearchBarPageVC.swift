//
//  OpenSearchBarPageVC.swift
//  CashBackApp
//
//  Created by Eldar Garbuzov on 11.10.22.
//

import UIKit

class OpenSearchBarPageVC: UIViewController {
    
    lazy var searchBar: UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.maxX, height: 30))
    var serachHistory: [String] = []
    let previousSearchTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        previousSearchTableView.frame = CGRect(x: view.frame.minX, y: searchBar.frame.maxY, width: view.frame.maxX, height: view.frame.maxY)
        
        previousSearchTableView.delegate = self
        previousSearchTableView.dataSource = self
        previousSearchTableView.register(UINib(nibName: "PreviousSearchTableViewCell", bundle: nil), forCellReuseIdentifier: PreviousSearchTableViewCell.key)
        
        
        searchBar.delegate = self
        searchBar.showsSearchResultsButton = true
        searchBar.placeholder = "Поиск магазинов, товаров"
        let rightNavBarButton = UIBarButtonItem(customView: searchBar)
        self.navigationItem.rightBarButtonItem = rightNavBarButton
        
        view.addSubview(previousSearchTableView)
    
    }
    
 
}

extension OpenSearchBarPageVC: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        serachHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PreviousSearchTableViewCell.key, for: indexPath) as? PreviousSearchTableViewCell else { return UITableViewCell() }
        cell.previousSearchedItem.text = serachHistory[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Вы недавно искали"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        serachHistory.append(text)
        previousSearchTableView.reloadData()
    }
}




