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
    
    override func tableView(tableView: UITableView,
        didSelectRowAtIndexPath indexPath: NSIndexPath) {
            if indexPath.section == 3 && indexPath.row == 0 {
                Book.addBook("Zero to One", withCover: "http://t1.gstatic.com/images?q=tbn:ANd9GcTI_ooZzjy49uuu0Shtt6mOlIxLIEZ4Qd5DRJgS7z9asXEoHP5J", withISBN: "No ISBN Found", numPages: 224, withPriority: "0", because: "An insightful look into the world of business", withCategory: "Entrepreneurship", writtenBy: "Peter Thiel", withContext: managedObjectContext!)
                
                Book.addBook("Lean In", withCover: "http://ecx.images-amazon.com/images/I/41i-ZAidwOL._SX286_BO1,204,203,200_.jpg", withISBN: "No ISBN Found", numPages: 240, withPriority: "2", because: "Important facts on women in business.", withCategory: "Gender", writtenBy: "Sheryl Sandberg", withContext: managedObjectContext!)

                
                Book.addBook("Meditations", withCover: "http://ecx.images-amazon.com/images/I/71dwCdjTA-L.jpg", withISBN: "No ISBN Found", numPages: 112, withPriority: "1", because: "Spiritual development.", withCategory: "Personal", writtenBy: "Marcus Aurelius", withContext: managedObjectContext!)
                
                userDefaults.setObject("jdoe137", forKey: "username")
                userDefaults.setObject("John", forKey: "firstname")
                userDefaults.setObject("Doe", forKey: "lastname")
                userDefaults.setObject("Budapest", forKey: "cityname")
                
                let image : UIImage = UIImage(named:"sample2.jpg")!
                let dataImage : NSData = UIImagePNGRepresentation(image)!
                userDefaults.setObject(dataImage, forKey: "profileimage")
                self.viewDidAppear(true)
       }
            if indexPath.section == 3 && indexPath.row == 1 {
                Book.deleteAllBooks(managedObjectContext!)
            }
    }
    
}
