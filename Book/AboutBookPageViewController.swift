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
    var identifiers: NSArray = ["MainBookController", "BiographyBookController", "NotesBookController"]
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
            let pages = BookObject?.pages!
            vc.pagesNumber = String(pages!) + " pages"
            let date = BookObject?.dateAdded
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = .MediumStyle
            let string = dateFormatter.stringFromDate(date!)
            vc.dateString = "Added " + string
            vc.summaryString = "This sample book doesn't have a summary, or you've added a book that doesn't have a summary listed on Amazon or Google Books. Nonetheless, here is some text to show that this view works!"
            return vc
        }
        
        if index == 2 {
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("NotesBookController") as! AboutBookNotesViewController
            let date = BookObject?.dateAdded
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = .MediumStyle
            let string = dateFormatter.stringFromDate(date!)
            vc.dateString = "Added " + string
            vc.titleName = (BookObject?.title)!
            vc.BookObject = BookObject
            vc.reasonString = (BookObject?.reason)!
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
