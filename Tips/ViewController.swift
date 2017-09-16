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
    @IBOutlet weak var counter: UILabel!
    @IBOutlet weak var peopleCounter: UIStepper!
    @IBOutlet weak var whatPeoplePay: UILabel!
    @IBOutlet weak var billAmountView: UIView!
    @IBOutlet weak var tipInformationView: UIView!
    @IBOutlet weak var roundSwitch: UISwitch!
    
    var tipPercentage: Double = 0
    
    override func viewDidLoad() {
        billField.text = userDefaults.stringForKey("previous_bill_amount")
        
        let now = NSDate.timeIntervalSinceReferenceDate()
        let tenMinute = 10.0 * 60.0
        
        if ((now - userDefaults.doubleForKey("previous_bill_time")) < tenMinute) {
            billField.text = userDefaults.stringForKey("previous_bill_amount")
        } else {
            userDefaults.setDouble(0, forKey: "previous_bill_amount")
            billField.text = userDefaults.stringForKey("previous_bill_amount")
        }
        billField.placeholder = currencyFormatter.currencySymbol
        billField.becomeFirstResponder()
        userDefaults.synchronize()
    }
    
    override func viewWillDisappear(animated:Bool) {
        super.viewWillDisappear(animated)
        userDefaults.setInteger((tipControl.selectedSegmentIndex), forKey: "currentSeg")
    }
    
    override func viewDidDisappear(animated:Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewDidAppear(animated:Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated)
        print("View will appear")
        updateTipDisplay()
        animation()
        tipControl.selectedSegmentIndex = userDefaults.integerForKey("currentSeg")
        calculateTip()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //This function is the animation. If the text field is empty, move the top view and bottom
    //view down, else move both views up
    
    func animation() {
        if (billField.text ==  "0") || (billField.text == "") {
            UIView.animateWithDuration(1.5, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
                self.tipInformationView.transform = CGAffineTransformMakeTranslation(0, 270)
                self.billAmountView.transform = CGAffineTransformMakeTranslation(0, 70)
                }, completion: nil)
            
        } else {
            UIView.animateWithDuration(1.5, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
                self.tipInformationView.transform = CGAffineTransformMakeTranslation(0, 0)
                self.billAmountView.transform = CGAffineTransformMakeTranslation(0, 0)
                }, completion: nil)
        }
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        let tipPercentages = [userDefaults.doubleForKey("lowest_tip"),
                              userDefaults.doubleForKey("mid_tip"),
                              userDefaults.doubleForKey("highest_tip")]
        tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        calculateTip()
        animation()
        roundingTotal(roundSwitch)
        
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    //This function calculates the tip and sets their value to the corresponding lables
    
    func calculateTip() {
        let billAmount = NSString(string:billField.text!).doubleValue
        counter.text = "\(Int(peopleCounter.value))"
        userDefaults.setDouble(billAmount, forKey: "previous_bill_amount")
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        let peoplesAmount = total / NSString(string:counter.text!).doubleValue
        
        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        currencyFormatter.locale = NSLocale.currentLocale()
        
        tipLabel.text = currencyFormatter.stringFromNumber(tip)!
        totalLabel.text = currencyFormatter.stringFromNumber(total)!
        whatPeoplePay.text = currencyFormatter.stringFromNumber(peoplesAmount)!
    }
    
    //This updates the SegmentControl and also grabs the values from the SettingsViewController,
    //but this is for display purposes
    
    func updateTipDisplay() {
        tipControl.setTitle("\(Int(userDefaults.floatForKey("lowest_tip") * 100))%", forSegmentAtIndex: 0)
        tipControl.setTitle("\(Int(userDefaults.floatForKey("mid_tip") * 100))%", forSegmentAtIndex: 1)
        tipControl.setTitle("\(Int(userDefaults.floatForKey("highest_tip") * 100))%", forSegmentAtIndex: 2)
    }
    
    //This action is connected to the UISwitch and allows the total to be rounded to the nearest
    //tenths value if it is on
    
    @IBAction func roundingTotal(sender: UISwitch) {
        let billAmount = NSString(string:billField.text!).doubleValue
        let tip = billAmount * tipPercentage
        var total = billAmount + tip
        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        currencyFormatter.locale = NSLocale.currentLocale()
        
        if roundSwitch.on {
            total = Double(round(10 * total)/10)
            totalLabel.text = currencyFormatter.stringFromNumber(total)!
            let peoplesAmount = total / NSString(string:counter.text!).doubleValue
            whatPeoplePay.text = currencyFormatter.stringFromNumber(peoplesAmount)!
            
        } else {
            total = billAmount + tip
            totalLabel.text = currencyFormatter.stringFromNumber(total)!
            let peoplesAmount = total / NSString(string:counter.text!).doubleValue
            whatPeoplePay.text = currencyFormatter.stringFromNumber(peoplesAmount)!
        }
    }
}


