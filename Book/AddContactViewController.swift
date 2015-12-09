//
//  AddContactViewController.swift
//  Book
//
//  Created by Asad Khaliq on 12/9/15.
//  Copyright © 2015 Asad Khaliq. All rights reserved.
//

import UIKit
import Contacts

class AddContactViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var birthdayPicker: UIDatePicker!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameField.text = "Yvonne"
        lastNameField.text = "Jacobson"
        firstNameField.delegate = self
        lastNameField.delegate = self
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
    
    @IBAction func addContactPressed(sender: AnyObject) {
        
        let newContact = CNMutableContact()
        
        newContact.givenName = firstNameField.text!
        newContact.familyName = lastNameField.text!
        
        newContact.imageData = UIImagePNGRepresentation(profilePicture.image!)!
        
        let birthdayComponents = NSCalendar.currentCalendar().components([NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day], fromDate: birthdayPicker.date)
        newContact.birthday = birthdayComponents
        
        do {
            let saveRequest = CNSaveRequest()
            saveRequest.addContact(newContact, toContainerWithIdentifier: nil)
            try AppDelegate.getAppDelegate().contactStore.executeSaveRequest(saveRequest)
            navigationController?.popViewControllerAnimated(true)
            let alertController = UIAlertController(title: nil, message: "Contact added!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Awesome", style: UIAlertActionStyle.Default, handler: nil))
            UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alertController, animated: true, completion: nil)

        }
        catch {
            let alertController = UIAlertController(title: nil, message: "Unable to add!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Whoops", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }
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
