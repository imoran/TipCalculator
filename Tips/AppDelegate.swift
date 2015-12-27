//
//  AppDelegate.swift
//  Tips
//
//  Created by Isis on 11/26/15.
//  Copyright © 2015 codepath. All rights reserved.
//

import UIKit

let userDefaults = NSUserDefaults.standardUserDefaults()
let currencyFormatter = NSNumberFormatter()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    let attr = NSDictionary(object: UIFont(name: "HelveticaNeue-Thin", size: 20.0)!, forKey: NSFontAttributeName)
    UISegmentedControl.appearance().setTitleTextAttributes(attr as [NSObject : AnyObject], forState: .Normal)
    
    let isFirstLoad = userDefaults.boolForKey("is_First_Load")
    userDefaults.floatForKey("lowest_tip")
    userDefaults.floatForKey("mid_tip")
    userDefaults.floatForKey("highest_tip")
    userDefaults.objectForKey("previous_time" )

    userDefaults.integerForKey("currentSeg")
    
    if (!isFirstLoad) {
        userDefaults.setInteger(0, forKey: "currentSeg")
        userDefaults.setFloat(0.18, forKey: "lowest_tip")
        userDefaults.setFloat(0.2, forKey: "mid_tip")
        userDefaults.setFloat(0.22, forKey: "highest_tip")
        userDefaults.setBool(true, forKey: "is_First_Load")
//        userDefaults.setFloat(0.0, forKey: "default_tip")
//        userDefaults.setInteger(0, forKey: "default_index")
//        userDefaults.setBool(false, forKey: "default_tip_changed")
        userDefaults.setDouble(0.0, forKey: "previous_time")
        userDefaults.setFloat(0.0, forKey: "previous_bill_amount")
        userDefaults.synchronize()
    }
    
    return true
        
    }
    
    func applicationWillResignActive(application: UIApplication) {
        
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        
    }
    
    func applicationWillTerminate(application: UIApplication) {
    
    }
}

