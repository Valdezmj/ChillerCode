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
    @IBOutlet weak var chillerTitle: UILabel!
    
    @IBOutlet weak var subSectionViewTwo: UIView!
    @IBOutlet weak var subSectionView: UIView!
    @IBOutlet weak var friendCollectionView: UIView!
    var pickerData: [String] = [String]()
    @IBOutlet var cityPicker: UIPickerView!
    let credentials = NSUserDefaults()
    let gradientLayer = CAGradientLayer()

    override func viewWillAppear(animated: Bool) {
        print("Checking if user is already logged in")
        if credentials.objectForKey("username") == nil {
            performSegueWithIdentifier("load_login", sender: self)
        }
        animateLoad()
//        gradientLayer.frame = gradientView.bounds
//        
//        // 3
//        let color1 = UIColor.whiteColor().CGColor as CGColorRef
//        let color4 = UIColor(hexString: "#489BE7").CGColor as CGColorRef
//        gradientLayer.colors = [color1, color1, color4, color1, color1]
//        
//         //4
//        gradientLayer.locations = [0.0, 0.25, 0.45, 0.85, 1.0]
//        
//         //5
//        gradientView.layer.addSublayer(gradientLayer)
    }
    
    @IBOutlet weak var gradientView: UIView!
    func animateLoad() {
//        chillerTitle.center.x += view.bounds.width
//        UIView.animateWithDuration(0.8, delay: 0.2, options: [.CurveEaseIn], animations: {
//            self.chillerTitle.center.x -= self.view.bounds.width
//            }, completion: nil)
//        friendCollectionView.backgroundColor = UIColor(white: 1, alpha: 0.0)
//        subSectionView.backgroundColor = UIColor(white: 1, alpha: 0.0)
//        subSectionViewTwo.backgroundColor = UIColor(white: 1, alpha: 0.0)
    }
    
    @IBAction func goToProfile(sender: UIBarButtonItem) {
        performSegueWithIdentifier("toProfile", sender: self)
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
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
    @IBAction func prepareForUnwind(sender: UIStoryboardSegue) {
        
    }
    
    override func disablesAutomaticKeyboardDismissal() -> Bool {
        return false
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

