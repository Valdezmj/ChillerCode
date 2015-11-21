//
//  FriendSection.swift
//  Chiller
//
//  Created by Michael Valdez on 11/18/15.
//  Copyright © 2015 MK. All rights reserved.
//

import Foundation
import WebKit

class RightCategory : UIViewController, UITableViewDataSource, UITableViewDelegate {
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadPosters()
    }
    @IBOutlet weak var rightTableView: UITableView!
    
    func loadPosters() {
        let photo1 = UIImage(named: "user.png")
        let personOne = Post(name: "Location Name", body: "Beer!", title: "Offering free beer", image: photo1!)
        let personTwo = Post(name: "Location Name", body: "Beer!", title: "Offering free beer", image: photo1!)
        let personThree = Post(name: "Location Name", body: "Beer!", title: "Offering free beer", image: photo1!)
        let personFour = Post(name: "Location Name", body: "Beer!", title: "Offering free beer", image: photo1!)
        let personFive = Post(name: "Location Name", body: "Beer!", title: "Offering free beer", image: photo1!)
        let personSix = Post(name: "Location Name", body: "Beer!", title: "Offering free beer", image: photo1!)
        
        posts += [personOne, personTwo, personThree, personFour, personFive, personSix]
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let reuseIdentifier = "CategoryRightCell"
        var cell = self.rightTableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as! RightCategoryCell!
        if cell == nil
        {
            cell = RightCategoryCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: reuseIdentifier)
        }
        cell.leftButtons = [MGSwipeButton(title: "Delete", backgroundColor: UIColor.redColor()), MGSwipeButton(title: "More",backgroundColor: UIColor.lightGrayColor())]
        cell.leftSwipeSettings.transition = MGSwipeTransition.ClipCenter
        
        cell.rightButtons = [MGSwipeButton(title: "Chill", icon: UIImage(named:"chill.png"), backgroundColor: UIColor.blueColor())
        ]
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