//
//  CommentPosts.swift
//  chillur
//
//  Created by Michael Valdez on 1/20/16.
//  Copyright © 2016 MK. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class CommentPosts : UIViewController {
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var picView: UIView!
    @IBOutlet weak var optionsView: UIView!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var picBtn: UIButton!
    @IBOutlet weak var videoBtn: UIButton!
    
    override func viewDidLoad() {
        picView.alpha = 0
        commentView.alpha = 0
        
    }
    override func viewDidAppear(animated: Bool) {
        picView.alpha = 0
        commentView.alpha = 0
    }
    
    @IBAction func showPic(sender: AnyObject) {
        UIView.animateWithDuration(0.8, delay: 0.3, options: [.CurveEaseIn], animations: {
            if self.commentView.alpha > 0 {
                self.commentView.alpha = 0
            }
            self.picView.alpha = 1
            self.optionsView.alpha = 0
            self.commentBtn.imageView!.bounds.size = CGSize(width: self.commentBtn.bounds.width, height: 0)
            self.picBtn.imageView!.bounds.size = CGSize(width: self.picBtn.bounds.width, height: 0)
            self.videoBtn.imageView!.bounds.size = CGSize(width: self.videoBtn.bounds.width, height: 0)

            }, completion: nil)
    }
    
    @IBAction func showComment(sender: AnyObject) {
        UIView.animateWithDuration(0.8, delay: 0.3, options: [.CurveEaseIn], animations: {
            if self.picView.alpha > 0 {
                self.picView.alpha = 0
            }
            self.optionsView.alpha = 0
            self.commentBtn.imageView!.alpha = 0
            self.commentBtn.imageView!.bounds.size = CGSize(width: self.commentBtn.bounds.width, height: 0)
            self.picBtn.imageView!.bounds.size = CGSize(width: self.picBtn.bounds.width, height: 0)
            self.videoBtn.imageView!.bounds.size = CGSize(width: self.videoBtn.bounds.width, height: 0)
            self.commentView.alpha = 1
            }, completion: nil)
        
    }
    
    @IBAction func cancel(sender: AnyObject) {
        UIView.animateWithDuration(0.8, delay: 0.3, options: [.CurveEaseIn], animations: {
            self.commentView.alpha = 0
            self.picView.alpha = 0
            self.optionsView.alpha = 1
            self.commentBtn.imageView!.bounds.size = CGSize(width: self.commentBtn.bounds.width, height: 25)
            self.picBtn.imageView!.bounds.size = CGSize(width: self.picBtn.bounds.width, height: 25)
            self.videoBtn.imageView!.bounds.size = CGSize(width: self.videoBtn.bounds.width, height: 25)
            }, completion: nil)
    }
}