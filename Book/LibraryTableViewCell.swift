//
//  LibraryTableViewCell.swift
//  Book
//
//  Created by Asad Khaliq on 12/9/15.
//  Copyright © 2015 Asad Khaliq. All rights reserved.
//

import UIKit

class LibraryTableViewCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pagesLabel: UILabel!
    
    @IBOutlet weak var priorityIndicatorLabel: UIView!
    
    func fillCell(book: Book) {
        titleLabel.text = book.title!
        authorLabel.text = book.author?.name
        pagesLabel.text = String(book.pages!) + "pages"
        
        let priorityNumber = Int(book.priority!)!
        
        switch priorityNumber {
        case 0: priorityIndicatorLabel.backgroundColor = UIColor.redColor()
        case 1: priorityIndicatorLabel.backgroundColor = UIColor.yellowColor()
        case 2: priorityIndicatorLabel.backgroundColor = UIColor.greenColor()
        default: priorityIndicatorLabel.backgroundColor = UIColor.blackColor()
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
