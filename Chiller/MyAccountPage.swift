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

class MyAccountPage : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var libraryButton: UIButton!
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var avatar: UIImageView!
    var imageUrl = NSURL()
    let credentials = NSUserDefaults()
    
    @IBAction func back(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var uploadingPicture: UIActivityIndicatorView!
    override func viewDidLoad() {
        if credentials.objectForKey("pic") != nil {
            let url = NSURL(string: "\(credentials.objectForKey("pic")!)")!
            let blankImage = UIImage()
            self.avatar.image = blankImage;
            let filter = AspectScaledToFillSizeCircleFilter(size: CGSize(width: 100, height: 100));
            self.avatar.af_setImageWithURL(url, placeholderImage: blankImage, filter: filter, imageTransition: UIImageView.ImageTransition.CrossDissolve(0.2))
        }
        let parameters = [
            "username": "\(credentials.objectForKey("username")!)"
        ]
        Alamofire.request(.POST, "http://192.168.1.121/xj68123wqdgrego2/getProfileUrl.php", parameters: parameters).responseJSON() {
            response in
            if (response.data != nil) {
                let _r = JSON(data: response.data!)
                self.credentials.setObject("\(_r["pic"].stringValue)", forKey: "pic")
                let url = NSURL(string: "\(_r["pic"].stringValue)")!
                let blankImage = UIImage()
                self.avatar.image = blankImage;
                let filter = AspectScaledToFillSizeCircleFilter(size: CGSize(width: 100, height: 100));
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
        img = fixImageOrientation(img!)
        let imageData = UIImageJPEGRepresentation(img!, 0.0)
        
        let base64String = imageData!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        
        let parameters = [
            "img": base64String,
            "user": "\(credentials.objectForKey("username")!)"
        ]
        uploadingPicture.startAnimating()
        Alamofire.request(.POST, "http://192.168.1.121/xj68123wqdgrego2/testUpdateProfile.php", parameters:parameters) .responseJSON {
            response in
            print(response)
            self.uploadingPicture.stopAnimating()
        }
        self.dismissViewControllerAnimated(true, completion: nil);
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