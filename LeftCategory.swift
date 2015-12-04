//
//  FriendSection.swift
//  Chiller
//
//  Created by Michael Valdez on 11/18/15.
//  Copyright © 2015 MK. All rights reserved.
//

import Foundation
import WebKit

class LeftCategory : UIViewController, UITableViewDataSource, UITableViewDelegate {
    var posts = [Post]()

    @IBOutlet weak var leftTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadPosters()        
    }
    
    func loadPosters() {
        let photo1 = UIImage(named: "user.png")
        let personOne = Post(name: "Location Name", body: "Free pancakes only today!", title: "Offering free pancakes", image: photo1!)
        let personTwo = Post(name: "Location Name", body: "Free pancakes only today!", title: "Offering free pancakes", image: photo1!)
        let personThree = Post(name: "Location Name", body: "Free pancakes only today!", title: "Offering free pancakes", image: photo1!)
        let personFour = Post(name: "Location Name", body: "Free pancakes only today!", title: "Offering free pancakes", image: photo1!)
        let personFive = Post(name: "Location Name", body: "Free pancakes only today!", title: "Offering free pancakes", image: photo1!)
        let personSix = Post(name: "Location Name", body: "Free pancakes only today!", title: "Offering free pancakes", image: photo1!)
        
        posts += [personOne, personTwo, personThree, personFour, personFive, personSix]
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let reuseIdentifier = "CategoryLeftCell"
        var cell = self.leftTableView.dequeueReusableCellWithIdentifier(reuseIdentifier) as! LeftCategoryCell!
        if cell == nil
        {
            cell = LeftCategoryCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: reuseIdentifier)
        }
        cell.rightButtons = [MGSwipeButton(title: "Delete", backgroundColor: UIColor.redColor())]
        cell.rightSwipeSettings.transition = MGSwipeTransition.ClipCenter
        
        cell.leftButtons = [MGSwipeButton(title: "Chill", icon: UIImage(named:"chill.png"), backgroundColor: UIColor.blueColor())
            ]
        cell.leftSwipeSettings.transition = MGSwipeTransition.ClipCenter
        
        let _post = posts[indexPath.row]
        
        // Configure the cell...
        cell.postname.text = _post.name
        cell.postBody.text = _post.body
        cell.postTitle.text = _post.title
        cell.avatar.image = _post.img
        
        return cell
    }
}