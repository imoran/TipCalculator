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
    
    var tipPercentage: Float!

    
    override func viewDidLoad() {
        let now = NSDate()
        userDefaults.setObject(now, forKey: "previous_time")
        let previousTime = NSUserDefaults.standardUserDefaults().objectForKey("previous_time") as? NSDate
        
        if (previousTime != nil && now.time)
        
        
        
        
        }

        }
    
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated)
        print("View will appear")
        billField.becomeFirstResponder()
        updateTipDisplay()
        tipControl.selectedSegmentIndex = userDefaults.integerForKey("currentSeg")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    func animation() {
        if billField.text == "" {
            UIView.animateWithDuration(1.5, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
                self.tipInformationView.transform = CGAffineTransformMakeTranslation(0, 300)
                self.billAmountView.transform = CGAffineTransformMakeTranslation(0, 100)
                }, completion: nil)
                billField.becomeFirstResponder()
                print(false)
            
        } else if billField.text != "" {
            UIView.animateWithDuration(1.5, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [], animations: {
                self.tipInformationView.transform = CGAffineTransformMakeTranslation(0, 0)
                self.billAmountView.transform = CGAffineTransformMakeTranslation(0, 0)
                }, completion: nil)
                print(true)
        }
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        animation()
        let tipPercentages = [userDefaults.floatForKey("lowest_tip"), userDefaults.floatForKey("mid_tip"), userDefaults.floatForKey("highest_tip")]
//        animation()

        tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
//        defaults.setInteger((tipControl.selectedSegmentIndex), forKey: "currentSeg")
        
        calculateTip(tipPercentage)
        
        let billAmount = NSString(string:billField.text!).floatValue
        let tip = billAmount * tipPercentage
        var total = billAmount + tip
        let peoplesAmount = total / NSString(string:counter.text!).floatValue
        
//        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
//        currencyFormatter.locale = NSLocale.currentLocale()
        calculateTip(tipPercentage)
        
        userDefaults.setDouble(NSDate.timeIntervalSinceReferenceDate(), forKey: "previous_bill_time")
        userDefaults.setInteger(tipControl.selectedSegmentIndex, forKey: "previous_index")
        userDefaults.setFloat(billAmount, forKey: "previous_bill_amount")
        
        if roundSwitch.on {
             total = Float(round(10 * total)/10)
             calculateTip(tipPercentage)
             totalLabel.text = String(format: "$%.2f", total)
             let peoplesAmount = total / NSString(string:counter.text!).floatValue
             whatPeoplePay.text = String(format: "$%.2f", peoplesAmount)
        } else if !roundSwitch.on {
             tipLabel.text = currencyFormatter.stringFromNumber(tip)!
             totalLabel.text = currencyFormatter.stringFromNumber(total)!
             whatPeoplePay.text = currencyFormatter.stringFromNumber(peoplesAmount)!
        }
        

    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    override func viewDidAppear(animated:Bool) {
        super.viewWillAppear(animated)
        print("View did appear")
//        if billField.text != "" {
//            //billField.resignFirstResponder()
//        }
        
    }
    
    override func viewWillDisappear(animated:Bool) {
        super.viewWillDisappear(animated)
        print("View will disappear")
        userDefaults.setObject(billField.text, forKey: "savedAmt")
        userDefaults.setInteger((tipControl.selectedSegmentIndex), forKey: "currentSeg")

        
    }
    override func viewDidDisappear(animated:Bool) {
        super.viewDidDisappear(animated)
        print("View did disappear")
    }
    
    func calculateTip(tipPercentage: Float) {
        let billAmount = NSString(string:billField.text!).floatValue
        userDefaults.setFloat(billAmount, forKey: "savedAmt")
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        let peoplesAmount = total / NSString(string:counter.text!).floatValue
        
        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        currencyFormatter.locale = NSLocale.currentLocale()
        
        tipLabel.text = currencyFormatter.stringFromNumber(tip)!
        totalLabel.text = currencyFormatter.stringFromNumber(total)!
        whatPeoplePay.text = currencyFormatter.stringFromNumber(peoplesAmount)!
        
    }
    
    func updateTipDisplay() {
        tipControl.setTitle("\(Int(userDefaults.floatForKey("lowest_tip") * 100))%", forSegmentAtIndex: 0)
        tipControl.setTitle("\(Int(userDefaults.floatForKey("mid_tip") * 100))%", forSegmentAtIndex: 1)
        tipControl.setTitle("\(Int(userDefaults.floatForKey("highest_tip") * 100))%", forSegmentAtIndex: 2)
        
    }
    
    @IBAction func addPeople(sender: UIStepper) {
        let billAmount = NSString(string:billField.text!).floatValue
        let tip = billAmount * tipPercentage
        var total = billAmount + tip
        
        if roundSwitch.on {
            self.counter.text = Int(sender.value).description
            total = Float(round(10 * total)/10)
            let peoplesAmount = total / NSString(string:counter.text!).floatValue
            calculateTip(tipPercentage)
            whatPeoplePay.text = currencyFormatter.stringFromNumber(peoplesAmount)!
            totalLabel.text = currencyFormatter.stringFromNumber(total)!
            
        } else if !roundSwitch.on {
            self.counter.text = Int(sender.value).description
            let peoplesAmount = total / NSString(string:counter.text!).floatValue
            calculateTip(tipPercentage)
            whatPeoplePay.text = currencyFormatter.stringFromNumber(peoplesAmount)!
            totalLabel.text = currencyFormatter.stringFromNumber(total)!
        }
    }
    
    @IBAction func roundingTotal(sender: UISwitch) {
        let billAmount = NSString(string:billField.text!).floatValue
        let tip = billAmount * tipPercentage
        var total = billAmount + tip
        
        if roundSwitch.on {
            total = Float(round(10 * total)/10)
            calculateTip(tipPercentage)
            totalLabel.text = currencyFormatter.stringFromNumber(total)!
            let peoplesAmount = total / NSString(string:counter.text!).floatValue
            whatPeoplePay.text = currencyFormatter.stringFromNumber(peoplesAmount)!

        } else if !roundSwitch.on {
            total = billAmount + tip
            calculateTip(tipPercentage)
            totalLabel.text = currencyFormatter.stringFromNumber(total)!
            let peoplesAmount = total / NSString(string:counter.text!).floatValue
            whatPeoplePay.text = currencyFormatter.stringFromNumber(peoplesAmount)!
            
          }
      }
    }
















