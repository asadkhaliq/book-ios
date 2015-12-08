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
        Book.queueBook(managedObjectContext!, book: allBooks[indexPath.row])
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
        cell.detailTextLabel!.text = allBooks[indexInt].author!.name
        
        return cell
    }
    
    override func tableView(tableView: UITableView,
        canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
            return true
    }
    
    func updateAllBooks() {
        allBooks = Book.fetchAllBooks(managedObjectContext!)
    }
    
    override func tableView(tableView: UITableView,
        commitEditingStyle
        editingStyle: UITableViewCellEditingStyle,
        forRowAtIndexPath indexPath: NSIndexPath) {
            
            if editingStyle == UITableViewCellEditingStyle.Delete {
                
                tableView.beginUpdates()
                
                let bookToRemove = allBooks[indexPath.row]
                
                if (Book.deleteBook(managedObjectContext!, book: bookToRemove)) {
                    updateAllBooks()
                    print("goesInHere")
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                    tableView.endUpdates()
                }
            }
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
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
