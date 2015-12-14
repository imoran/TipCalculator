//
//  AppDelegate.swift
//  Tips
//
//  Created by Gooby  on 11/26/15.
//  Copyright © 2015 codepath. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    let attr = NSDictionary(object: UIFont(name: "HelveticaNeue-Thin", size: 20.0)!, forKey: NSFontAttributeName)
    UISegmentedControl.appearance().setTitleTextAttributes(attr as [NSObject : AnyObject], forState: .Normal)
    
    // Override point for customization after application launch.
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    let isFirstLoad = userDefaults.boolForKey("is_First_Load")
    userDefaults.floatForKey("lowest_tip")
    userDefaults.floatForKey("mid_tip")
    userDefaults.floatForKey("highest_tip")
  
    
    if (!isFirstLoad) {
    
    userDefaults.setFloat(0.18, forKey: "lowest_tip")
    userDefaults.setFloat(0.2, forKey: "mid_tip")
    userDefaults.setFloat(0.22, forKey: "highest_tip")
    userDefaults.setBool(true, forKey: "is_First_Load")
    userDefaults.setFloat(0.0, forKey: "default_tip")
    userDefaults.setInteger(0, forKey: "default_index")
    userDefaults.setBool(false, forKey: "default_tip_changed")
    userDefaults.setDouble(0.0, forKey: "previous_bill_time")
    userDefaults.setFloat(0.0, forKey: "previous_bill_amount")
    userDefaults.synchronize()
    
    }
    
    
    
    
    return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
    
    }
}

