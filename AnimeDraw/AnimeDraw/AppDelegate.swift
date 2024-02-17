//
//  AppDelegate.swift
//  AnimeDraw
//
//  Created by Tran Cuong on 31/10/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)

        let naviVC = UINavigationController(rootViewController: SplashVC())
        naviVC.isNavigationBarHidden = true
        naviVC.navigationBar.barStyle = .default
        window?.rootViewController = naviVC
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        
        window?.makeKeyAndVisible()
        return true
    }


}

