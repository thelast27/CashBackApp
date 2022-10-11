//
//  ViewController.swift
//  CashBackApp
//
//  Created by Eldar Garbuzov on 11.10.22.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var searchBarView: UIView!
    
    
    @IBOutlet weak var marketsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
//        marketsTableView.frame = CGRect(x: searchBarView.frame.minX, y: searchBarView.frame.maxY + 10, width: view.frame.minX, height: view.frame.maxY)
        marketsTableView.delegate = self
        marketsTableView.dataSource = self
        marketsTableView.register(UINib(nibName: "MainScreenMarketsTableViewCell", bundle: nil), forCellReuseIdentifier: MainScreenMarketsTableViewCell.key)
        
        searchBarView.layer.cornerRadius = 32
        searchBarView.clipsToBounds = true
        
//        view.addSubview(marketsTableView)
    }

    @IBAction func searchButtonPressed(_ sender: Any) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OpenSearchBarPage") as? OpenSearchBarPageVC else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
    

}

extension StartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Магазины"
    }
    
    
}
