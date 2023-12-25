//
//  CustomTabBarController.swift
//  Movie for todayApp
//
//  Created by Alexander Altman on 25.12.2023.
//

import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    private var customTabBar: UIView!
        private var customTabBarItems: [CustomTabBarItem] = []

    override func viewDidLoad() {
            super.viewDidLoad()
            self.delegate = self
            setupViewControllers()
            setupCustomTabBar()
        }

        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            selectTab(at: 0) // Ensure the initial tab is set after the views have appeared
        }

        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            customTabBar.frame = tabBar.frame
            customTabBar.backgroundColor = .primaryDark
            let itemWidth = customTabBar.bounds.width / CGFloat(customTabBarItems.count)
            for (index, item) in customTabBarItems.enumerated() {
                item.frame = CGRect(x: itemWidth * CGFloat(index), y: 0, width: itemWidth, height: customTabBar.bounds.height)
            }
        }
    
    func setupViewControllers() {
        // Initialize your view controllers and add them to the tab bar
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
            // Remove the default tab bar and create a new one
            tabBar.isHidden = true
            customTabBar = UIView(frame: tabBar.frame)
            view.addSubview(customTabBar)

            let tabTitles = ["Home", "Search", "Tree", "Profile"]
            let tabImages = ["house.fill", "magnifyingglass", "leaf.fill", "person.fill"]

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

            selectTab(at: 0) // Select the first tab by default
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

class CustomTabBarItem: UIView {
    
    var imageView: UIImageView!
        var titleLabel: UILabel!
        var backgroundView: UIView!
        var onTap: (() -> Void)?
    var isSelected: Bool = false {
        didSet {
          updateAppearance()
        }
      }

    init(icon: UIImage, title: String) {
        super.init(frame: .zero)
        imageView = UIImageView(image: icon)
        imageView.contentMode = .scaleAspectFit

        titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textAlignment = .center
        titleLabel.isHidden = !isSelected
        titleLabel.alpha = isSelected ? 1.0 : 0.0

        backgroundView = UIView()
        backgroundView.layer.cornerRadius = 16
        backgroundView.isHidden = !isSelected
        backgroundView.alpha = isSelected ? 1.0 : 0.0

        setupViews()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(tapGesture)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(backgroundView)
        addSubview(imageView)
        addSubview(titleLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 4),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor, constant: -8),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 8)
        ])
        
        backgroundView.isHidden = true
    }

    override func layoutSubviews() {
            super.layoutSubviews()
            animate(isSelected: isSelected)
        }
    
    
    func configureInitialLayout() {
        imageView.tintColor = isSelected ? .primaryBlueAccent : .textColorGrey
        titleLabel.textColor = .primaryBlueAccent
        titleLabel.isHidden = !isSelected
        titleLabel.alpha = isSelected ? 1 : 0
        backgroundView.isHidden = !isSelected
        backgroundView.alpha = isSelected ? 1 : 0

        // Adjust the backgroundView frame to encompass both image and text
        let totalWidth = isSelected ? (imageView.frame.width + titleLabel.intrinsicContentSize.width + 16) : imageView.frame.width
        let contentOffset = (bounds.width - totalWidth) / 2
        backgroundView.frame = CGRect(
            x: contentOffset,
            y: imageView.frame.minY - 4,
            width: totalWidth,
            height: imageView.frame.height + 8
        )

        // Adjust the imageView transform based on selection
        imageView.transform = isSelected ? CGAffineTransform(translationX: -30, y: 0) : .identity
        layoutIfNeeded()
    }
    
    func animate(isSelected: Bool) {
        titleLabel.isHidden = false
        backgroundView.isHidden = false

        let labelSize = titleLabel.intrinsicContentSize
        let imageFrame = imageView.frame
        let totalWidth = isSelected ? (imageFrame.width + labelSize.width + 16) : imageFrame.width
        let imageX = isSelected ? (bounds.width / 2 - totalWidth / 2) : (bounds.width / 2 - imageFrame.width / 2)

        let backgroundWidth = isSelected ? (bounds.width - 2 * 5) : (imageFrame.width + 8)
        let backgroundX = isSelected ? (imageX - 8) : (bounds.width / 2 - backgroundWidth / 2)

        UIView.animate(withDuration: 0.3, animations: {
            self.imageView.tintColor = isSelected ? .primaryBlueAccent : .textColorGrey
            self.titleLabel.textColor = isSelected ? .primaryBlueAccent : .textColorGrey
            self.titleLabel.alpha = isSelected ? 1 : 0
            self.backgroundView.backgroundColor = isSelected ? .primarySoft : .clear
            self.backgroundView.alpha = isSelected ? 1 : 0
            self.imageView.frame.origin.x = imageX
            self.titleLabel.frame.origin.x = self.imageView.frame.maxX + 8
            self.backgroundView.frame = CGRect(
                x: backgroundX,
                y: imageFrame.minY - 12,
                width: backgroundWidth,
                height: imageFrame.height + 24
            )
        }, completion: { _ in
            if !isSelected {
                self.titleLabel.isHidden = true
                self.backgroundView.isHidden = true
            }
        })
    }
    
    private func updateAppearance() {
        let imageFrame = imageView.frame
        let imageX = isSelected ? (bounds.width / 2 - imageFrame.width / 2) : (bounds.width / 2 - imageFrame.width / 2 + 8)
        
        let backgroundWidth = isSelected ? (bounds.width - 2 * 5) : (imageFrame.width + 8)
        
        let backgroundX = isSelected ? (imageX - 8) : (bounds.width / 2 - backgroundWidth / 2)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [.curveEaseInOut], animations: {
            self.imageView.tintColor = self.isSelected ? .primaryBlueAccent : .textColorGrey
            self.titleLabel.textColor = self.isSelected ? .primaryBlueAccent : .textColorGrey
            self.titleLabel.alpha = self.isSelected ? 1 : 0
            self.backgroundView.backgroundColor = self.isSelected ? .primarySoft : .clear
            self.backgroundView.alpha = self.isSelected ? 1 : 0
            self.imageView.frame.origin.x = imageX
            self.titleLabel.frame.origin.x = self.imageView.frame.maxX + 8
            self.backgroundView.frame = CGRect(
                x: backgroundX,
                y: imageFrame.minY - 12,
                width: backgroundWidth,
                height: imageFrame.height + 24
            )
        }, completion: { _ in
            if self.isSelected {
                self.titleLabel.isHidden = false
                self.backgroundView.isHidden = false
            } else {
                self.titleLabel.isHidden = true
                self.backgroundView.isHidden = true
            }
        })
    }


    @objc private func didTap() {
        onTap?()
    }
}
