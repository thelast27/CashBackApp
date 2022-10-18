//
//  SearchResultViewController.swift
//  CashBackApp
//
//  Created by Eldar Garbuzov on 11.10.22.
//

import UIKit

class SearchResultViewController: UIViewController {

    @IBOutlet weak var searchResultTableView: UITableView!
    
    var tableViewSearchResultArray: [SearchResult]?
    var searchResultModel: [Product]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        searchResultTableView.register(UINib(nibName: "SearchResultTableViewCell", bundle: nil), forCellReuseIdentifier: SearchResultTableViewCell.key)
    }
}

extension SearchResultViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultModel?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.key, for: indexPath) as? SearchResultTableViewCell else { return UITableViewCell() }
        if let searchedTerm = searchResultModel {
            cell.configuration(data: searchedTerm[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let vc = UIStoryboard(name: "ItemInfoStoryboard", bundle: nil).instantiateViewController(withIdentifier: "ItemInfoVC") as? ItemInfoViewController else { return }
        vc.searchResultModel = searchResultModel
        vc.tableViewSearchResultArray = tableViewSearchResultArray
        vc.clickedElement = searchResultModel?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
