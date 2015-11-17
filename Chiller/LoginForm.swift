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

class LoginForm: UIViewController {
   
    @IBOutlet weak var signInBackground: UIView!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!

    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet var tap: UITapGestureRecognizer!
    override func viewDidLoad() {

        super.viewDidLoad()
        print("Hello\n")
        signInBackground.layer.cornerRadius = 12
        tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard:")
        tap.numberOfTouchesRequired = 1;
        tap.numberOfTapsRequired = 1;
        view.addGestureRecognizer(tap)
    }
    
//    @IBAction func dismissKeyboard(sender: UITapGestureRecognizer) {
//        
//    }
    func dismissKeyboard(sender: UITapGestureRecognizer) -> Void {
        password.resignFirstResponder()
        username.resignFirstResponder()
    }
    
    @IBAction func goToHome(sender: UIButton!) {
        let credentials = NSUserDefaults()
        credentials.setObject(username.text!, forKey: "username")
        
        print("Stored username: \(credentials.objectForKey("username"))")
        performSegueWithIdentifier("goHome", sender: self)
        performSegueWithIdentifier("goHome", sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAccount(sender: UIButton!) {
        let url : String = "http://baymaar.com/xj68123wqdgrego2/login.php";
        
        Alamofire.request(.POST, "\(url)" , parameters:["username" : "\(username.text!)", "password" : "\(password.text)"]).responseJSON() {
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
                let credentials = NSUserDefaults()
                credentials.setObject(username.text!, forKey: "username")
                
                print("Stored username: \(credentials.objectForKey("username"))")
                performSegueWithIdentifier("goHome", sender: self)
            } else {
                print("Account creation failed!\n")
                print(responseString!)
                
            }
        }
        
    }
}

