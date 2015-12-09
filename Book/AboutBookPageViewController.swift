//
//  AboutBookPageViewController.swift
//  Book
//
//  Created by Asad Khaliq on 12/8/15.
//  Copyright © 2015 Asad Khaliq. All rights reserved.
//

import UIKit

class AboutBookPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
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
            vc.authorName = (BookObject?.author!.name)!
            vc.coverURL = (BookObject?.coverUrl)!
            return vc
        }
        
        if index == 1 {
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("BiographyBookController") as! AboutBookBiographyViewController
            vc.titleName = (BookObject?.title)!
            vc.authorName = (BookObject?.author!.name)!
            vc.pagesNumber = (String(BookObject?.pages!))
            vc.dateString = (String(BookObject?.dateAdded!))
            vc.summaryString = "Could not load summary from Amazon.com!"
            return vc
        }
        
        if index == 2 {
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("NotesBookController") as! AboutBookNotesViewController
            vc.dateString = (String(BookObject?.dateAdded!))
            vc.titleName = (BookObject?.title)!
            vc.reasonString = (BookObject?.reason)!
            vc.notesString = "Sorry, no notes have been input!"

            return vc
        }
        
        if index == 3 {
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("BookMapController") as! AboutBookMapViewController
            return vc
        }
        
        return nil
    }
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let identifier = viewController.restorationIdentifier
        let currentIndex = identifiers.indexOfObject(identifier!)
        let previousIndex = abs((currentIndex - 1) % identifiers.count)
        return viewControllerAtIndex(previousIndex)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let identifier = viewController.restorationIdentifier
        let currentIndex = identifiers.indexOfObject(identifier!)
        let previousIndex = abs((currentIndex + 1) % identifiers.count)
        return viewControllerAtIndex(previousIndex)
    }

    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.identifiers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
