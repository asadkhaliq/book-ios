//
//  WidgetTableViewCell.swift
//  Book
//
//  Created by Asad Khaliq on 12/9/15.
//  Copyright © 2015 Asad Khaliq. All rights reserved.
//

import UIKit

class WidgetTableViewCell: UITableViewCell {

    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var bgView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
