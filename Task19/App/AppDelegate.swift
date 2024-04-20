//
//  AppDelegate.swift
//  Task19
//
//  Created by ana namgaladze on 19.04.24.
//

import UIKit
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        let vc = NewsController()
        let navigationController = UINavigationController(rootViewController: vc)
        window?.rootViewController = navigationController
        
        return true
    }
    
}
