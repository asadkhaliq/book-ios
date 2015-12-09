//
//  QueueTableViewCell.swift
//  Book
//
//  Created by Aditya Sarkar on 12/6/15.
//  Copyright © 2015 Asad Khaliq. All rights reserved.
//

import UIKit

class QueueTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var coverPhoto: UIImageView!
    
    
    /*
    * Fills in the cell with relevant infor and then also dispatches an async call to get the photo
    */
    func fillCell(book: Book) {
        print("Goes into fill cell")
        title.text = book.title!
        author.text = book.author?.name
        
        let url = NSURL(string: book.coverUrl!)
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) { [weak weakSelf = self] in
            if let imageData = NSData(contentsOfURL: url!) {
                if url == NSURL(string: book.coverUrl!) {
                    dispatch_async(dispatch_get_main_queue()) {
                        weakSelf?.coverPhoto!.image = UIImage(data: imageData)
                        weakSelf?.coverPhoto!.frame = CGRect(x: 0, y: 0, width: self.coverPhoto.frame.width, height: self.coverPhoto.frame.height)
                        weakSelf?.coverPhoto!.contentMode = .ScaleAspectFit
                        
                    }
                    
                }
            }
        }

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
