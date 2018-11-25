//
//  AppDelegate.swift
//  GridCollage
//
//  Created by Daniil Subbotin on 28/10/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let secureStorage = SecureStorage()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let rootViewController = AuthViewController()
        rootViewController.secureStorage = secureStorage
        let rootNavController = UINavigationController(rootViewController: rootViewController)
        rootNavController.isNavigationBarHidden = true
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootNavController
        window?.makeKeyAndVisible()
        
        return true
    }

}

