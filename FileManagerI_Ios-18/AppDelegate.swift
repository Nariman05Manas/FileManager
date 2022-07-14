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
        
        let documentNavigationController = UINavigationController(rootViewController: ViewController())
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = documentNavigationController
        self.window?.makeKeyAndVisible()
        
        return true
        
    }
    
    
}
