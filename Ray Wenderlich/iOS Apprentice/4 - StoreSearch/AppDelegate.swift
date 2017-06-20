//
//  AppDelegate.swift
//  StoreSearch
//
//  Created by Len512 on 16/06/2017.
//  Copyright © 2017 Len512. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // View Controllers for iPad functionality
    // The top level view controller
    var splitViewController: UISplitViewController {
        return window!.rootViewController as! UISplitViewController
    }
    // The Search screen in the master pane of the split view
    var searchViewController: SearchViewController {
        return splitViewController.viewControllers.first as! SearchViewController
    }
    // the UINavigationController in the detail pane of the split view
    var detailNavigationController: UINavigationController {
        return splitViewController.viewControllers.last as! UINavigationController
    }
    // The Detail screen inside the UINavigationController
    var detailViewController: DetailViewController {
        return detailNavigationController.topViewController as! DetailViewController
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Customise Search and status bar
        customizeAppearance()
        detailViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        // Give a reference to the row that is tapped, so that the SearchVC can know which one was tapped
        searchViewController.splitViewDetail = detailViewController
        // make delegate for the UISplitViewController
        splitViewController.delegate = self
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // Customise Search Bar appearance
    func customizeAppearance() {
        let barTintColor = UIColor(red: 20/255, green: 160/255, blue: 160/255, alpha: 1)
        UISearchBar.appearance().barTintColor = barTintColor
        window!.tintColor = UIColor(red: 10/255, green: 80/255, blue: 80/255, alpha: 1)
    }
}
extension AppDelegate: UISplitViewControllerDelegate {
    // dismiss any presented view controller if the display mode changes to primaryOverlay (if the master pane becomes visible on iPad)
    func splitViewController(_ svc: UISplitViewController, willChangeTo displayMode: UISplitViewControllerDisplayMode) {
        print(#function)
        if displayMode == .primaryOverlay {
            svc.dismiss(animated: true, completion: nil)
        }
    }
}

