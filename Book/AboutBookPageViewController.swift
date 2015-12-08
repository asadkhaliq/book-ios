//
//  AboutBookPageViewController.swift
//  Book
//
//  Created by Asad Khaliq on 12/8/15.
//  Copyright © 2015 Asad Khaliq. All rights reserved.
//

import UIKit

class AboutBookPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    // REMOVE COMMENTS FROM THIS PAGE THEY ARE FROM STACK OVERFLOW, MUST CITE
    
    var BookObject : Book?
    
    var index = 0
    var identifiers: NSArray = ["MainBookController", "BiographyBookController", "NotesBookController", "BookMapController"]
    override func viewDidLoad() {
        self.dataSource = self
        self.delegate = self
        
        let startingViewController = self.viewControllerAtIndex(self.index)
        let viewControllers: NSArray = [startingViewController]
        self.setViewControllers(viewControllers as? [UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
    }
    
    func viewControllerAtIndex(index: Int) -> UIViewController! {
        
        if index == 0 {
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("MainBookController") as! AboutBookMainViewController
            vc.bookName = (BookObject?.title)!
            return vc
        }
        
        if index == 1 {
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("BiographyBookController") as! AboutBookBiographyViewController
            return vc
        }
        
        if index == 2 {
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("NotesBookController") as! AboutBookNotesViewController
            return vc
        }
        
        if index == 3 {
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("BookMapController") as! AboutBookMapViewController
            return vc
        }
        
        return nil
    }
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let identifier = viewController.restorationIdentifier
        let index = self.identifiers.indexOfObject(identifier!)
        
        //if the index is the end of the array, return nil since we dont want a view controller after the last one
        if index == identifiers.count - 1 {
            
            return nil
        }
        
        //increment the index to get the viewController after the current index
        self.index = self.index + 1
        return self.viewControllerAtIndex(self.index)
        
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let identifier = viewController.restorationIdentifier
        let index = self.identifiers.indexOfObject(identifier!)
        
        //if the index is 0, return nil since we dont want a view controller before the first one
        if index == 0 {
            
            return nil
        }
        
        //decrement the index to get the viewController before the current one
        self.index = self.index - 1
        return self.viewControllerAtIndex(self.index)
        
    }
    
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.identifiers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
