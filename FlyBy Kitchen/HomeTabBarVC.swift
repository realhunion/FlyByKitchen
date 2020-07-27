//
//  HomeTabBarVC.swift
//  FlyBy Kitchen
//
//  Created by Hunain Ali on 7/10/20.
//  Copyright © 2020 BUMP. All rights reserved.
//

import UIKit
import Firebase
import SwiftEntryKit

enum Tabs: Int {
    case followingClubs = 0
    case campusClubs = 1
    case categories = 2
}

class HomeTabBarVC: UITabBarController, UITabBarControllerDelegate {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        self.delegate = self
        
        self.tabBar.isTranslucent = false
    }
    
    func shutDown() {
        
        ordersVC.shutDown()
        editMenuVC.shutDown()
        settingsVC.shutDown()
        
    }
    
    
    
    
    var ordersVC = OrdersVC()
    var editMenuVC = EditMenuVC(style: .plain)
    var settingsVC = SettingsVC(style: .plain)
    
    func setupTabBar() {
        
        ordersVC.title = "Orders - Live"
        editMenuVC.title = "Edit Menu"
        settingsVC.title = "Settings"
        
        settingsVC.navigationController?.navigationBar.prefersLargeTitles = true
        
        let nc1 = UINavigationController(rootViewController: ordersVC)
        let nc2 = UINavigationController(rootViewController: editMenuVC)
        let nc3 = UINavigationController(rootViewController: settingsVC)
        
//        followingClubsNC.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkText]
//        campusClubsNC.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkText]
//        nc3.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkText]
        
        
        let icon1 =  UIImage(named: "receptionIcon")?.resizedImage(newSize: CGSize(width: 30, height: 30))
        let icon2 = UIImage(named: "menuIcon")?.resizedImage(newSize: CGSize(width: 30, height: 30))
        let icon3 = UIImage(named: "settingsIcon")?.resizedImage(newSize: CGSize(width: 30, height: 30))
        
        let item1 = UITabBarItem(title: "Orders", image: icon1, selectedImage: nil)
        let item2 = UITabBarItem(title: "Edit Menu", image: icon2, selectedImage: nil)
        let item3 = UITabBarItem(title: "Settings", image: icon3, selectedImage: nil)
        
//        let followingClubsItem = UITabBarItem(title: "Campus", image: nil, selectedImage: nil)
//        let campusClubsItem = UITabBarItem(title: "Launch", image: campusImage, selectedImage: nil)
//        let categoriesItem = UITabBarItem(title: "Categories", image: categoriesImage, selectedImage: nil)
        
//        let item1 = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
//        let item2 = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
//        let item3 = UITabBarItem(tabBarSystemItem: .downloads, tag: 2)
//
        
        item1.tag = 0
        item2.tag = 1
        item3.tag = 2
        
        ordersVC.tabBarItem = item1
        editMenuVC.tabBarItem = item2
        settingsVC.tabBarItem = item3
        
        let tabBarControllers = [nc1, nc2, nc3]
        self.viewControllers = tabBarControllers
        self.selectedIndex = currentIndex
        
    }
    
    
    
    
    var currentIndex : Int = 1
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        currentIndex = selectedIndex
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
    
    
    
    
}
