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
        home.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        
        search.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        search.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass.fill")
        
        schedule.tabBarItem.image = UIImage(systemName: "calendar")
        schedule.tabBarItem.selectedImage = UIImage(systemName: "calendar.fill")
        
        progress.tabBarItem.image = UIImage(systemName: "clipboard")
        progress.tabBarItem.selectedImage = UIImage(systemName: "clipboard.fill")
        
        connect.tabBarItem.image = UIImage(systemName: "person")
        connect.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        
        
        
        
        home.title = "Home"
        search.title = "Search"
        schedule.title = "Schedule"
        progress.title = "Progress"
        connect.title = "Connect"
        
        tabBar.tintColor = UIColor.init(red: 40/220, green: 100/220, blue: 187/220, alpha: 1)
        
        setViewControllers([home, search, schedule, progress, connect], animated: true)
    }
}
