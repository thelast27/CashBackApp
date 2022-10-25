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
    var searchResultModelCompany: [JSONAny]?
    
    private let apiManagerDelegate: RestAPIProviderProtocol = APIManager()
    private var counter: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        searchResultTableView.register(UINib(nibName: "SearchResultTableViewCell", bundle: nil), forCellReuseIdentifier: SearchResultTableViewCell.key)
        searchResultTableView.register(UINib(nibName: "CompaniesTableViewCell", bundle: nil), forCellReuseIdentifier: CompaniesTableViewCell.key)
    }
}

extension SearchResultViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchResultModelCompany?.isEmpty == false {
            if section == 0 {
                return 1
            }
            
        }
        return searchResultModel?.count ?? 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if searchResultModelCompany?.isEmpty == true {
            return 1
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if searchResultModelCompany?.isEmpty == false {
            if indexPath.section == 0 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CompaniesTableViewCell.key, for: indexPath) as? CompaniesTableViewCell else { return UITableViewCell() }
                if let companiesData = searchResultModel {
                    cell.searchModelCompanies = companiesData
                }
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.key, for: indexPath) as? SearchResultTableViewCell else { return UITableViewCell() }
                if let searchedTerm = searchResultModel {
                    cell.configuration(data: searchedTerm[indexPath.row])
                }
                return cell
            }
            
        }
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
        if searchResultModelCompany?.isEmpty == false {
            if section == 0 {
                return 0
            }
        }
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if searchResultModelCompany?.isEmpty == false {
            if section == 0 {
                return nil
            }
        }
        
        let sectionButton = UIButton()
        sectionButton.setTitle(String("Ещё"),
                               for: .normal)
        sectionButton.setTitleColor(.blue, for: .normal)
        sectionButton.addTarget(self,
                                action: #selector(self.loadMore(sender:)),
                                for: .touchUpInside)
        return sectionButton
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if searchResultModelCompany?.isEmpty == false {
            if indexPath.section == 0 {
                return 150
            }
        }
        return 120
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
