//
//  FriendSection.swift
//  Chiller
//
//  Created by Michael Valdez on 11/18/15.
//  Copyright © 2015 MK. All rights reserved.
//

import Foundation
import WebKit
import AlamofireImage

class LeftCategory : UIViewController, UITableViewDataSource, UITableViewDelegate {
    var posts = [Post]()
    let credentials = NSUserDefaults()

    @IBOutlet weak var leftTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadPosters()        
    }
    
    func loadPosters() {
        let photo1 = UIImage(named: "tracks")
        let personOne = Post(name: "Location Name", body: "Free pancakes only today!", title: "Offering free pancakes", image: photo1!, chill: false, burn: false)
        let personTwo = Post(name: "Location Name", body: "Free pancakes only today!", title: "Offering free pancakes", image: photo1!, chill: false, burn: false)
        let personThree = Post(name: "Location Name", body: "Free pancakes only today!", title: "Offering free pancakes", image: photo1!, chill: false, burn: false)
        let personFour = Post(name: "Location Name", body: "Free pancakes only today!", title: "Offering free pancakes", image: photo1!, chill: false, burn: false)
        let personFive = Post(name: "Location Name", body: "Free pancakes only today!", title: "Offering free pancakes", image: photo1!, chill: false, burn: false)
        let personSix = Post(name: "Location Name", body: "Free pancakes only today!", title: "Offering free pancakes", image: photo1!, chill: false, burn: false)
        
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
        //cell.avatar.image = _post.img
        let url = NSURL(string: "http://baymaar.com/profile_pic/beta/profile.png")!
        let blankImage = UIImage()
        let filter = RoundedCornersFilter(radius: 15.0)
        cell.avatar.af_setImageWithURL(url, placeholderImage: blankImage, filter: filter, imageTransition: UIImageView.ImageTransition.CrossDissolve(1))

        
        return cell
    }
}