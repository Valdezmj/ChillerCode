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
class RegisterView: UIViewController, NSURLSessionDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var birthdateLabel: UILabel!
    @IBOutlet weak var relationship: UIPickerView!
    @IBOutlet weak var preference: UIPickerView!
    @IBOutlet weak var gender: UIPickerView!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var username: UITextField!
    var session: NSURLSession!
    var birthdate: String!
    var genderData: [String] = [String]()
    var relationData: [String] = [String]()
    var preferenceData: [String] = [String]()
    var _gender = String()
    var _relation = String()
    var _preference = String()
    
    
    @IBOutlet weak var alreadyAcctBtn: UIButton!
    @IBOutlet weak var registerTitle: UILabel!
    @IBOutlet weak var chillerTitle: UILabel!
    @IBOutlet weak var registerBackground: UIView!
    @IBOutlet var tap: UITapGestureRecognizer!
    override func viewDidLoad() {
        genderData = ["Male", "Female", "Transgender"]
        relationData = ["Single", "In a Relationship", "Married"]
        preferenceData = ["Straight", "Gay", "Bisexual"]
        gender.delegate = self
        gender.dataSource = self
        relationship.delegate = self
        relationship.dataSource = self
        preference.delegate = self
        preference.dataSource = self
        
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
        animateLoaded()
        
    }
    override func viewDidAppear(animated: Bool) {

    }
    
    @IBAction func signInBtnClicked(sender: AnyObject) {
        self.animateUnload()
    }
    func animateLoaded() {
        birthDatePicker.alpha = 0.0
        createBtn.alpha = 0.0
        firstName.center.x -= view.bounds.width
        lastName.center.x -= view.bounds.width
        password.center.x -= view.bounds.width
        email.center.x -= view.bounds.width
        username.center.x -= view.bounds.width
        registerBackground.alpha = 0.0
        chillerTitle.center.y -= view.bounds.height
        alreadyAcctBtn.alpha = 0.0
        UIView.animateWithDuration(1.1, delay: 0.3, options: [.CurveEaseOut], animations: {
            self.chillerTitle.center.y += self.view.bounds.height
            }, completion: nil)
        UIView.animateWithDuration(0.3, delay: 1.5, options: [.CurveEaseOut], animations: {
            self.registerBackground.alpha = 1.0
            }, completion: nil)
        UIView.animateWithDuration(0.4, delay: 1.5, options: [.CurveEaseOut], animations: {
            self.firstName.center.x += self.view.bounds.width
            }, completion: nil)
        UIView.animateWithDuration(0.5, delay: 1.5, options: [.CurveEaseOut], animations: {
            self.lastName.center.x += self.view.bounds.width
            }, completion: nil)
        UIView.animateWithDuration(0.6, delay: 1.5, options: [.CurveEaseOut], animations: {
            self.username.center.x += self.view.bounds.width
            }, completion: nil)
        UIView.animateWithDuration(0.3, delay: 1.5, options: [.CurveEaseOut], animations: {
            self.password.center.x += self.view.bounds.width
            }, completion: nil)
        UIView.animateWithDuration(0.8, delay: 1.5, options: [.CurveEaseOut], animations: {
            self.email.center.x += self.view.bounds.width
            }, completion: nil)
        UIView.animateWithDuration(0.4, delay: 1.7, options: [.CurveEaseOut], animations: {
            self.createBtn.alpha = 1.0
            }, completion: nil)
        UIView.animateWithDuration(0.4, delay: 1.9, options: [.CurveEaseOut], animations: {
            self.registerTitle.alpha = 1.0
            self.alreadyAcctBtn.alpha = 1.0
            self.birthDatePicker.alpha = 1.0
            }, completion: nil)
    }
    
    func animateUnload() {
        UIView.animateWithDuration(0.8, delay: 0.3, options: [.CurveEaseIn], animations: {
            self.chillerTitle.center.y -= self.view.bounds.height
            }, completion: nil)
        UIView.animateWithDuration(0.8, delay: 0.8, options: [.CurveEaseIn], animations: {
            self.alreadyAcctBtn.center.y += self.view.bounds.height
            }, completion: nil)
        UIView.animateWithDuration(0.8, delay: 0.9, options: [.CurveEaseOut], animations: {
            self.firstName.center.x -= self.view.bounds.width
            }, completion: nil)
        UIView.animateWithDuration(0.5, delay: 0.9, options: [.CurveEaseOut], animations: {
            self.lastName.center.x -= self.view.bounds.width
            }, completion: nil)
        UIView.animateWithDuration(0.9, delay: 0.9, options: [.CurveEaseOut], animations: {
            self.username.center.x -= self.view.bounds.width
            }, completion: nil)
        UIView.animateWithDuration(1.2, delay: 0.9, options: [.CurveEaseOut], animations: {
            self.password.center.x -= self.view.bounds.width
            }, completion: nil)
        UIView.animateWithDuration(0.4, delay: 0.9, options: [.CurveEaseOut], animations: {
            self.email.center.x -= self.view.bounds.width
            }, completion: nil)
        UIView.animateWithDuration(0.4, delay: 1.5, options: [.CurveEaseIn], animations: {
            self.registerBackground.alpha = 0.0
            }, completion:
            {finshed in
                self.performSegueWithIdentifier("goLogin", sender: self)
                
        })
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
        city.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAccount(sender: UIButton!) {
        let url : String = "http://kickbakapp.com/xj68123wqdgrego2/testCreateAccount.php";
        Alamofire.request(.POST, "\(url)" , parameters:["username" : "\((username.text?.lowercaseString)!)", "birth" :
            "\(birthdate!)", "profile" : "http://192.168.1.133/profile_pic/\((username.text?.lowercaseString)!)/profile.jpeg", "email" : "\(email.text!)", "firstname" : "\(firstName.text!)", "lastname" : "\(lastName.text!)", "password" : "\(password.text)", "active"  : "1", "gender" : "\(_gender)", "relationship" : "\(_relation)", "preference" : "\(_preference)", "city" : "\(city.text!)"]).responseJSON() {
                (response) in
                if response.data != nil {
                    let _r = JSON(data: response.data!)
                    if (_r["result"].stringValue == "1") {
                        self.animateUnload()
                    }
                } else {
                    print("Couldn't get a response to check credentials: \(response.data)")
                }
        }

                
    }
    func handleResponse(response: AnyObject!) {
        if let responseString : String! = String(response["result"]!!) {
            print(responseString!)
            if responseString == "1" {
                print("Account created successfully!\n")
                self.animateUnload()
            } else {
                print("Account creation failed!\n")
                print(responseString!)                
            }
        }
        
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == self.gender) {
            return genderData.count
        }
        if (pickerView == relationship) {
            return relationData.count
        }
        if (pickerView == preference) {
            return preferenceData.count
        }
        return 1
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == self.gender) {
            _gender = genderData[row]
            return genderData[row]
        }
        if (pickerView == relationship) {
            _relation = relationData[row]
            return relationData[row]
        }
        if (pickerView == preference) {
            _preference = preferenceData[row]
            return preferenceData[row]
        }
        return "here"
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == self.gender) {
            print("gender change: ")
            _gender = genderData[row]
            print("gender change: \(_gender)")
        }
        if (pickerView == self.relationship) {
            _relation = relationData[row]
            print("relationship change: \(_relation)")
        }
        if (pickerView == self.preference) {
            _preference = preferenceData[row]
            print("preference change: \(_preference)")
        }
    }
    
}

