//
//  LibraryGalleryViewCollectionViewController.swift
//  Book
//
//  Created by Aditya Sarkar on 12/4/15.
//  Copyright © 2015 Asad Khaliq. All rights reserved.
//

import UIKit
import CoreData

class LibraryGalleryViewCollectionViewController: UICollectionViewController, UIGestureRecognizerDelegate, UIPopoverPresentationControllerDelegate {
    
    private let reuseIdentifier = "BookCell"
    
    var managedObjectContext: NSManagedObjectContext? = AppDelegate.managedObjectContext
    
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    var books = [Book]()
    

    override func viewDidLoad() {
        let lpgr = UILongPressGestureRecognizer(target: self, action: "handleLongPress:")
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        self.collectionView!.addGestureRecognizer(lpgr)

        
        books = Book.fetchAllBooks(managedObjectContext!)
        super.viewDidLoad()
        self.collectionView?.backgroundColor = UIColor(red:0.91, green:0.91, blue:0.91, alpha:1.0)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

//        // Register cell classes
//        self.collectionView!.registerClass(BookCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        books = Book.fetchAllBooks(managedObjectContext!)
        collectionView?.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func refreshCollection() {
        self.viewDidLoad()
       //self.viewDidAppear(false)
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return books.count
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            
            return CGSize(width: self.view.bounds.width * 0.45, height: self.view.bounds.width * 0.45 * 1.6 * 1.25)
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("BookCell", forIndexPath: indexPath) as! BookCollectionViewCell
        
        let book = books[indexPath.row]
        cell.populateCell(book, viewWidth: self.view.bounds.width * 0.45)
//        cell.backgroundColor = UIColor(red: 136, green: 136, blue: 136, alpha: 1)
        cell.backgroundColor = UIColor(red:0.91, green:0.91, blue:0.91, alpha:1.0)
        
        return cell
    
        // Configure the cell

    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 10.0, left: self.view.bounds.width * 0.025, bottom: 10.0, right: self.view.bounds.width * 0.025)
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

    func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizerState.Ended {
            return
        }
        
        let p = gestureReconizer.locationInView(self.collectionView)
        let indexPath = self.collectionView!.indexPathForItemAtPoint(p)
        
        if let index = indexPath {            
            let popoverContent = (self.storyboard?.instantiateViewControllerWithIdentifier("PopoverController"))! as! PopoverSelectionViewController
            popoverContent.indexPath = index
            let nav = UINavigationController(rootViewController: popoverContent)
            nav.modalPresentationStyle = UIModalPresentationStyle.Popover
            let popover = nav.popoverPresentationController
            popoverContent.preferredContentSize = CGSizeMake(140,60)
            popover!.delegate = self
            popover!.sourceView = self.view
            let rect : CGRect = (collectionView?.layoutAttributesForItemAtIndexPath(indexPath!)!.frame)!
            popover!.sourceRect = rect
            
            self.presentViewController(nav, animated: true, completion: nil)
            
          
            } else {
            print("Could not find index path")
        }
    }
    

    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        // Return no adaptive presentation style, use default presentation behaviour
        return .None
    }

    func popoverPresentationControllerDidDismissPopover(popoverPresentationController: UIPopoverPresentationController) {
        refreshCollection()
    }
   
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "collectionDataSegue" {
                if let path = self.collectionView?.indexPathForCell(sender as! BookCollectionViewCell) {
                    if let seguedToMVC = segue.destinationViewController as? AboutBookPageViewController {
                        let bookSelected = self.books[path.row]
                        seguedToMVC.BookObject = bookSelected
                    }
                }
            }
        }
    }


}
