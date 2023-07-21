//
//  AppDelegate.swift
//  Watch_CloneCoding
//
//  Created by 문인범 on 2023/07/11.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            appearance.selectionIndicatorTintColor = .systemOrange
            UITabBar.appearance().barTintColor = .black
            UITabBar.appearance().backgroundColor = .black
            UITabBar.appearance().tintColor = .systemOrange
//            UITabBar.appearance().standardAppearance = appearance
//            UITabBar.appearance().scrollEdgeAppearance = appearance
            let naviAppear = UINavigationBarAppearance()
            naviAppear.configureWithOpaqueBackground()
            naviAppear.backgroundColor = .black
            UINavigationBar.appearance().standardAppearance = naviAppear
            UINavigationBar.appearance().scrollEdgeAppearance = naviAppear
//            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            
            
            UINavigationBar.appearance().backgroundColor = .black
        }
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

