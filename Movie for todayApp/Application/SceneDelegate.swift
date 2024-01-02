//
//  SceneDelegate.swift
//  Movie for todayApp
//
//  Created by Владислав on 25.12.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
//!!!: Uncomment lines 19-26 for skipping onboarding on the 1+ launches
//        let appLaunchedBefore = UserDefaults.standard.bool(forKey: "appLaunchedBefore")
//        if appLaunchedBefore {
//            window?.rootViewController = CustomTabBarController()
//        } else {
//        window?.rootViewController = OnboardingViewController()
//        }
//        UserDefaults.standard.set(true, forKey: "appLaunchedBefore")

//!!!: Comment lines 29-30 after uncommenting lines 19-26
        let mainVC = OnboardingViewController()
        window?.rootViewController = OnboardingViewController()
        
        window?.makeKeyAndVisible()
    }
}
