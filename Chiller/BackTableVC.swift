//
//  BackTableVC.swift
//  Chiller
//
//  Created by Michael Valdez on 11/3/15.
//  Copyright © 2015 MK. All rights reserved.
//

import Foundation

class BackTableVC: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    let credentials = NSUserDefaults()

    @IBAction func goToProfile(sender: AnyObject) {
        performSegueWithIdentifier("load_profile", sender: self)

    }
    @IBAction func logout(sender: AnyObject) {
        credentials.removeObjectForKey("username")
        //credentials.removeObjectForKey("password")
        performSegueWithIdentifier("load_login", sender: self)
    }
    override func viewDidLoad() {
        //scrollView.contentSize.height = 780
    }
}