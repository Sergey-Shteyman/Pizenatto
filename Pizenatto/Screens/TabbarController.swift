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
        secondViewController.tabBarItem.title = "Меню 1"
        thirdViewController.tabBarItem.title = "Меню 2"
        fourthViewController.tabBarItem.title = "Меню 3"
        
        catlogViewController.tabBarItem.image = UIImage(named: "vector")
        secondViewController.tabBarItem.image = UIImage(systemName: "person")
        thirdViewController.tabBarItem.image = UIImage(systemName: "house")
        fourthViewController.tabBarItem.image = UIImage(systemName: "heart")
        
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
