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



class FriendSection : UIViewController, UITableViewDataSource, UITableViewDelegate {
    var posts = [Post]()
    var defaultImage  = UIImage()
    @IBOutlet weak var postTable: UITableView!
    
    @IBAction func reloadTable(sender: AnyObject) {
        loadPosters()
        let credentials = NSUserDefaults()
        let url = NSURL(string: "http://baymaar.com/profile_pic/\(credentials.objectForKey("username")!)/profile.png")!
        let URLRequest = NSURLRequest(URL: url)
        
        let imageDownloader = UIImageView.af_sharedImageDownloader
        imageDownloader.imageCache?.removeAllImages()
        // Clear the URLRequest from the on-disk cache
        imageDownloader.sessionManager.session.configuration.URLCache?.removeCachedResponseForRequest(URLRequest)
        self.postTable.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        postTable.delegate = self
        postTable.dataSource = self
        print("view did load!")
        loadPosters()
    }
    override func viewWillAppear(animated: Bool) {
        }
    
    func loadPosters() {
        print("Posters loaded!")
        let personOne = Post(name: "Michael Valdez", body: "2499 S. Colorado Blvd.\n put in 904 at the door and I'll let you up.", title: "Party at my house", image: defaultImage, chill: false, burn: false)
        let personTwo = Post(name: "Karlie Hanson", body: "just watching game of thrones with bay", title: "Netflix and chill", image: defaultImage, chill: false, burn: false)
        let personThree = Post(name: "Kyle Daniels", body: "text me if you're going", title: "Going to tracks tonight", image: defaultImage, chill: false, burn: false)
        let personFour = Post(name: "Thirsty Bridge", body: "only come if you looking to get deez nuts", title: "Fuck at my place", image: defaultImage, chill: false, burn: false)
        let personFive = Post(name: "Austin Muck", body: "I will be your casanova", title: "Make love all night long in my bed", image: defaultImage, chill: false, burn: false)
        let personSix = Post(name: "Ryan Sanchez", body: "I am a marine so I can beat you and your daddy's ass", title: "Beat down in my tent", image: defaultImage, chill: false, burn: false)
        
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
        cell.leftButtons = [MGSwipeButton(title: "Burn", icon: UIImage(named:"fire.png"), backgroundColor: UIColor.redColor(), callback: {
            (sender: MGSwipeTableCell!) -> Bool in
            self.posts[indexPath.row].burn = !self.posts[indexPath.row].burn
            if (self.posts[indexPath.row].burn == true && self.posts[indexPath.row].chill == true) {
                self.posts[indexPath.row].chill = false
            }
            if (self.posts[indexPath.row].burn == true) {
                cell.chillTag.text = "BURNED"
            }
            self.postTable.reloadData()
            return true
        })
            ,MGSwipeButton(title: "Chill", icon: UIImage(named:"chill.png"), backgroundColor: UIColor.blueColor(), callback: {
                (sender: MGSwipeTableCell!) -> Bool in
                self.posts[indexPath.row].chill = !self.posts[indexPath.row].chill
                if (self.posts[indexPath.row].burn == true && self.posts[indexPath.row].chill == true) {
                    self.posts[indexPath.row].burn = false
                }
                if (self.posts[indexPath.row].chill == true) {
                    cell.chillTag.text = "chilling"
                }
                self.postTable.reloadData()
                return true
            })]
        cell.leftSwipeSettings.transition = MGSwipeTransition.ClipCenter
        
        cell.rightButtons = [MGSwipeButton(title: "Delete", backgroundColor: UIColor.redColor(),callback: {
            (sender: MGSwipeTableCell!) -> Bool in
            self.posts.removeAtIndex(indexPath.row)
            self.postTable.reloadData()
            return true
        })]
        cell.rightSwipeSettings.transition = MGSwipeTransition.ClipCenter
        
        let _post = posts[indexPath.row]
        
        // Configure the cell...
        cell.postname.text = _post.name
        cell.postBody.text = _post.body
        cell.postTitle.text = _post.title
        cell.chillTag.hidden = (!_post.burn.boolValue && !_post.chill.boolValue)
        if (_post.burn == true) {
            cell.chillTag.backgroundColor = UIColor.redColor()
            cell.chillTag.text = "burned"
        } else {
            cell.chillTag.backgroundColor = UIColor.blueColor()
            cell.chillTag.text = "chilling"
        }
        let credentials = NSUserDefaults()
        let url = NSURL(string: "http://baymaar.com/profile_pic/\(credentials.objectForKey("username")!)/profile.png")!
        let blankImage = UIImage(named: "")
        let filter = AspectScaledToFillSizeCircleFilter(size: CGSize(width: 100, height: 100));
        cell.avatar.af_setImageWithURL(url, placeholderImage: blankImage, filter: filter, imageTransition: UIImageView.ImageTransition.CrossDissolve(1))
        print("Cell loaded!")
        return cell
    }
}