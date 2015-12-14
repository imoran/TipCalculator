//
//  ViewController.swift
//  Tips
//
//  Created by Isis Moran on 11/26/15.
//  Copyright © 2015 codepath. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController
    {
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var twoPeopleLabel: UILabel!
    @IBOutlet weak var threePeopleLabel: UILabel!
    @IBOutlet weak var fourPeopleLabel: UILabel!
    
    var tipPercentage: Float!
    let defaults = NSUserDefaults.standardUserDefaults()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        billField.text = String(defaults.floatForKey("savedAmt"))
        defaults.synchronize()
    
    
        let now = NSDate.timeIntervalSinceReferenceDate()
        let tenMinute = 10.0 * 60.00
    
        let currencyFormatter = NSNumberFormatter()
        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        currencyFormatter.locale = NSLocale.currentLocale()
    
        if ((now - defaults.doubleForKey("previous_bill_time")) < tenMinute) {
            billField.text = String(defaults.floatForKey("savedAmt"))
            calculateTip(defaults.floatForKey("default_tip"))
        
        } else {
            tipLabel.text = currencyFormatter.stringFromNumber(0.00)
            totalLabel.text = currencyFormatter.stringFromNumber(0.00)
            twoPeopleLabel.text = currencyFormatter.stringFromNumber(0.00)
            threePeopleLabel.text = currencyFormatter.stringFromNumber(0.00)
        
            tipPercentage = defaults.floatForKey("default_tip")
        }
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        
        let tipPercentages = [defaults.floatForKey("lowest_tip"), defaults.floatForKey("mid_tip"), defaults.floatForKey("highest_tip")]
        tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        calculateTip(tipPercentage)
        
        let billAmount = NSString(string:billField.text!).floatValue
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
    
        
        let currencyFormatter = NSNumberFormatter()
        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        currencyFormatter.locale = NSLocale.currentLocale()
        calculateTip(tipPercentage)
        
        defaults.setDouble(NSDate.timeIntervalSinceReferenceDate(), forKey: "previous_bill_time")
        
        tipLabel.text = currencyFormatter.stringFromNumber(tip)!
        totalLabel.text = currencyFormatter.stringFromNumber(total)!
        
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
        
    }
    
    
    @IBAction func onBillAmount(sender: AnyObject) {
        calculateTip(tipPercentage)
    }
    
    
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated)
        print("View will appear")
        billField.becomeFirstResponder()
        
        if (defaults.boolForKey("default_tip_changed")) {
            tipControl.selectedSegmentIndex = defaults.integerForKey("default_index")
            updateTipDisplay()
            calculateTip(defaults.floatForKey("default_tip"))
            defaults.setBool(false, forKey: "default_tip_changed")
        }
    
    }
    
    override func viewDidAppear(animated:Bool) {
            super.viewWillAppear(animated)
            print("View did appear")
//            
//            var tipPercentages = [0.18, 0.2, 0.22]
//            let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
//            let billAmount = NSString(string:billField.text!).floatValue
//            let tip = billAmount * tipPercentage
//            let total = billAmount + tip
//            
//            //tipLabel.text = String(format: "$%.2f", tip)
//            //totalLabel.text = String(format: "$%.2f", total)
//            
//            let currencyFormatter = NSNumberFormatter()
//            currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
//            currencyFormatter.locale = NSLocale.currentLocale()
//            
//            tipLabel.text = currencyFormatter.stringFromNumber(tip)!
//            totalLabel.text = currencyFormatter.stringFromNumber(total)!
    }
    
    override func viewWillDisappear(animated:Bool) {
            super.viewWillDisappear(animated)
            print("View will disappear")
            let myText = billField.text
            NSUserDefaults.standardUserDefaults().setObject(myText, forKey: "savedAmt")
            
            
    }
    override func viewDidDisappear(animated:Bool) {
            super.viewDidDisappear(animated)
            print("View did disappear")
    }
    
    func calculateTip(tipPercentage: Float) {
        let billAmount = NSString(string:billField.text!).floatValue
        defaults.setFloat(billAmount, forKey: "savedAmt")
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        let twoPeopleLabelBill = total / 2.0
        let threePeopleLabelBill = total / 3.0
        let fourPeopleLabelBill = total / 4.0
        
        let currencyFormatter = NSNumberFormatter()
        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        currencyFormatter.locale = NSLocale.currentLocale()
        
        tipLabel.text = currencyFormatter.stringFromNumber(tip)!
        totalLabel.text = currencyFormatter.stringFromNumber(total)!
        twoPeopleLabel.text = currencyFormatter.stringFromNumber(twoPeopleLabelBill)!
        threePeopleLabel.text = currencyFormatter.stringFromNumber(threePeopleLabelBill)!
        fourPeopleLabel.text = currencyFormatter.stringFromNumber(fourPeopleLabelBill)!
    }
    
    func updateTipDisplay() {
        tipControl.setTitle("\(Int(defaults.floatForKey("lowest_tip") * 100))%", forSegmentAtIndex: 0)
        tipControl.setTitle("\(Int(defaults.floatForKey("mid_tip") * 100))%", forSegmentAtIndex: 1)
        tipControl.setTitle("\(Int(defaults.floatForKey("highest_tip") * 100))%", forSegmentAtIndex: 2)
        tipControl.selectedSegmentIndex = defaults.integerForKey("default_index")
    }

}
