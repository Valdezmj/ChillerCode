//
//  MyAccountPage.swift
//  Chiller
//
//  Created by Michael Valdez on 12/5/15.
//  Copyright © 2015 MK. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class MyAccountPage : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var postTable: UITableView!
    @IBOutlet weak var libraryButton: UIButton!
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var avatar: UIImageView!
    var posts = [Post]()
    var imageUrl = NSURL()
    let imageDownloader = UIImageView.af_sharedImageDownloader
    let credentials = NSUserDefaults()
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "reloadTable:", forControlEvents: UIControlEvents.ValueChanged)
        
        return refreshControl
    }()
    
    @IBAction func back(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var uploadingPicture: UIActivityIndicatorView!
    
    func reloadTable(sender: AnyObject) {
        loadPosters()
        self.refreshControl.endRefreshing()
    }
    
    override func viewDidLoad() {
        self.postTable.delegate = self
        self.postTable.dataSource = self
        self.loadPosters()
        self.postTable.addSubview(self.refreshControl)
        if credentials.objectForKey("pic") != nil {
            let url = NSURL(string: "\(credentials.objectForKey("pic")!)")!
            let blankImage = UIImage()
            self.avatar.image = blankImage;
            let filter = AspectScaledToFillSizeCircleFilter(size: CGSize(width: 85, height: 85));
            self.avatar.af_setImageWithURL(url, placeholderImage: blankImage, filter: filter, imageTransition: UIImageView.ImageTransition.CrossDissolve(0.2))
        }
        let parameters = [
            "username": "\(credentials.objectForKey("username")!)"
        ]
        Alamofire.request(.POST, "http://kickbakapp.com/xj68123wqdgrego2/getProfileUrl.php", parameters: parameters).responseJSON() {
            response in
            if (response.data != nil) {
                let _r = JSON(data: response.data!)
                self.credentials.setObject("\(_r["pic"].stringValue)", forKey: "pic")
                let url = NSURL(string: "\(_r["pic"].stringValue)")!
                let blankImage = UIImage()
                self.avatar.image = blankImage;
                let filter = AspectScaledToFillSizeCircleFilter(size: CGSize(width: 85, height: 85));
                self.avatar.af_setImageWithURL(url, placeholderImage: blankImage, filter: filter, imageTransition: UIImageView.ImageTransition.CrossDissolve(0.2))
            }
        }
        name.text = String(credentials.objectForKey("name")!)
        age.text = "\(credentials.objectForKey("age")!) years old"
        
        
    }
    
    
    @IBAction func goToLibrary(sender: AnyObject) {
        let myPickerController = UIImagePickerController()
        myPickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        myPickerController.delegate = self
        self.presentViewController(myPickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func takePicture(sender: AnyObject) {
        let myPickerController = UIImagePickerController()
        myPickerController.sourceType = UIImagePickerControllerSourceType.Camera
        myPickerController.delegate = self
        self.presentViewController(myPickerController, animated: true, completion: nil)
        
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        var img = info[UIImagePickerControllerOriginalImage] as? UIImage
        avatar.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        avatar.image = img?.af_imageRoundedIntoCircle()
        avatar.image = avatar.image!.af_imageScaledToSize(CGSize(width: 85, height: 85))
        
        img = fixImageOrientation(img!)
        let imageData = UIImageJPEGRepresentation(img!, 0.0)
        
        let base64String = imageData!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        
        let parameters = [
            "img": base64String,
            "user": "\(credentials.objectForKey("username")!)"
        ]
        uploadingPicture.startAnimating()
        Alamofire.request(.POST, "http://kickbakapp.com/xj68123wqdgrego2/testUpdateProfile.php", parameters:parameters).responseJSON {
            response in
            let _r = JSON(data: response.data!)
            self.uploadingPicture.stopAnimating()
        }
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    func loadPosters() {
        self.posts.removeAll()
        let url : String = "http://kickbakapp.com/xj68123wqdgrego2/getAccountPosts.php";
        Alamofire.request(.POST, "\(url)" , parameters:["username" : "\(credentials.objectForKey("username")!)"]).responseJSON() {
            (response) in
            if response.data != nil {
                let _r = JSON(data: response.data!)
                print("\(_r)")
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
        let blankImage = UIImage(named: "defaultAvatar")
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
    
    func fixImageOrientation(src:UIImage)->UIImage {
        
        if src.imageOrientation == UIImageOrientation.Up {
            return src
        }
        
        var transform: CGAffineTransform = CGAffineTransformIdentity
        
        switch src.imageOrientation {
        case UIImageOrientation.Down, UIImageOrientation.DownMirrored:
            transform = CGAffineTransformTranslate(transform, src.size.width, src.size.height)
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI))
            break
        case UIImageOrientation.Left, UIImageOrientation.LeftMirrored:
            transform = CGAffineTransformTranslate(transform, src.size.width, 0)
            transform = CGAffineTransformRotate(transform, CGFloat(M_PI_2))
            break
        case UIImageOrientation.Right, UIImageOrientation.RightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, src.size.height)
            transform = CGAffineTransformRotate(transform, CGFloat(-M_PI_2))
            break
        case UIImageOrientation.Up, UIImageOrientation.UpMirrored:
            break
        }
        
        switch src.imageOrientation {
        case UIImageOrientation.UpMirrored, UIImageOrientation.DownMirrored:
            CGAffineTransformTranslate(transform, src.size.width, 0)
            CGAffineTransformScale(transform, -1, 1)
            break
        case UIImageOrientation.LeftMirrored, UIImageOrientation.RightMirrored:
            CGAffineTransformTranslate(transform, src.size.height, 0)
            CGAffineTransformScale(transform, -1, 1)
        case UIImageOrientation.Up, UIImageOrientation.Down, UIImageOrientation.Left, UIImageOrientation.Right:
            break
        }
        
        let ctx:CGContextRef = CGBitmapContextCreate(nil, Int(src.size.width), Int(src.size.height), CGImageGetBitsPerComponent(src.CGImage), 0, CGImageGetColorSpace(src.CGImage), CGImageAlphaInfo.PremultipliedLast.rawValue)!
        
        CGContextConcatCTM(ctx, transform)
        
        switch src.imageOrientation {
        case UIImageOrientation.Left, UIImageOrientation.LeftMirrored, UIImageOrientation.Right, UIImageOrientation.RightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0, 0, src.size.height, src.size.width), src.CGImage)
            break
        default:
            CGContextDrawImage(ctx, CGRectMake(0, 0, src.size.width, src.size.height), src.CGImage)
            break
        }
        
        let cgimg:CGImageRef = CGBitmapContextCreateImage(ctx)!
        let img:UIImage = UIImage(CGImage: cgimg)
        
        return img
    }
}