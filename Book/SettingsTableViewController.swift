//
//  SettingsTableViewController.swift
//  Book
//
//  Created by Asad Khaliq on 12/3/15.
//  Copyright © 2015 Asad Khaliq. All rights reserved.
//

import UIKit
import CoreData

class SettingsTableViewController: UITableViewController {
    
    private var userDefaults = NSUserDefaults.standardUserDefaults()
    
    
    
    @IBOutlet weak var totalNameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    
    var managedObjectContext: NSManagedObjectContext? = AppDelegate.managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.layer.masksToBounds = false
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        if (userDefaults.stringForKey("firstname") != nil) {
            if (userDefaults.stringForKey("lastname") != nil) {
               self.totalNameLabel.text? = self.userDefaults.stringForKey("firstname")! + " " + self.userDefaults.stringForKey("lastname")!
            }
        }
        if ((userDefaults.objectForKey("profileimage")) != nil) {
            let imageData = userDefaults.objectForKey("profileimage") as! NSData
            let image : UIImage = UIImage(data: imageData)!
            profileImage.image = image
        }
        
        if ((userDefaults.stringForKey("cityname")) != nil) {
            locationLabel.text? = (userDefaults.stringForKey("cityname"))!
        }
    }
    
    @IBAction func deleteAllBooks(sender: UIButton) {
        Book.deleteAllBooks(managedObjectContext!)
    }
    
}
