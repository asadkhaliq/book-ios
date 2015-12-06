//
//  BookCollectionViewCell.swift
//  Book
//
//  Created by Aditya Sarkar on 12/5/15.
//  Copyright © 2015 Asad Khaliq. All rights reserved.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bookCover: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    
    func populateCell(item: Book, viewWidth: CGFloat) {
        print(item.title)
        print(item.author?.name)
        bookTitle.text = item.title
        bookAuthor.text = item.author?.name
        
        let url = NSURL(string: item.coverUrl!)
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) { [weak weakSelf = self] in
            if let imageData = NSData(contentsOfURL: url!) {
                if url == NSURL(string: item.coverUrl!) {
                    dispatch_async(dispatch_get_main_queue()) {
                        weakSelf?.bookCover!.image = UIImage(data: imageData)
                        weakSelf?.bookCover!.frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewWidth * 1.6)
                        weakSelf?.bookCover!.contentMode = .ScaleAspectFit
                        
                    }
                    
                }
            }
        }
        print("Widht")
        print(self.bookCover.bounds)
        
        
    }
    
    
}
