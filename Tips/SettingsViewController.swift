//
//  SettingsViewController.swift
//  Tips
//
//  Created by Isis Moran on 12/3/15.
//  Copyright © 2015 codepath. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var segControl: UISegmentedControl!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var backButton: UIButton!
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        displayTitle()
        segControl.selectedSegmentIndex = userDefaults.integerForKey("currentSeg")
        textField.becomeFirstResponder()
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //Sets title for all indices of the segmentControl and grabs information from
    //ViewController
    
    func displayTitle(){
        let lowestTip = userDefaults.floatForKey("lowest_tip")
        let midTip = userDefaults.floatForKey("mid_tip")
        let highestTip = userDefaults.floatForKey("highest_tip")
        
        segControl.setTitle("\(Int(lowestTip * 100))%", forSegmentAtIndex: 0)
        segControl.setTitle("\(Int(midTip * 100))%", forSegmentAtIndex: 1)
        segControl.setTitle("\(Int(highestTip * 100))%", forSegmentAtIndex: 2)
    }
    
    @IBAction func segControlTapped(sender: AnyObject) {
        print(segControl.selectedSegmentIndex)
    }
    
    //This allows the segmentControl to update a chosen index and have that value
    //be replaced by what's in the text field (information that user inputs) upon
    //pressing the "Save" button
    
    @IBAction func updateSegment(sender: AnyObject) {
        let newValue = NSString(string: textField.text!).floatValue
        if newValue > 0 {
            switch segControl.selectedSegmentIndex {
            case 0:
                segControl.setTitle("\(Int(newValue))%", forSegmentAtIndex: segControl.selectedSegmentIndex)
                userDefaults.setFloat((newValue / 100.00), forKey: "lowest_tip")
            case 1:
                segControl.setTitle("\(Int(newValue))%", forSegmentAtIndex: segControl.selectedSegmentIndex)
                userDefaults.setFloat((newValue / 100.00), forKey: "mid_tip")
            case 2:
                segControl.setTitle("\(Int(newValue))%", forSegmentAtIndex: segControl.selectedSegmentIndex)
                userDefaults.setFloat((newValue / 100.00), forKey: "highest_tip")
            default:
                print("something didn't work here...")
            }
        }
        textField.text = ""
    }
    
    
    @IBAction func goBack(sender: AnyObject) {
        userDefaults.setInteger((segControl.selectedSegmentIndex), forKey: "currentSeg")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
