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
    private let apiManagerDelegate: RestAPIProviderProtocol = APIManager()
    private var counter: Int = 0
    
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
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let sectionButton = UIButton()
        sectionButton.setTitle(String("Ещё"),
                               for: .normal)
        sectionButton.setTitleColor(.blue, for: .normal)
        sectionButton.addTarget(self,
                                action: #selector(self.loadMore(sender:)),
                                for: .touchUpInside)
        return sectionButton
    }
    
    @objc func loadMore(sender: UIButton) {
        
        counter += 1 //каунтер для демонстрации. Вообще я бы создал нужную проперти в модели БД и использовал её
        
        apiManagerDelegate.getMoreSearchResults(for: title ?? "", for: counter) { data in
            guard let searchedData = data.products else { return }
            self.searchResultModel?.append(contentsOf: searchedData)
            DispatchQueue.main.async {
                self.searchResultTableView.reloadData()
            }
        }
    }
}
