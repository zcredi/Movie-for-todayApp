//
//  CustomNavigationController.swift
//  Movie for todayApp
//
//  Created by Alexander Altman on 30.12.2023.
//

import UIKit

class CustomNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButtonImage = UIImage(systemName: "chevron.left")?.withTintColor(UIColor.textColorWhite, renderingMode: .alwaysOriginal)
        navigationBar.backIndicatorImage = backButtonImage
        navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
    }
}
