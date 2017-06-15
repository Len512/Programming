//
//  MyTabBarController.swift
//  MyLocations
//
//  Created by Len512 on 15/06/2017.
//  Copyright © 2017 Len512. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    // By returning nil, the tab bar controller will look at its own property and not those from other VCs
    override var childViewControllerForStatusBarStyle: UIViewController? {
        return nil
    }
}
