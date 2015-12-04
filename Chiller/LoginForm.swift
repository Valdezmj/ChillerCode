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

    @IBOutlet var tapTwo: UITapGestureRecognizer!
    @IBOutlet weak var busyIndicator: UIActivityIndicatorView!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet var tap: UITapGestureRecognizer!
    override func viewDidLoad() {

        super.viewDidLoad()
        print("Hello\n")
        signInBackground.layer.cornerRadius = 10
        tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard:")
        tap.numberOfTouchesRequired = 1;
        tap.numberOfTapsRequired = 1;
        view.addGestureRecognizer(tap)
        
        tapTwo = UITapGestureRecognizer(target: self, action: "dismissKeyboard:")
        tapTwo.numberOfTouchesRequired = 1;
        tapTwo.numberOfTapsRequired = 1;
        view.addGestureRecognizer(tapTwo)
        signInBackground.layer.borderColor = UIColor.blackColor().CGColor
        signInBackground.layer.borderWidth = 1
    }
    
//    @IBAction func dismissKeyboard(sender: UITapGestureRecognizer) {
//        
//    }
    @IBAction func dismissKeyboardTwo(sender: UITapGestureRecognizer) {
        dismissKeyboard(tapTwo);
        checkCredentials(signInBtn)
    }
    func dismissKeyboard(sender: UITapGestureRecognizer) -> Void {
        password.resignFirstResponder()
        username.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func checkCredentials(sender: UIButton!) {
        if username.text! != "" && password.text! != "" {
            busyIndicator.startAnimating()
            let url : String = "http://baymaar.com/xj68123wqdgrego2/checkLoginCredentials.php";
            Alamofire.request(.POST, "\(url)" , parameters:["username" : "\(username.text!)", "password" : "\(password.text)"]).responseJSON() {
                (response) in
                if response.result.value != nil {
                    print("Sending to handle request!\n")
                    self.handleResponse(response.result.value!)
                } else {
                    print("Couldn't get a response to check credentials: \(response)")
                }
            }
        }
    }

    func handleResponse(response: AnyObject!) {
        if let responseString : String! = String(response["result"]!!) {
            print(responseString!)
            if responseString == "1" {
                busyIndicator.stopAnimating()
                print("login success!\n")
                let credentials = NSUserDefaults()
                credentials.setObject(username.text!, forKey: "username")
                performSegueWithIdentifier("goHome", sender: self)
            } else {
                busyIndicator.stopAnimating()
                print("Account not found!\n")
            }
        }
        
    }
}

