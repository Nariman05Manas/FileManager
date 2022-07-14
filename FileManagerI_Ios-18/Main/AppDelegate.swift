//
//  AppDelegate.swift
//  FileManagerI_Ios-18
//
//  Created by qwerty on 14.07.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
       
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let tabBarController = UITabBarController()
        self.window?.overrideUserInterfaceStyle = .light
        
        let loginViewController = LoginViewController()
        let loginNavigationCOntroller = UINavigationController(rootViewController: loginViewController)
        loginNavigationCOntroller.tabBarItem.title = "FileManager"
        
        let settingsViewController = SettingsViewController()
        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)
        settingsNavigationController.tabBarItem.title = "Settings"
        
        tabBarController.viewControllers = [loginNavigationCOntroller, settingsNavigationController]
        
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        
        
        return true
    }
    
}

