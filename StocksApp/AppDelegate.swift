//
//  AppDelegate.swift
//  StocksApp
//
//  Created by Kanishka Chaudhry on 31/10/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

       func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
           // Create the main window
           window = UIWindow(frame: UIScreen.main.bounds)
           
           // Create your main view controller (replace YourViewController with your actual view controller)
           let mainViewController = ViewController() // Replace this with your actual view controller
           
           // Create a navigation controller with the main view controller as its root
           let navigationController = UINavigationController(rootViewController: mainViewController)
           
           // Set the navigation controller as the root view controller
           window?.rootViewController = navigationController
           window?.makeKeyAndVisible()
           
           return true
       }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

