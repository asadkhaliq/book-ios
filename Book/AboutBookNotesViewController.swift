//
//  AboutBookNotesViewController.swift
//  Book
//
//  Created by Asad Khaliq on 12/8/15.
//  Copyright © 2015 Asad Khaliq. All rights reserved.
//

import UIKit
import CoreData

class AboutBookNotesViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var dateAddedLabel: UILabel!
    @IBOutlet weak var markCompleteButton: UIButton!
    @IBOutlet weak var reasonsForReadingText: UITextView!
    
    var BookObject : Book?
    
    var dateString: String = ""
    var titleName: String = ""
    var reasonString: String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateAddedLabel.text? = dateString
        reasonsForReadingText.text? = reasonString
        reasonsForReadingText.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(animated: Bool) {
        BookObject!.reason = reasonsForReadingText.text
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
