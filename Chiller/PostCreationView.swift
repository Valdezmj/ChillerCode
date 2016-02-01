//
//  PostCreationView.swift
//  Chiller
//
//  Created by Michael Valdez on 12/21/15.
//  Copyright © 2015 MK. All rights reserved.
//

import Foundation
import Alamofire

class PostCreationView: UIViewController {
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    let credentials = NSUserDefaults()
    @IBOutlet weak var __view: UIView!
    @IBOutlet weak var body: UITextField!
    @IBOutlet weak var __title: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBAction func createPost(sender: AnyObject) {
        indicator.startAnimating()
        let url : String = "http://kickbakapp.com/xj68123wqdgrego2/submitPost.php";
        Alamofire.request(.POST, "\(url)" , parameters:["body" : "\(body.text!)", "userid" : "\(self.credentials.objectForKey("userid")!)", "title" : "\(__title.text!)"]).responseJSON() {
            (response) in
            if response.data != nil {
                let _r = JSON(data: response.data!)
                if _r["result"].stringValue == "1" {
                    self.indicator.stopAnimating()
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            } else {
                print("Couldn't get a response to check credentials: \(response.data)")
            }
        }
    }
    
    @IBAction func cancelCreation(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func viewDidLoad() {
        scrollView.contentSize.height = 670
        __view.layer.cornerRadius = 12
        
    }
    
}