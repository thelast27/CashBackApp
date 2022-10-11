//
//  ViewController.swift
//  CashBackApp
//
//  Created by Eldar Garbuzov on 11.10.22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBarView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarView.layer.cornerRadius = 28
        searchBarView.clipsToBounds = true
        
    }

    @IBAction func searchButtonPressed(_ sender: Any) {
        
    }
    

}

