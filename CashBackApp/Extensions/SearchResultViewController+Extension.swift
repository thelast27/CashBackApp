//
//  SearchResultViewController+Extension.swift
//  CashBackApp
//
//  Created by Eldar Garbuzov on 25.10.22.
//

import Foundation
import UIKit

extension SearchResultViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchResultModelCompany?.isEmpty == false { //проверяю не запросил ли юзей магазины. если да, добавляю одну ячейку в доп сецию.
            if section == 0 {
                return 1
            }
            
        }
        return searchResultModel?.count ?? 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if searchResultModelCompany?.isEmpty == true { //тот же принцип, что и выше
            return 1
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if searchResultModelCompany?.isEmpty == false { //если прилетели магазины - создаю для них ячейку в новой секции, а оставшуюся выдачу - ниже
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
            
        } //если не прилетели магазины, а был запрос на какой-то item
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.key, for: indexPath) as? SearchResultTableViewCell else { return UITableViewCell() }
        if let searchedTerm = searchResultModel {
            cell.configuration(data: searchedTerm[indexPath.row])
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let vc = UIStoryboard(name: "ItemInfoStoryboard", bundle: nil).instantiateViewController(withIdentifier: "ItemInfoVC") as? ItemInfoViewController else { return }
        vc.searchResultModel = searchResultModel
        vc.clickedElement = searchResultModel?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { //футер только для той секции, где кнопка "ещё"
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
        //MARK: - работаем с кнопкой, инициализация:
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
    
    @objc func loadMore(sender: UIButton) { //сам метод для кнопки "ещё"
        
        counter += 1 //каунтер для демонстрации. Вообще я бы создал нужную проперти в модели БД и использовал её
        
        apiManagerDelegate.getMoreSearchResults(for: title ?? "", for: counter) { data in //просим у сервера ещё страницу
            guard let searchedData = data.products else { return }
            self.searchResultModel?.append(contentsOf: searchedData)
            DispatchQueue.main.async {
                self.searchResultTableView.reloadData()
            }
        }
    }
}

