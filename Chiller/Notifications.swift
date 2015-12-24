//
//  Notifications.swift
//  Chiller
//
//  Created by Michael Valdez on 12/21/15.
//  Copyright © 2015 MK. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage


class Notifications : UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var friendTable: UITableView!
    @IBOutlet weak var notificationTable: UITableView!
    var friendRequest = [FriendRequest]()
    var notifications = [NotificationUpdate]()
    lazy var refreshFriends: UIRefreshControl = {
        let refreshFriends = UIRefreshControl()
        refreshFriends.addTarget(self, action: "reloadFriendTable:", forControlEvents: UIControlEvents.ValueChanged)
        
        return refreshFriends
    }()
    let credentials = NSUserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.definesPresentationContext = true;
        let url : String = "http://baymaar.com/xj68123wqdgrego2/friendRequests.php";
        let urlTwo : String = "http://baymaar.com/xj68123wqdgrego2/friendRequests.php";
        friendTable.delegate = self
        friendTable.dataSource = self
        notificationTable.delegate = self
        notificationTable.dataSource = self
        self.friendTable.addSubview(self.refreshFriends)
        print("RIGHT VIEW LOADED")
        Alamofire.request(.POST, "\(url)" , parameters:["userid" : "\(credentials.objectForKey("userid")!)"]).responseJSON() {
            (response) in
            if response.data != nil {
                let _r = JSON(data: response.data!)
                print(_r)
                if (_r["result"]) {
                    self.friendRequest.removeAll(keepCapacity: false)
                    for (_,subJson):(String, JSON) in _r["requests"] {
                        self.friendRequest.append(FriendRequest(userid: "\(subJson["id"].stringValue)", username: "\(subJson["name"].stringValue)", pic: "\(subJson["pic"].stringValue)"))
                    }
                    self.friendTable.reloadData()
                }
                
            } else {
                print("Couldn't get a response to check credentials: \(response.data)")
            }
        }

        
    }
    
    override func viewDidDisappear(animated: Bool) {
        print("RIGHT VIEW DISAPPEARED")
    }
    override func viewDidAppear(animated: Bool) {
        reloadFriendTable(self)
    }
    
    func reloadFriendTable(sender: AnyObject!) {
        self.friendRequest.removeAll(keepCapacity: false)
        self.friendTable.reloadData()
        let url : String = "http://baymaar.com/xj68123wqdgrego2/friendRequests.php";
        Alamofire.request(.POST, "\(url)" , parameters:["userid" : "\(credentials.objectForKey("userid")!)"]).responseJSON() {
            (response) in
            if response.data != nil {
                let _r = JSON(data: response.data!)
                print(_r)
                if (_r["result"]) {
                    self.friendRequest.removeAll(keepCapacity: false)
                    for (_,subJson):(String, JSON) in _r["requests"] {
                        self.friendRequest.append(FriendRequest(userid: "\(subJson["id"].stringValue)", username: "\(subJson["name"].stringValue)", pic: "\(subJson["pic"].stringValue)"))
                    }
                    self.friendTable.reloadData()
                    self.refreshFriends.endRefreshing()
                }
                
            } else {
                self.refreshFriends.endRefreshing()
                print("Couldn't get a response to check credentials: \(response.data)")
            }
        }
        self.refreshFriends.endRefreshing()

    }
    
    override func viewWillDisappear(animated: Bool) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.friendTable {
            return friendRequest.count
        } else {
            return notifications.count
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var reuseIdentifier = String()
        var __cell = UITableViewCell()
        if tableView == self.friendTable {
            
            
            /* FRIEND TABLE */
            
            
            reuseIdentifier = "FriendRequestCell"
            var cell = self.friendTable.dequeueReusableCellWithIdentifier(reuseIdentifier) as! FriendRequestCell!
            if cell == nil
            {
                cell = FriendRequestCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: reuseIdentifier)
            }
            cell.leftButtons = [MGSwipeButton(title: "", icon: UIImage(named:"delete.png"), backgroundColor: UIColor.redColor(), callback: {
                (sender: MGSwipeTableCell!) -> Bool in
                let url : String = "http://baymaar.com/xj68123wqdgrego2/rejectFriendRequest.php";
                Alamofire.request(.POST, "\(url)" , parameters:["userid" : "\(self.credentials.objectForKey("userid")!)", "add_userid" : "\(self.friendRequest[indexPath.row].userid)"])
                self.friendRequest.removeAtIndex(indexPath.row)
                self.friendTable.reloadData()
                return true
            }), MGSwipeButton(title: "", icon: UIImage(named:"check.png"), backgroundColor: UIColor.greenColor(), callback: {
                (sender: MGSwipeTableCell!) -> Bool in
                let url : String = "http://baymaar.com/xj68123wqdgrego2/acceptFriend.php";
                Alamofire.request(.POST, "\(url)" , parameters:["userid" : "\(self.credentials.objectForKey("userid")!)", "add_userid" : "\(self.friendRequest[indexPath.row].userid)"])
                self.friendRequest.removeAtIndex(indexPath.row)
                self.friendTable.reloadData()
                return true
            })]
            
            let person = self.friendRequest[indexPath.row]
            cell.username.text = person.username
            let url = NSURL(string: "\(person.profilepic)")
            let blankImage = UIImage(named: "defaultAvatar.png")
            let filter = AspectScaledToFillSizeCircleFilter(size: CGSize(width: 80, height: 80));
            cell.profilePic.af_setImageWithURL(url!, placeholderImage: blankImage, filter: filter, imageTransition: UIImageView.ImageTransition.CrossDissolve(1))
            
            return cell
        } else {
            
            /* NOTIFICATION TABLE */

            
            reuseIdentifier = "NotificationCell"
            var cell = self.friendTable.dequeueReusableCellWithIdentifier(reuseIdentifier) as! NotificationCell!
            if cell == nil
            {
                cell = NotificationCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: reuseIdentifier)
            }

        }
        return __cell
    }
    
}