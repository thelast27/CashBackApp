//
//  LoginCompleteViewController.swift
//  CashBackApp
//
//  Created by Eldar Garbuzov on 19.10.22.
//

import UIKit

class LoginCompleteViewController: UIViewController {
    
    private let bottomLine = CALayer()
    @IBOutlet weak var explainTextLabel: UITextView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var callAgainButton: UIButton!
    private var apiManagerDelegate: RestAPIProviderProtocol = APIManager()
    var number: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomLine.frame = CGRect(x: 0.0, y: passwordTextField.frame.height - 1, width: passwordTextField.frame.width - 15, height: 1.0)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        passwordTextField.borderStyle = UITextField.BorderStyle.none
        passwordTextField.layer.addSublayer(bottomLine)

        
        callAgainButton.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
            self.callAgainButton.isEnabled = true
        }
        
    }
    
    @IBAction func sendRequestAgainPressed(_ sender: Any) {
        
        guard let number = number else { return }
        apiManagerDelegate.sendLoginNumber(for: number) { login in
        }
    }
}
