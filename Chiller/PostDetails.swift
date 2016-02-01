//
//  PostDetails.swift
//  chillur
//
//  Created by Michael Valdez on 1/14/16.
//  Copyright © 2016 MK. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class PostDetails: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var picView: UIView!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var optionsView: UIView!
    @IBOutlet weak var postTable: UITableView!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var pictureBtn: UIButton!
    @IBOutlet weak var avatar: UIImageView!
    var post = [Post]()
    var postDetails = [PostDetailsCellClass]()
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
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var body: UILabel!
    
    @IBOutlet weak var timeStat: UILabel!
    func reloadTable(sender: AnyObject) {
        loadPostInfo()
        self.refreshControl.endRefreshing()
    }
    
    override func viewDidLoad() {
        picView.alpha = 0
        commentView.alpha = 0
        self.postTable.delegate = self
        self.postTable.dataSource = self
        self.loadPostInfo()
        self.postTable.addSubview(self.refreshControl)
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
        img = fixImageOrientation(img!)
        let imageData = UIImageJPEGRepresentation(img!, 0.0)
        
        let base64String = imageData!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        
       /* let parameters = [
            "img": base64String,
            "user": "\(credentials.objectForKey("username")!)"
        ]
        uploadingPicture.startAnimating()
        Alamofire.request(.POST, "http://192.168.1.133/xj68123wqdgrego2/testUpdateProfile.php", parameters:parameters).responseJSON {
            response in
            let _r = JSON(data: response.data!)
            self.uploadingPicture.stopAnimating()
        }*/
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    func loadPostInfo() {
        let url = NSURL(string: self.post[0].img)
        self.name.text = self.post[0].name
        self.postTitle.text = self.post[0].title
        self.body.text = self.post[0].body
        let blankImage = UIImage(named: "defaultAvatar")
        self.avatar.image = blankImage;
        let filter = AspectScaledToFillSizeCircleFilter(size: CGSize(width: 62, height: 58));
        self.avatar.af_setImageWithURL(url!, placeholderImage: blankImage, filter: filter, imageTransition: UIImageView.ImageTransition.CrossDissolve(0.2))
        postDetails.append(PostDetailsCellClass(name: "Mikey Fucking V", body: "This is a test comment mother fucker", image: "\(self.post[0].img!)", time: "14s", pics: "", videos: ""))
        postDetails.append(PostDetailsCellClass(name: "Some random fuck", body: "Check out this pic", image: "\(self.post[0].img)", time: "25m", pics: "\(self.post[0].img)", videos: ""))
        postDetails.append(PostDetailsCellClass(name: "Some random fuck", body: "This is a test comment on this post but made to be extra long so we can see the layout of someone who is ranting on a post and to be honest it looks good and it keeps going just to make sure we really see what the fuck people can do", image: "\(self.post[0].img)", time: "25m", pics: "", videos: ""))
        postDetails.append(PostDetailsCellClass(name: "Some fuck", body: "check out this pic with a really long caption that probably has nothing to do with the fucking picture", image: "\(self.post[0].img)", time: "25m", pics: "\(self.post[0].img)", videos: ""))
        print("Reloading data")
        postTable.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDetails.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var reuseIdentifier = ""
        print("Checking if picture")
        let _post = self.postDetails[indexPath.row]
        if (_post.pic != "") {
            reuseIdentifier = "PostPictureCell"
            let cell = self.postTable.dequeueReusableCellWithIdentifier(reuseIdentifier) as! PostPictureCell!
            let url = NSURL(string: _post.pic)
            let blankImage = UIImage(named: "defaultAvatar")
            let filter = AspectScaledToFillSizeCircleFilter(size: CGSize(width: 45, height: 45))
            let picFilter = AspectScaledToFillSizeFilter(size: CGSize(width: 147, height: 156))
            cell.postPicture.af_setImageWithURL(url!, placeholderImage: blankImage, filter: picFilter, imageTransition: UIImageView.ImageTransition.CrossDissolve(0.2))
            cell.pictureCaption.text = _post.body
            cell.name.text = _post.name
            cell.profilePic.image = blankImage
            cell.profilePic.af_setImageWithURL(url!, placeholderImage: blankImage, filter: filter, imageTransition: UIImageView.ImageTransition.CrossDissolve(0.2))
            cell.preservesSuperviewLayoutMargins = false
            cell.separatorInset = UIEdgeInsetsZero
            cell.layoutMargins = UIEdgeInsetsZero
            return cell
            
        } else {
            print("cell is not picture")
            reuseIdentifier = "PostCommentCell"
            var cell = self.postTable.dequeueReusableCellWithIdentifier(reuseIdentifier) as! PostCommentCell!
            if cell == nil
            {
                cell = PostCommentCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: reuseIdentifier)
            }
            let url = NSURL(string: _post.img)
            let blankImage = UIImage(named: "defaultAvatar")
            let filter = AspectScaledToFillSizeCircleFilter(size: CGSize(width: 45, height: 45));
            cell.comment.text = _post.body
            cell.name.text = _post.name
            cell.profilePic.image = blankImage
            cell.profilePic.af_setImageWithURL(url!, placeholderImage: blankImage, filter: filter, imageTransition: UIImageView.ImageTransition.CrossDissolve(0.2))
            cell.preservesSuperviewLayoutMargins = false
            cell.separatorInset = UIEdgeInsetsZero
            cell.layoutMargins = UIEdgeInsetsZero
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (self.postDetails[indexPath.row].pic != "") {
            return 194
        } else {
            return 120
        }
    }
    
    @IBAction func showPic(sender: AnyObject) {
        UIView.animateWithDuration(0.5, delay: 0.0, options: [.CurveEaseIn], animations: {
            if self.commentView.alpha > 0 {
                self.commentView.alpha = 0
            }
            self.postTable.center.y += self.picView.bounds.height - 2
            self.picView.alpha = 1
            self.commentBtn.alpha = 0
            self.pictureBtn.alpha = 0
            }, completion: nil)
    }
    
    @IBAction func showComment(sender: AnyObject) {
        UIView.animateWithDuration(0.5, delay: 0.0, options: [.CurveEaseIn], animations: {
            self.postTable.center.y += self.commentView.bounds.height - 2
            self.commentBtn.alpha = 0
            self.pictureBtn.alpha = 0
            self.commentView.alpha = 1
            }, completion: nil)
        
    }
    
    @IBAction func cancel(sender: AnyObject) {
        UIView.animateWithDuration(0.5, delay: 0.0, options: [.CurveEaseIn], animations: {
            if self.commentView.alpha == 1 {
                self.postTable.center.y -= self.commentView.bounds.height - 2
            } else {
                self.postTable.center.y -= self.picView.bounds.height - 2

            }
            self.commentView.alpha = 0
            self.picView.alpha = 0
            self.commentBtn.alpha = 1
            self.pictureBtn.alpha = 1
            }, completion: nil)
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