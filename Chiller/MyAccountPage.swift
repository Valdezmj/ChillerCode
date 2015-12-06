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
    
    @IBOutlet weak var uploadingPicture: UIActivityIndicatorView!
    override func viewDidLoad() {
        let url = NSURL(string: "http://baymaar.com/profile_pic/\(credentials.objectForKey("username")!)/profile.png")!
        let blankImage = UIImage()
        avatar.image = blankImage;
        let filter = AspectScaledToFillSizeCircleFilter(size: CGSize(width: 100, height: 100));
        avatar.af_setImageWithURL(url, placeholderImage: blankImage, filter: filter, imageTransition: UIImageView.ImageTransition.CrossDissolve(1))
        
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
        print("image picked!")
        let img = info[UIImagePickerControllerOriginalImage] as? UIImage
        avatar.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        let imageData = UIImagePNGRepresentation(img!)
        
        let base64String = imageData!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        
        let parameters = [
            "img": base64String,
            "user": "\(credentials.objectForKey("username")!)"
        ]
        uploadingPicture.startAnimating()
        Alamofire.request(.POST, "http://baymaar.com/xj68123wqdgrego2/testUpdateProfile.php", parameters:parameters) .responseJSON {
            response in
            print(response)
            self.uploadingPicture.stopAnimating()
        }
        self.dismissViewControllerAnimated(true, completion: nil);
    }
}