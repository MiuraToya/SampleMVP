//
//  AppDelegate.swift
//  SampleMVP
//
//  Created by 三浦　登哉 on 2021/04/18.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var widow: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Router.shared.showRoot(window: UIWindow(frame: UIScreen.main.bounds))
        return true
    }
}

