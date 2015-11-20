//
//  FriendSection.swift
//  Chiller
//
//  Created by Michael Valdez on 11/18/15.
//  Copyright © 2015 MK. All rights reserved.
//

import Foundation
import WebKit

class FriendSection : UIViewController, UITableViewDataSource, UITableViewDelegate {
    var posts = [Post]()

    @IBOutlet weak var postTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postTable.delegate = self
        postTable.dataSource = self
        self.loadPosters()
    }
    
    func loadPosters() {
        let photo1 = UIImage(named: "user.png")
        let personOne = Post(name: "Michael Valdez", body: "2499 S. Colorado Blvd.\n put in 904 at the door and I'll let you up.", title: "Party at my house", image: photo1!)
        let personTwo = Post(name: "Karlie Hanson", body: "just watching game of thrones with bay", title: "Netflix and chill", image: photo1!)
        let personThree = Post(name: "Kyle Daniels", body: "text me if you're going", title: "Going to tracks tonight", image: photo1!)
        let personFour = Post(name: "Thirsty Bridge", body: "only come if you looking to get deez nuts", title: "Fuck at my place", image: photo1!)
        let personFive = Post(name: "Austin Muck", body: "I will be your casanova", title: "Make love all night long in my bed", image: photo1!)
        let personSix = Post(name: "Ryan Sanchez", body: "I am a marine so I can beat you and your daddy's ass", title: "Beat down in my tent", image: photo1!)
        
        posts += [personOne, personTwo, personThree, personFour, personFive, personSix]
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let reuseIdentifier = "PostTableViewCell"
        var cell = self.postTable.dequeueReusableCellWithIdentifier(reuseIdentifier) as! PostTableViewCell!
        if cell == nil
        {
            cell = PostTableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: reuseIdentifier)
        }
        cell.leftButtons = [MGSwipeButton(title: "Burn", icon: UIImage(named:"fire.png"), backgroundColor: UIColor.redColor())
            ,MGSwipeButton(title: "Chill", icon: UIImage(named:"chill.png"), backgroundColor: UIColor.blueColor())]
        cell.leftSwipeSettings.transition = MGSwipeTransition.ClipCenter
        
        cell.rightButtons = [MGSwipeButton(title: "Delete", backgroundColor: UIColor.redColor())
            ,MGSwipeButton(title: "More",backgroundColor: UIColor.lightGrayColor())]
        cell.rightSwipeSettings.transition = MGSwipeTransition.ClipCenter
        
        let _post = posts[indexPath.row]
        
        // Configure the cell...
        cell.postname.text = _post.name
        cell.postBody.text = _post.body
        cell.postTitle.text = _post.title
        cell.avatar.image = _post.img
        
        
        return cell
    }
    
}