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
import Alamofire



class FriendSection : UIViewController, UITableViewDataSource, UITableViewDelegate, UIPopoverPresentationControllerDelegate {
    @IBOutlet weak var postBtn: UIButton!
    var posts = [Post]()
    var defaultImage  = UIImage()
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "reloadTable:", forControlEvents: UIControlEvents.ValueChanged)
        
        return refreshControl
    }()
    let credentials = NSUserDefaults()
    let imageDownloader = UIImageView.af_sharedImageDownloader
    let cache = AutoPurgingImageCache()
    var selectedPost = 0


    @IBOutlet weak var postTable: UITableView!
    
    @IBAction func displayPostCreation(sender: AnyObject!) {
            
    }
    @IBAction func reloadTable(sender: AnyObject) {
        loadPosters()
        self.refreshControl.endRefreshing()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "goPostDetails") {
            let postController = segue.destinationViewController as! PostDetails
            postController.post.append(posts[selectedPost])
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postTable.delegate = self
        postTable.dataSource = self
        print("view did load!")
        if ((credentials.objectForKey("username")) != nil) {
            loadPosters()
        }
        self.postTable.backgroundColor = UIColor(white: 1, alpha: 0.0)
        self.view.backgroundColor = UIColor(white: 1, alpha: 0.0)
        self.postTable.addSubview(self.refreshControl)
    }
    override func viewWillAppear(animated: Bool) {
        }
    
    func loadPosters() {
        self.posts.removeAll()
        let url : String = "http://kickbakapp.com/xj68123wqdgrego2/getPosts.php";
        Alamofire.request(.POST, "\(url)" , parameters:["username" : "\(credentials.objectForKey("username")!)"]).responseJSON() {
            (response) in
            if response.data != nil {
                let _r = JSON(data: response.data!)
                if (_r["result"].string == "1") {
                    for (_,subJson):(String, JSON) in _r["posts"] {
                        self.posts.append(Post(name: subJson["user"]["name"].stringValue, body: subJson["post"]["body"].stringValue, title: subJson["post"]["title"].stringValue, image: subJson["user"]["pic"].stringValue, chill: false, burn: false, time: subJson["post"]["time"].stringValue, comments: "100 comments", pics: "100+ pics", videos: "100+ videos"))
                    }
                    self.postTable.reloadData()
                }
                
            } else {
                print("Couldn't get a response to check credentials: \(response.data)")
            }
        }
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
           /* self.posts[indexPath.row].burn = !self.posts[indexPath.row].burn
            if (self.posts[indexPath.row].burn == true && self.posts[indexPath.row].chill == true) {
                self.posts[indexPath.row].chill = false
            }
            if (self.posts[indexPath.row].burn == true) {
                cell.chillTag.text = "burned"
            }
            self.postTable.reloadData()*/
            return true
        })
            ,MGSwipeButton(title: "Chill", icon: UIImage(named:"chill.png"), backgroundColor: UIColor.blueColor(), callback: {
                (sender: MGSwipeTableCell!) -> Bool in
                /*self.posts[indexPath.row].chill = !self.posts[indexPath.row].chill
                if (self.posts[indexPath.row].burn == true && self.posts[indexPath.row].chill == true) {
                    self.posts[indexPath.row].burn = false
                }
                if (self.posts[indexPath.row].chill == true) {
                    cell.chillTag.text = "chilling"
                }
                self.postTable.reloadData()*/
                return true
            })]
        cell.leftSwipeSettings.transition = MGSwipeTransition.ClipCenter
        
        /*cell.rightButtons = [MGSwipeButton(title: "Delete", backgroundColor: UIColor.redColor(),callback: {
            (sender: MGSwipeTableCell!) -> Bool in
            self.posts.removeAtIndex(indexPath.row)
            self.postTable.reloadData()
            return true
        })]
        cell.rightSwipeSettings.transition = MGSwipeTransition.ClipCenter*/
        
        let _post = posts[indexPath.row]
        
        // Configure the cell...
        cell.postname.text = _post.name
        cell.postBody.text = _post.body
        cell.postTitle.text = _post.title
        cell.postTime.text = _post.time
        cell.postComments.text = _post.comments
        cell.postPictures.text = _post.pics
        cell.postVideo.text = _post.videos
        //cell.chillTag.hidden = (!_post.burn.boolValue && !_post.chill.boolValue)
        /*if (_post.burn == true) {
            cell.chillTag.backgroundColor = UIColor.redColor()
            cell.chillTag.text = "burned"
        } else {
            cell.chillTag.backgroundColor = UIColor.blueColor()
            cell.chillTag.text = "chilling"
        }*/
        let url = NSURL(string: _post.img)
        let request = NSURLRequest(URL: url!)
        imageDownloader.imageCache?.removeImageForRequest(request, withAdditionalIdentifier: "avatar")
        let blankImage = UIImage(named: "")
        cell.avatar.image = blankImage;
        let filter = AspectScaledToFillSizeCircleFilter(size: CGSize(width: 45, height: 45));
        cell.avatar.af_setImageWithURL(url!, placeholderImage: blankImage, filter: filter, imageTransition: UIImageView.ImageTransition.CrossDissolve(0.2))
        print("Cell loaded!")
        cell.backgroundColor = UIColor.clearColor()
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedPost = indexPath.row
        self.performSegueWithIdentifier("goPostDetails", sender: self)
    }
}