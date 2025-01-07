//
//  TabBarViewController.swift
//  ProjectX
//
//  Created by Batch - 1 on 07/01/25.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let home = UINavigationController(rootViewController: HomeViewController())
        let search = UINavigationController(rootViewController: SearchViewController())
        let schedule = UINavigationController(rootViewController: ScheduleViewController())
        let progress = UINavigationController(rootViewController: ProgressViewController())
        let connect = UINavigationController(rootViewController: ConnectViewController())
        
        home.tabBarItem.image = UIImage(systemName: "house")
        search.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        schedule.tabBarItem.image = UIImage(systemName: "calendar")
        progress.tabBarItem.image = UIImage(systemName: "clipboard")
        connect.tabBarItem.image = UIImage(systemName: "person")
        
        
        home.title = "Home"
        search.title = "Search"
        schedule.title = "Schedule"
        progress.title = "Progress"
        connect.title = "Connect"
        
        tabBar.tintColor = UIColor.init(red: 40/220, green: 100/220, blue: 187/220, alpha: 1)
        
        setViewControllers([home, search, schedule, progress, connect], animated: true)
    }
}
