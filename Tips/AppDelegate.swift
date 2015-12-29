//
//  AppDelegate.swift
//  Tips
//
//  Created by Isis Moran on 11/26/15.
//  Copyright © 2015 codepath. All rights reserved.
//

import UIKit

let userDefaults = NSUserDefaults.standardUserDefaults()
let currencyFormatter = NSNumberFormatter()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    
    //Changes appearance of all segmentControllers in the app 
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let attr = NSDictionary(object: UIFont(name: "HelveticaNeue-Thin", size: 25.0)!, forKey: NSFontAttributeName)
        UISegmentedControl.appearance().setTitleTextAttributes(attr as [NSObject : AnyObject], forState: .Normal)
        
        //Changes appearance of all keyboards used in the app
        
        UITextField.appearance().keyboardAppearance = .Dark
        
        let isFirstLoad = userDefaults.boolForKey("is_First_Load")
        userDefaults.doubleForKey("lowest_tip")
        userDefaults.doubleForKey("mid_tip")
        userDefaults.doubleForKey("highest_tip")
        userDefaults.doubleForKey("previous_bill_time" )
        userDefaults.doubleForKey("previous_bill_amount")
        userDefaults.integerForKey("currentSeg")
        
        if (!isFirstLoad) {
            userDefaults.setInteger(0, forKey: "currentSeg")
            userDefaults.setDouble(0.18, forKey: "lowest_tip")
            userDefaults.setDouble(0.2, forKey: "mid_tip")
            userDefaults.setDouble(0.22, forKey: "highest_tip")
            userDefaults.setBool(true, forKey: "is_First_Load")
            userDefaults.setDouble(0.0, forKey: "previous_bill_time")
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

