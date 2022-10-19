//
//  LoginViewController.swift
//  CashBackApp
//
//  Created by Eldar Garbuzov on 18.10.22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var viewForButton: UIView!
    @IBOutlet weak var numberTextField: UITextField!
    
    var bottomLine = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewForButton.layer.cornerRadius = 30
        viewForButton.clipsToBounds = true
        
        bottomLine.frame = CGRect(x: 0.0, y: numberTextField.frame.height - 1, width: numberTextField.frame.width - 15, height: 1.0)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        numberTextField.borderStyle = UITextField.BorderStyle.none
        numberTextField.layer.addSublayer(bottomLine)

    }
    

}
