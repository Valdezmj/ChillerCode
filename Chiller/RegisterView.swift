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

class RegisterView: UIViewController, NSURLSessionDelegate {
    
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var username: UITextField!
    var session: NSURLSession!
    
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
        let url : String = "http://baymaar.com/xj68123wqdgrego2/createAccount.php";
        
        Alamofire.request(.POST, "\(url)" , parameters:["username" : "\(username.text!)", "email" : "\(email.text!)", "firstname" : "\(firstName.text!)", "password" : "\(password.text)", "active"  : "1"]).responseJSON() {
            (response) in
            if response.result.value != nil {
                print("Sending to handle request!\n")
                self.handleResponse(response.result.value!)
            }
        }
    }
    func handleResponse(response: AnyObject!) {
        if let responseString : String! = String(response["result"]!!) {
            print(responseString!)
            if responseString == "1" {
                print("Account created successfully!\n")
            } else {
                print("Account creation failed!\n")
                print(responseString!)                
            }
        }
        
    }
}

