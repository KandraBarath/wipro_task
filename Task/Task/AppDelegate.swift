//
//  AppDelegate.swift
//  Task
//
//  Created by apple on 29/06/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let homeViewController = HomeViewController()
        let navigationController = UINavigationController(rootViewController:homeViewController )
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

