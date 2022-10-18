//
//  LoginViewController.swift
//  CashBackApp
//
//  Created by Eldar Garbuzov on 18.10.22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var viewForButton: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewForButton.layer.cornerRadius = 30
        viewForButton.clipsToBounds = true
    }
    

}
