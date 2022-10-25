//
//  SearchResultViewController.swift
//  CashBackApp
//
//  Created by Eldar Garbuzov on 11.10.22.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    
    let apiManagerDelegate: RestAPIProviderProtocol = APIManager()
    
    @IBOutlet weak var searchResultTableView: UITableView!
    
    var searchResultModel: [Product]?
    var searchResultModelCompany: [JSONAny]? //пока избыточная переменная, в процессе работы над магазинами, которые вовзаращет api. Не решено ещё преобразовывать всё в массив или работать через словарь как есть.
    var counter: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        searchResultTableView.register(UINib(nibName: "SearchResultTableViewCell", bundle: nil), forCellReuseIdentifier: SearchResultTableViewCell.key)
        searchResultTableView.register(UINib(nibName: "CompaniesTableViewCell", bundle: nil), forCellReuseIdentifier: CompaniesTableViewCell.key)
    }
}
