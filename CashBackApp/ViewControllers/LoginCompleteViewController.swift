//
//  LoginCompleteViewController.swift
//  CashBackApp
//
//  Created by Eldar Garbuzov on 19.10.22.
//

import UIKit

class LoginCompleteViewController: UIViewController {
    
    private let bottomLine = CALayer()
    private let apiManagerDelegate: RestAPIProviderProtocol = APIManager()
    
    @IBOutlet weak var explainTextLabel: UITextView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var callAgainButton: UIButton!
    
    var number: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //также настроили полоску под полосой на этот раз ввода кода
        bottomLine.frame = CGRect(x: 0.0, y: passwordTextField.frame.height - 1, width: passwordTextField.frame.width - 15, height: 1.0)
        bottomLine.backgroundColor = UIColor.gray.cgColor
        passwordTextField.borderStyle = UITextField.BorderStyle.none
        passwordTextField.layer.addSublayer(bottomLine)

        callAgainButton.isEnabled = false //деактивировали кнопку повторного звонка
        DispatchQueue.main.asyncAfter(deadline: .now() + 60) { //через минуту разрешаем снова отправить звонок для кода
            self.callAgainButton.isEnabled = true
        }
        
    }
    
    @IBAction func sendRequestAgainPressed(_ sender: Any) {
        
        guard let number = number else { return }
        apiManagerDelegate.sendLoginNumber(for: number) { login in //с Вашей разрешения ничего не обрабатываю т.к. нет возможности ввести свой белорусский номер и проверить. 
        }
    }
}
