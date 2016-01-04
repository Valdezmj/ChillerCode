//
//  SearchScreen.swift
//  Chiller
//
//  Created by Michael Valdez on 12/9/15.
//  Copyright © 2015 MK. All rights reserved.
//

import Foundation
import WebKit
import AlamofireImage
import Alamofire

class Search : UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    @IBOutlet var tap: UITapGestureRecognizer!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var backBtn: UIBarButtonItem!
    var searchBar = UISearchController()
    @IBOutlet weak var tableView: UITableView!
    var people = [SearchPerson]()
    let credentials = NSUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true;
        print("Right view did load!")
        self.searchBar = UISearchController(searchResultsController: nil)
        self.searchBar.searchResultsUpdater = self
        
        self.searchBar.dimsBackgroundDuringPresentation = false
        self.searchBar.searchBar.sizeToFit()
        self.searchBar.searchBar.placeholder = "Friend's Username"
        
        tableView.tableHeaderView = self.searchBar.searchBar
        tableView.delegate = self
        tableView.dataSource = self
        tap = UITapGestureRecognizer(target: self, action: "dismissKeyboard:")
        tap.numberOfTouchesRequired = 1;
        tap.numberOfTapsRequired = 1;
        view.addGestureRecognizer(tap)
        
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.view.endEditing(true)
    }
    
    @IBAction func backBtnTouched(sender: AnyObject) {
        self.searchBar.active = false
        self.tableView.tableHeaderView?.hidden = true
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    func dismissKeyboard(sender: UITapGestureRecognizer) -> Void {
        self.searchBar.resignFirstResponder()
        self.searchBar.searchBar.resignFirstResponder()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        let url : String = "http://192.168.1.121/xj68123wqdgrego2/search.php";
        Alamofire.request(.POST, "\(url)" , parameters:["search" : "\(searchBar.searchBar.text!)", "username" : "\(credentials.objectForKey("username")!)"]).responseJSON() {
            (response) in
            if response.data != nil {
                let _r = JSON(data: response.data!)
                if (_r["result"]) {
                    self.people.removeAll(keepCapacity: false)
                    for (_,subJson):(String, JSON) in _r["users"] {
                        self.people.append(SearchPerson(userid: subJson["id"].stringValue, username: subJson["name"].stringValue, pic: subJson["pic"].stringValue))
                    }
                    self.tableView.reloadData()
                }
                //print(_r)
                
            } else {
                print("Couldn't get a response to check credentials: \(response.data)")
            }
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let reuseIdentifier = "SearchCell"
        var cell = self.tableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as! SearchCell!
        if cell == nil
        {
            cell = SearchCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: reuseIdentifier)
        }
        cell.leftButtons = [MGSwipeButton(title: "", icon: UIImage(named:"addUser.png"), backgroundColor: UIColor.greenColor(), callback: {
            (sender: MGSwipeTableCell!) -> Bool in
            let url : String = "http://192.168.1.121/xj68123wqdgrego2/addFriend.php";
            Alamofire.request(.POST, "\(url)" , parameters:["add_userid" : "\(self.people[indexPath.row].userid)", "userid" : "\(self.credentials.objectForKey("userid")!)"])
            return true
        })]
        
        let person = self.people[indexPath.row]
        cell._name.text = person.username
        let url = NSURL(string: "\(person.pic)")
        let blankImage = UIImage(named: "defaultAvatar.png")
        let filter = AspectScaledToFillSizeCircleFilter(size: CGSize(width: 80, height: 80));
        cell._pic.af_setImageWithURL(url!, placeholderImage: blankImage, filter: filter, imageTransition: UIImageView.ImageTransition.CrossDissolve(1))
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        return cell
    }
    
}