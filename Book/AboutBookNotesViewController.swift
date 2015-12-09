//
//  AboutBookNotesViewController.swift
//  Book
//
//  Created by Asad Khaliq on 12/8/15.
//  Copyright © 2015 Asad Khaliq. All rights reserved.
//

import UIKit

class AboutBookNotesViewController: UIViewController {

    @IBOutlet weak var dateAddedLabel: UILabel!
    @IBOutlet weak var markCompleteButton: UIButton!
    @IBOutlet weak var reasonsForReadingText: UITextView!
    @IBOutlet weak var notesText: UITextView!
    
    var dateString: String = ""
    var titleName: String = ""
    var reasonString: String = ""
    var notesString: String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateAddedLabel.text? = dateString
        reasonsForReadingText.text? = reasonString
        notesText.text? = notesString

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var markCompleteButtonPressed: UIButton!

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
