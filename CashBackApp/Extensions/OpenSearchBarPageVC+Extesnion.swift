//
//  OpenSearchBarPageVC+Extesnion.swift
//  CashBackApp
//
//  Created by Eldar Garbuzov on 25.10.22.
//

import Foundation
import UIKit

extension OpenSearchBarPageVC: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    //MARK: - таблица с историей запросов
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // по клику на историю запроса деает запрос к апи
        indicator.startAnimating()
        guard let vc = UIStoryboard(name: "SearchResultsStoryboard", bundle: nil).instantiateViewController(withIdentifier: "SearchResultVC") as? SearchResultViewController else { return }
        
        let text = serachHistory[indexPath.row]
        apiManagerDelegate.getSearchResults(for: text) { [weak self] resultsData in
            guard let self = self else { return }
            self.searchResultModel = resultsData.products
            vc.searchResultModel = self.searchResultModel
            DispatchQueue.main.async {
                vc.title = text
            }
        }
        repeat {
            self.indicator.startAnimating()
        } while vc.searchResultModel == nil
        self.navigationController?.pushViewController(vc, animated: true
        )
        
        self.indicator.stopAnimating()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - функция, срабатывающая по нажатию кнопки Return в SearchBar
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        indicator.startAnimating()
        
        guard let text = searchBar.text,
              let vc = UIStoryboard(name: "SearchResultsStoryboard", bundle: nil).instantiateViewController(withIdentifier: "SearchResultVC") as? SearchResultViewController
        else { return }
        
        serachHistory.append(text) //сохранили запрос в историю. Лучше хранить в БД, но для примера сойдет.
        
        apiManagerDelegate.getSearchResults(for: text) { [weak self] resultsData in //передаем на след экран все необходимые данные по запросу ползователя. 
            guard let self = self else { return }
            self.searchResultModel = resultsData.products
            self.searchResultModelCompany = resultsData.campaigns
            vc.searchResultModel = self.searchResultModel
            vc.searchResultModelCompany = self.searchResultModelCompany
            DispatchQueue.main.async {
                vc.title = text
            }
            
        }
        previousSearchTableView.reloadData()
        
        repeat {
            indicator.startAnimating()
        } while vc.searchResultModel == nil
        self.navigationController?.pushViewController(vc, animated: true
        )
        self.indicator.stopAnimating()
        
    }
}
