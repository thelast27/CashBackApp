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
    var searchResultModelCompany: [JSONAny]?
    var searchResultsArray: [SearchResult]?
    var apiManagerDelegate: RestAPIProviderProtocol = APIManager()
    var indicator = UIActivityIndicatorView()
    
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
        
        indicator = activityIndicator(style: .large, frame: nil, center: self.view.center)
        indicator.color = .purple
        view.addSubview(indicator)

        
        
    }
    //MARK: - задали размеры и позицию indicator
    private func activityIndicator(style: UIActivityIndicatorView.Style = .medium,
                                       frame: CGRect? = nil,
                                       center: CGPoint? = nil) -> UIActivityIndicatorView {
        
        let activityIndicatorView = UIActivityIndicatorView(style: style)
        if let frame = frame {
            activityIndicatorView.frame = frame
        }
        if let center = center {
            activityIndicatorView.center = center
        }
        return activityIndicatorView
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
        indicator.startAnimating()
        
        let text = serachHistory[indexPath.row]
        apiManagerDelegate.getSearchResults(for: text) { [weak self] resultsData in
            guard let self = self else { return }
            self.searchResultModel = resultsData.products
            self.searchResultsArray?.append(resultsData)
        }
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 3) { [weak self] in
            guard let self = self else { return }
            guard let vc = UIStoryboard(name: "SearchResultsStoryboard", bundle: nil).instantiateViewController(withIdentifier: "SearchResultVC") as? SearchResultViewController else { return }
            vc.searchResultModel = self.searchResultModel
            vc.tableViewSearchResultArray = self.searchResultsArray
            vc.title = text
            self.navigationController?.pushViewController(vc, animated: true
            )
            self.indicator.stopAnimating()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - функция, срабатывающая по нажатию кнопки Return в SearchBar
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        indicator.startAnimating()
        
        guard let text = searchBar.text,
              let vc = UIStoryboard(name: "SearchResultsStoryboard", bundle: nil).instantiateViewController(withIdentifier: "SearchResultVC") as? SearchResultViewController
        else { return }
        
        serachHistory.append(text) //сохранили запрос в историю. Лучше хранить в БД, но для примера сойдет.
        
        apiManagerDelegate.getSearchResults(for: text) { [weak self] resultsData in
            guard let self = self else { return }
            self.searchResultModel = resultsData.products //передали дату о запрашиваемом предмете
            self.searchResultModelCompany = resultsData.campaigns
            self.searchResultsArray?.append(resultsData) //для чего передаю?
            vc.searchResultModel = self.searchResultModel
            vc.searchResultModelCompany = self.searchResultModelCompany
            DispatchQueue.main.async {
                vc.title = text
            }
            
        }
        previousSearchTableView.reloadData()
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 3) { [weak self] in
            guard let self = self else { return }
            self.navigationController?.pushViewController(vc, animated: true
            )
            self.indicator.stopAnimating()
        }
    }
}




