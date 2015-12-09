//
//  ReadingQueueTableViewController.swift
//  Book
//
//  Created by Asad Khaliq on 12/5/15.
//  Copyright © 2015 Asad Khaliq. All rights reserved.
//

import UIKit
import CoreData

class ReadingQueueTableViewController: UITableViewController {
    
    var managedObjectContext: NSManagedObjectContext? = AppDelegate.managedObjectContext
    private var userDefaults = NSUserDefaults.standardUserDefaults()

    var queuedBooks = [Book]()
    
    override func viewDidLoad() {
        loadQueuedBooks()
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        loadQueuedBooks()
        tableView.reloadData()
    }
    
    func loadQueuedBooks() {
        queuedBooks = Book.fetchAllQueuedBooks(managedObjectContext!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //Book.dequeueBook(managedObjectContext!, book: queuedBooks[indexPath.row])
//        performSegueWithIdentifier("detailFromQueue", sender: self)
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return queuedBooks.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("queueCell", forIndexPath: indexPath) as? QueueTableViewCell

        let indexInt : Int = indexPath.row
        
        cell!.fillCell(queuedBooks[indexInt])
       
        

        return cell!
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?  {
        
        let isQueued = (queuedBooks[indexPath.row]).isQueued
        var title = "Queue"
        if (isQueued == true) { title = "Dequeue" }
        
        let queue = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: title , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            self.tableView.beginUpdates()
            if (isQueued == false) {
                Book.queueBook(self.managedObjectContext!, book: self.queuedBooks[indexPath.row])
            } else {
                Book.dequeueBook(self.managedObjectContext!, book: self.queuedBooks[indexPath.row])
            }
            self.tableView.setEditing(false, animated: true)
            self.loadQueuedBooks()
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            self.tableView.endUpdates()
        })
        queue.backgroundColor = UIColor.greenColor()
        
        return [queue]
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    @IBAction func shareClicked(sender: UIButton) {
        let button = sender 
        let view = button.superview!
        let cell = view.superview!.superview!.superview!.superview! as! QueueTableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        
        let bookName = self.queuedBooks[indexPath!.row].title
        let textToShare = bookName! + " is an amazing read! Using the Queue app to help manage my reading schedule. It's amazing!"
        if let myName = (userDefaults.stringForKey("firstname"))
        {
            let objectsToShare = [textToShare, myName]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            self.presentViewController(activityVC, animated: true, completion: nil)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "detailFromQueue" {
                if let path = self.tableView?.indexPathForCell(sender as! QueueTableViewCell) {
                    if let seguedToMVC = segue.destinationViewController as? AboutBookPageViewController {
                        let bookSelected = queuedBooks[path.row]
                        seguedToMVC.BookObject = bookSelected
                    }
                }
            }
        }
    }

}
