//
//  LoginForm.swift
//  Chiller
//
//  Created by Michael Valdez on 11/14/15.
//  Copyright © 2015 MK. All rights reserved.
//

import Foundation
import WebKit
import Alamofire

class LoginForm: UIViewController, NSURLSessionDelegate {
   
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var username: UITextField!
    var session: NSURLSession!

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
        print(username.text)
        print(firstName.text)
        print(lastName.text)
        print(password.text)
        print(email.text)

        var url : String = "http://baymaar.com/connect.php/get?username=\(username.text)&password=\(password.text)firstname=\(firstName.text)&lastname=\(lastName.text)&email=\(email.text)&day=25&month=8&year=1996&active=1";
        
        Alamofire.request(.POST, "http://baymaar.com/connect.php" , parameters:["username" : "\(username.text!)", "email" : "\(email.text!)", "firstname" : "\(firstName.text!)"]).responseString() {
             (JSON) in
            print(JSON)
        }
        
    }
func handleResponse() {
    
}
}

