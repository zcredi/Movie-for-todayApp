//
//  CustomTabBarController.swift
//  Movie for todayApp
//
//  Created by Alexander Altman on 25.12.2023.
//

import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    //MARK: - UI Elements
    private var customTabBar: UIView!
    private var customTabBarItems: [CustomTabBarItem] = []
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setupViewControllers()
        setupCustomTabBar()
        selectTab(at: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateTabBarItemsLayout()
        customTabBarItems[0].configureInitialLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        customTabBar.frame = tabBar.frame
        customTabBar.backgroundColor = .primaryDark
        updateTabBarItemsLayout()
    }
    
    //MARK: - Methods
    func updateTabBarItemsLayout() {
        let itemWidth = customTabBar.bounds.width / CGFloat(customTabBarItems.count)
        for (index, item) in customTabBarItems.enumerated() {
            item.frame = CGRect(x: itemWidth * CGFloat(index), y: 0, width: itemWidth, height: customTabBar.bounds.height)
            item.layoutIfNeeded()
        }
    }
    
    func setupViewControllers() {
        let homeViewController = UIViewController()
        let searchViewController = UIViewController()
        let treeViewController = UIViewController()
        let profileViewController = UIViewController()
        
        homeViewController.view.backgroundColor = .white
        searchViewController.view.backgroundColor = .gray
        treeViewController.view.backgroundColor = .cyan
        profileViewController.view.backgroundColor = .blue
        
        viewControllers = [homeViewController, searchViewController, treeViewController, profileViewController]
    }
    
    func setupCustomTabBar() {
        // Remove the default tab bar and create custom one
        tabBar.isHidden = true
        customTabBar = UIView(frame: tabBar.frame)
        view.addSubview(customTabBar)
        
        let tabTitles = ["Home", "Search", "Tree", "Profile"]
        let tabImages = ["house.fill", "magnifyingglass", "puzzlepiece.fill", "person.fill"]
        
        let itemWidth = view.bounds.width / CGFloat(tabTitles.count)
        
        for i in 0..<tabTitles.count {
            let itemView = CustomTabBarItem(icon: UIImage(systemName: tabImages[i])!, title: tabTitles[i])
            itemView.frame = CGRect(x: itemWidth * CGFloat(i), y: 0, width: itemWidth, height: tabBar.frame.height)
            itemView.onTap = { [unowned self] in
                self.selectTab(at: i)
            }
            customTabBarItems.append(itemView)
            customTabBar.addSubview(itemView)
        }
        
        selectTab(at: 0)
    }
    
    func selectTab(at index: Int) {
        for item in customTabBarItems {
            item.isSelected = false
            item.animate(isSelected: false)
        }
        
        let selectedItem = customTabBarItems[index]
        selectedItem.isSelected = true
        selectedItem.animate(isSelected: true)
        selectedIndex = index
    }
}
