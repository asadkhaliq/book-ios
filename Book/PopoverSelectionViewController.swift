//
//  PopoverSelectionViewController.swift
//  Book
//
//  Created by Asad Khaliq on 12/9/15.
//  Copyright © 2015 Asad Khaliq. All rights reserved.
//

import UIKit
import CoreData

class PopoverSelectionViewController: UIViewController {
    
    var indexPath : NSIndexPath?
    
    var managedObjectContext: NSManagedObjectContext? = AppDelegate.managedObjectContext
    
    var allBooks = [Book]()
    var selectedBook : Book? = nil


    @IBOutlet weak var deleteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deleteClicked(sender: AnyObject) {
        let bookToRemove = (Book.fetchAllBooks(managedObjectContext!))[indexPath!.row]
        Book.deleteBook(self.managedObjectContext!, book: bookToRemove)
        self.popoverPresentationController?.delegate?.popoverPresentationControllerDidDismissPopover!(self.popoverPresentationController!)
        self.dismissViewControllerAnimated(true, completion: nil)
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
