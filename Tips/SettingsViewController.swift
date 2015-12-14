//
//  SettingsViewController.swift
//  Tips
//
//  Created by Isis  on 12/3/15.
//  Copyright © 2015 codepath. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var segControl: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!
    
    var lowestTip: Float!
    var midTip: Float!
    var highestTip: Float!

    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        lowestTip = userDefaults.floatForKey("lowest_tip")
        midTip = userDefaults.floatForKey("mid_tip")
        highestTip = userDefaults.floatForKey("highest_tip")
        
        segControl.setTitle("\(Int(lowestTip * 100))%", forSegmentAtIndex: 0)
        segControl.setTitle("\(Int(midTip * 100))%", forSegmentAtIndex: 1)
        segControl.setTitle("\(Int(highestTip * 100))%", forSegmentAtIndex: 2)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func segControlTapped(sender: AnyObject) {
        print(segControl.selectedSegmentIndex)
    }
    
    
    @IBAction func updateSegment(sender: AnyObject) {
        switch segControl.selectedSegmentIndex {
        case 0:
            let newValue = NSString(string: textField.text!).floatValue
            segControl.setTitle(String(newValue), forSegmentAtIndex: segControl.selectedSegmentIndex)
            
            userDefaults.setFloat((newValue / 100.00), forKey: "lowest_tip")
            
        case 1:
           segControl.setTitle(textField.text, forSegmentAtIndex: 1)
           let newValueOne = NSString(string: textField.text!).floatValue
           segControl.setTitle(String(newValueOne), forSegmentAtIndex: segControl.selectedSegmentIndex)
           userDefaults.setFloat((newValueOne / 100.00), forKey: "mid_tip")
           
        case 2:
            segControl.setTitle(textField.text, forSegmentAtIndex: 2)
            let newValueTwo = NSString(string: textField.text!).floatValue
            segControl.setTitle(String(newValueTwo), forSegmentAtIndex: segControl.selectedSegmentIndex)
            userDefaults.setFloat((newValueTwo / 100.00), forKey: "highest_tip")
            
        default:
            print("something didn't work here...")
        }
        
        textField.text = ""
    }
    
    @IBAction func onDefaultChanged(sender: AnyObject) {
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        lowestTip = userDefaults.floatForKey("lowest_tip")
        midTip = userDefaults.floatForKey("mid_tip")
        highestTip = userDefaults.floatForKey("highest_tip")
        
        
        if (segControl.selectedSegmentIndex == 0) {
            userDefaults.setFloat(lowestTip, forKey: "default_tip")
            userDefaults.setInteger(0, forKey: "default_index")
            userDefaults.setBool(true, forKey: "default_tip_changed")
        }else if (segControl.selectedSegmentIndex == 1) {
            userDefaults.setFloat(midTip, forKey: "default_tip")
            userDefaults.setInteger(1, forKey: "default_index")
            userDefaults.setBool(true, forKey: "default_tip_changed")
        }else if (segControl.selectedSegmentIndex == 2) {
            userDefaults.setFloat(highestTip, forKey: "default_tip")
            userDefaults.setInteger(2, forKey: "default_index")
            userDefaults.setBool(true, forKey: "default_tip_changed")

        }
        userDefaults.synchronize()
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
