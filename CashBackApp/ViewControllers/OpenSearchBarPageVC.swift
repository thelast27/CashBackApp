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
    var searchResultModel: [Product]?
    var searchResultsArray: [SearchResult]?
    var apiManagerDelegate: RestAPIProviderProtocol = APIManager()
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let text = serachHistory[indexPath.row]
        apiManagerDelegate.getSearchResults(for: text) { [weak self] resultsData in
            guard let self = self else { return }
            self.searchResultModel = resultsData.products
            self.searchResultsArray?.append(resultsData)
        }
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            guard let vc = UIStoryboard(name: "SearchResultsStoryboard", bundle: nil).instantiateViewController(withIdentifier: "SearchResultVC") as? SearchResultViewController else { return }
            vc.searchResultModel = self.searchResultModel
            vc.tableViewSearchResultArray = self.searchResultsArray
            vc.title = text
            self.navigationController?.pushViewController(vc, animated: true
            )
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text else { return }
        serachHistory.append(text)
        apiManagerDelegate.getSearchResults(for: text) { [weak self] resultsData in
            guard let self = self else { return }
            self.searchResultModel = resultsData.products
            self.searchResultsArray?.append(resultsData)
        }
        previousSearchTableView.reloadData()
    
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 5) { [weak self] in
            guard let self = self else { return }
            guard let vc = UIStoryboard(name: "SearchResultsStoryboard", bundle: nil).instantiateViewController(withIdentifier: "SearchResultVC") as? SearchResultViewController else { return }
            vc.searchResultModel = self.searchResultModel
            vc.tableViewSearchResultArray = self.searchResultsArray
            vc.title = text
            self.navigationController?.pushViewController(vc, animated: true
            )
        }
        
    }
}




