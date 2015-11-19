//
//  ViewController.swift
//  Chiller
//
//  Created by Michael Valdez on 10/24/15.
//  Copyright © 2015 MK. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var Menu: UIBarButtonItem!

    @IBOutlet weak var logoutBtn: UIBarButtonItem!
    var pickerData: [String] = [String]()
    @IBOutlet var cityPicker: UIPickerView!
    let credentials = NSUserDefaults()

    override func viewWillAppear(animated: Bool) {
        if credentials.objectForKey("username") == nil {
            performSegueWithIdentifier("load_login", sender: self)
        }
    }
    
    @IBAction func logout(sender: AnyObject) {
        credentials.removeObjectForKey("username")
        //credentials.removeObjectForKey("password")
        performSegueWithIdentifier("load_login", sender: self)

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pickerData = ["Denver", "Cities to come.."]
//        self.cityPicker.delegate = self
//        self.cityPicker.dataSource = self
        Menu.target = self.revealViewController();
        Menu.action = Selector("revealToggle:");
        let credentials = NSUserDefaults()
        if credentials.objectForKey("username") != nil {
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
}

