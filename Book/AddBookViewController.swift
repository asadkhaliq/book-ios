//
//  AddBookViewController.swift
//  Book
//
//  Created by Asad Khaliq on 11/26/15.
//  Copyright © 2015 Asad Khaliq. All rights reserved.
//

import UIKit
import CoreData

class AddBookViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var pagesTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    
    private var managedObjectContext: NSManagedObjectContext? = AppDelegate.managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
        authorTextField.delegate = self
        pagesTextField.delegate = self
        notesTextField.delegate = self
        
        
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
    
    @IBAction func addBookManually(sender: UIButton) {
        Book.addBook(titleTextField.text!, withCover: "http://t1.gstatic.com/images?q=tbn:ANd9GcTI_ooZzjy49uuu0Shtt6mOlIxLIEZ4Qd5DRJgS7z9asXEoHP5J", withISBN: "No ISBN Found", numPages: Int(pagesTextField.text!)!, withPriority: String(prioritySegmentedControl.selectedSegmentIndex), because: notesTextField.text!, withCategory: "Test", writtenBy: authorTextField.text!, withContext: managedObjectContext!)
    
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
