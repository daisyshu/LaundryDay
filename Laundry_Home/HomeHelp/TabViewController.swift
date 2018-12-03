//
//  TabViewController.swift
//  Laundry_Home
//
//  Created by Sage Lee on 12/1/18.
//  Copyright © 2018 Sage Lee. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController, UITabBarControllerDelegate {
    
    var homeIcon: UIImage!
    var listIcon: UIImage!
    var profileIcon: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        homeIcon = UIImage(named: "homeicon")
        let tabOne = UINavigationController(rootViewController: HomeViewController())
        let tabOneBarItem = UITabBarItem(title: "home", image: nil, tag: 0)
        tabOne.tabBarItem = tabOneBarItem
        
        let tabTwo = UINavigationController(rootViewController: ListViewController())
        let tabTwoBarItem = UITabBarItem(title: "list", image: nil, tag: 1)
        tabTwo.tabBarItem = tabTwoBarItem
        
        let tabThree = UINavigationController(rootViewController: ProfileViewController())
        let tabThreeBarItem = UITabBarItem(title: "profile", image: nil, tag: 2)
        tabThree.tabBarItem = tabThreeBarItem
        
        self.viewControllers = [tabOne, tabTwo, tabThree]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }


}
