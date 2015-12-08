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
    
    func fillCell(book: Book) {
        print("Goes into fill cell")
        title.text = book.title!
        author.text = book.author?.name
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
