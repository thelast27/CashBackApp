//
//  ViewController.swift
//  CashBackApp
//
//  Created by Eldar Garbuzov on 11.10.22.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBarView.layer.cornerRadius = 32
        searchBarView.clipsToBounds = true
        
        loginButton.layer.cornerRadius = 15
        loginButton.clipsToBounds = true

    }

    @IBAction func searchButtonPressed(_ sender: Any) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OpenSearchBarPage") as? OpenSearchBarPageVC else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
    

}

