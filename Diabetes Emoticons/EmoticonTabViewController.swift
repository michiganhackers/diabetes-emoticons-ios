//
//  EmoticonTabViewController.swift
//  Diabetes Emoticons
//
//  Created by Connor Krupp on 24/03/2016.
//  Copyright © 2016 Connor Krupp. All rights reserved.
//

import UIKit

class EmoticonTabViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        self.delegate = self
    }

    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        if let navigationViewController = viewController as? UINavigationController {
            if let emoticonTableViewController = navigationViewController.viewControllers.first as? EmoticonTableViewController {
                emoticonTableViewController.vc = EmoticonTableViewController.ViewController(rawValue: selectedIndex)!
            }
        }
    }
}
