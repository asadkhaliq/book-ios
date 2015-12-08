//
//  BookLibraryTableViewController.swift
//  Book
//
//  Created by Asad Khaliq on 12/2/15.
//  Copyright © 2015 Asad Khaliq. All rights reserved.
//

import UIKit
import CoreData

class BookLibraryTableViewController: UITableViewController {
    
    var managedObjectContext: NSManagedObjectContext? = AppDelegate.managedObjectContext
    
    var allBooks = [Book]()
    var selectedBook : Book? = nil
    
    override func viewDidLoad() {
        updateAllBooks()
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        Book.queueBook(managedObjectContext!, book: allBooks[indexPath.row])
        
    }
    
    override func viewDidAppear(animated: Bool) {
        updateAllBooks()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allBooks.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LibraryCell", forIndexPath: indexPath)
        
        let indexInt : Int = indexPath.row
        
        cell.textLabel!.text = allBooks[indexInt].title
        cell.detailTextLabel?.text = allBooks[indexInt].author!.name
        
        return cell
    }
    
    override func tableView(tableView: UITableView,
        canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
            return true
    }
    
    func updateAllBooks() {
        allBooks = Book.fetchAllBooks(managedObjectContext!)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]?  {
        
        let delete = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            tableView.beginUpdates()

            let bookToRemove = self.allBooks[indexPath.row]

            if (Book.deleteBook(self.managedObjectContext!, book: bookToRemove)) {
                self.updateAllBooks()
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                tableView.endUpdates()
            }
        })
        delete.backgroundColor = UIColor.redColor()
        
        let isQueued = (allBooks[indexPath.row]).isQueued
        var title = "Queue"
        if (isQueued == true) { title = "Dequeue" }
        
        let queue = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: title , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            self.tableView.beginUpdates()
            if (isQueued == false) {
                Book.queueBook(self.managedObjectContext!, book: self.allBooks[indexPath.row])
            } else {
                Book.dequeueBook(self.managedObjectContext!, book: self.allBooks[indexPath.row])
            }
            self.tableView.setEditing(false, animated: true)
            self.tableView.endUpdates()
        })
        queue.backgroundColor = UIColor.greenColor()
        
        return [delete, queue]
    }
    
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "bookDetail" {
                if let path = self.tableView?.indexPathForCell(sender as! UITableViewCell) {
                    if let seguedToMVC = segue.destinationViewController as? AboutBookPageViewController {
                        let bookSelected = self.allBooks[path.row]
                        seguedToMVC.BookObject = bookSelected
                    }
                }
            }
        }
    }

    
}
