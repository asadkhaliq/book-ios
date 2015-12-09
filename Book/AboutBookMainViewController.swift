//
//  AboutBookMainViewController.swift
//  Book
//
//  Created by Asad Khaliq on 12/8/15.
//  Copyright © 2015 Asad Khaliq. All rights reserved.
//

import UIKit

class AboutBookMainViewController: UIViewController {
    
    var bookName: String = ""
    var authorName: String = ""
    var coverURL: String = ""
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var coverImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainLabel.text? = bookName
        authorLabel.text? = authorName
        
        let url = NSURL(string: coverURL)
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) { [weak weakSelf = self] in
            if let imageData = NSData(contentsOfURL: url!) {
                if url == NSURL(string: self.coverURL) {
                    dispatch_async(dispatch_get_main_queue()) {
                        weakSelf?.coverImage!.image = UIImage(data: imageData)
                        weakSelf?.coverImage!.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                        weakSelf?.coverImage!.contentMode = .ScaleAspectFit
                        
                    }
                    
                }
            }
        }


        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
