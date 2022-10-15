//
//  TabbarController.swift
//  Pizenatto
//
//  Created by Сергей Штейман on 14.10.2022.
//

import UIKit

final class TabbarController: UITabBarController {
    
    private let moduleBuilder: Buildable
    
    init(moduleBuilder: Buildable) {
        self.moduleBuilder = moduleBuilder
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupController()
    }
    
    private func setupController() {
        
        let catlogViewController = UINavigationController(rootViewController: moduleBuilder.makeCatalogViewController())
        let secondViewController = UIViewController()
        let thirdViewController = UIViewController()
        let fourthViewController = UIViewController()
        
        catlogViewController.tabBarItem.title = "Меню"
        secondViewController.tabBarItem.title = "Контакты"
        thirdViewController.tabBarItem.title = "Профиль"
        fourthViewController.tabBarItem.title = "Корзина"
        
        catlogViewController.tabBarItem.image = UIImage(named: "menu")
        secondViewController.tabBarItem.image = UIImage(named: "vector")
        thirdViewController.tabBarItem.image = UIImage(named: "profile")
        fourthViewController.tabBarItem.image = UIImage(named: "trash")
        
        viewControllers = [
            catlogViewController,
            secondViewController,
            thirdViewController,
            fourthViewController
        ]
        
        UITabBar.appearance().tintColor = .red
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)], for: .normal)
    }
}
