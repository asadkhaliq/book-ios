//
//  AboutBookBiographyViewController.swift
//  Book
//
//  Created by Asad Khaliq on 12/8/15.
//  Copyright © 2015 Asad Khaliq. All rights reserved.
//

import UIKit

class AboutBookBiographyViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var pagesLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    var titleName: String = ""
    var authorName: String = ""
    var pagesNumber: String = ""
    var dateString: String = ""
    var summaryString: String = ""

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text? = titleName
        authorLabel.text? = authorName
        pagesLabel.text? = pagesNumber
        dateLabel.text? = dateString
        summaryLabel.text? = summaryString

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
