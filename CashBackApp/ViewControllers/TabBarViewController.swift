//
//  TabBarViewController.swift
//  CashBackApp
//
//  Created by Eldar Garbuzov on 18.10.22.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let startVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StartVC") as? StartViewController, let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StartVC") as? StartViewController else {return}
        
        
        viewControllers = [addViewController(viewController: UINavigationController(rootViewController: startVC), title: "Магазины", image: UIImage(systemName: "bag")), addViewController(viewController: UINavigationController(rootViewController: loginVC), title: "Кабинет", image: UIImage(systemName: "person.circle"))]
    }
    
    
    private func addViewController(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
        
    }
}
