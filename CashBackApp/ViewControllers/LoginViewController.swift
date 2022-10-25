//
//  LoginViewController.swift
//  CashBackApp
//
//  Created by Eldar Garbuzov on 18.10.22.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let bottomLine = CALayer()
    private let apiManagerDelegate: RestAPIProviderProtocol = APIManager()

    @IBOutlet weak var viewForButton: UIView!
    @IBOutlet weak var numberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewForButton.layer.cornerRadius = 30
        viewForButton.clipsToBounds = true
        
        //настраиваем полоску под полем ввода номера
        bottomLine.frame = CGRect(x: 0.0, y: numberTextField.frame.height - 1, width: numberTextField.frame.width - 15, height: 1.0)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        numberTextField.borderStyle = UITextField.BorderStyle.none
        numberTextField.layer.addSublayer(bottomLine)
        
    }
    @IBAction func sendNumberPressed(_ sender: Any) { //запрашивем проверку у сервера по введенному номеру
        guard numberTextField.hasText,
              let number = numberTextField.text
        else { return }
        guard let vc = UIStoryboard(name: "LoginStoryboard", bundle: nil).instantiateViewController(withIdentifier: "LoginCompleteVC") as? LoginCompleteViewController else { return }
        apiManagerDelegate.sendLoginNumber(for: number) { login in
            guard let explainMessage = login.explainMessage else { return }
            DispatchQueue.main.async {
                vc.explainTextLabel.text = explainMessage
                vc.number = number
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
