//
//  AppDelegate.swift
//  SwiftCoreData
//
//  Created by sapgv on 12/29/2024.
//  Copyright (c) 2024 sapgv. All rights reserved.
//

import UIKit
import SwiftCoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = createRootViewController()
        
        return true
    }
    
    private func createRootViewController() -> UIViewController {
        
        let viewModel = PersonListViewModel()
        let viewController = PersonListViewController()
        viewController.viewModel = viewModel
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        return navigationController
        
    }

}

let coreDataStack = CoreDataStack(modelName: "Model")
