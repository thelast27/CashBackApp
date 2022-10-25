//
//  OpenSearchBarPageVC.swift
//  CashBackApp
//
//  Created by Eldar Garbuzov on 11.10.22.
//

import UIKit

class OpenSearchBarPageVC: UIViewController {
    
    let previousSearchTableView = UITableView()
    
    lazy private var searchBar: UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.frame.maxX, height: 30))
    var serachHistory: [String] = []
    var searchResultModel: [Product]?
    var searchResultModelCompany: [JSONAny]? //пока избыточная переменная, в процессе работы над магазинами, которые вовзаращет api. Не решено ещё преобразовывать всё в массив или работать через словарь как есть. 
    var apiManagerDelegate: RestAPIProviderProtocol = APIManager()
    var indicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //задали размеры, делегаты и зарегали ячейку для таблицы с историей запросов
        
        previousSearchTableView.frame = CGRect(x: view.frame.minX, y: searchBar.frame.maxY, width: view.frame.maxX, height: view.frame.maxY)
        previousSearchTableView.delegate = self
        previousSearchTableView.dataSource = self
        previousSearchTableView.register(UINib(nibName: "PreviousSearchTableViewCell", bundle: nil), forCellReuseIdentifier: PreviousSearchTableViewCell.key)
        
        //задали параметры и делегаты для серчбара
        searchBar.delegate = self
        searchBar.showsSearchResultsButton = true
        searchBar.placeholder = "Поиск магазинов, товаров"
        let rightNavBarButton = UIBarButtonItem(customView: searchBar)
        self.navigationItem.rightBarButtonItem = rightNavBarButton
        
        view.addSubview(previousSearchTableView)
        
        //настроили активити спинер
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

