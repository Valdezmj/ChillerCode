//
//  RegisterView.swift
//  Chiller
//
//  Created by Michael Valdez on 11/17/15.
//  Copyright © 2015 MK. All rights reserved.
//

import Foundation
import WebKit
import Alamofire
import JavaScriptCore
extension NSDate {
    func yearsFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Year, fromDate: date, toDate: self, options: []).year
    }
    func monthsFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Month, fromDate: date, toDate: self, options: []).month
    }
    func weeksFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.WeekOfYear, fromDate: date, toDate: self, options: []).weekOfYear
    }
    func daysFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Day, fromDate: date, toDate: self, options: []).day
    }
    func hoursFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Hour, fromDate: date, toDate: self, options: []).hour
    }
    func minutesFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Minute, fromDate: date, toDate: self, options: []).minute
    }
    func secondsFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Second, fromDate: date, toDate: self, options: []).second
    }
}
class RegisterView: UIViewController, NSURLSessionDelegate {
    
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var username: UITextField!
    var session: NSURLSession!
    var birthdate: String!
    
    @IBOutlet weak var registerBackground: UIView!
    @IBOutlet var tap: UITapGestureRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 15
        session = NSURLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
        tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard:")
        tap.numberOfTouchesRequired = 1;
        tap.numberOfTapsRequired = 1;
        view.addGestureRecognizer(tap)
        registerBackground.layer.cornerRadius = 10
        registerBackground.layer.borderWidth = 1
        registerBackground.layer.borderColor = UIColor.blackColor().CGColor
        view.layer.contentsScale = 4.0
        
        
    }
    @IBAction func updateBirthdate(sender: AnyObject) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd-MM-y"
        birthdate = dateFormatter.stringFromDate(birthDatePicker.date)
        print("birthdate updated: \(birthdate!)")
        let date_b = NSDate()
        print("Years: \(date_b.yearsFrom(dateFormatter.dateFromString(birthdate)!))")
    }
    
    func dismissKeyboard(sender: UITapGestureRecognizer) -> Void {
        firstName.resignFirstResponder()
        lastName.resignFirstResponder()
        password.resignFirstResponder()
        email.resignFirstResponder()
        username.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAccount(sender: UIButton!) {
        let url : String = "http://baymaar.com/xj68123wqdgrego2/testCreateAccount.php";
        
        Alamofire.request(.POST, "\(url)" , parameters:["username" : "\((username.text?.lowercaseString)!)", "birth" :
            "\(birthdate!)", "profile" : "http://baymaar.com/profile_pic/\((username.text?.lowercaseString)!)/profile.png", "email" : "\(email.text!)", "firstname" : "\(firstName.text!)", "lastname" : "\(lastName.text!)", "password" : "\(password.text)", "active"  : "1"]).responseJSON() {
            (response) in
            if response.result.value != nil {
                print("Sending to handle request!\n")
                print("\((self.username.text?.lowercaseString)!)")
                self.handleResponse(response.result.value!)
            }
        }
    }
    func handleResponse(response: AnyObject!) {
        if let responseString : String! = String(response["result"]!!) {
            print(responseString!)
            if responseString == "1" {
                print("Account created successfully!\n")
                self.performSegueWithIdentifier("go_login", sender: self)
            } else {
                print("Account creation failed!\n")
                print(responseString!)                
            }
        }
        
    }
    
}

