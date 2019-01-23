//
//  AppDelegate.swift
//  Contacts
//
//  Created by v.ampilogov on 17/01/2019.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow()
        window.rootViewController = UINavigationController(rootViewController: ContactsViewController()) 
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
}
