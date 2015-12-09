//
//  AddContactViewController.swift
//  Book
//
//  Created by Asad Khaliq on 12/9/15.
//  Copyright © 2015 Asad Khaliq. All rights reserved.
//

import UIKit
import Contacts
import EventKit

class AddContactViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var birthdayPicker: UIDatePicker!
    
    var savedEventId : String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameField.text = "Yvonne"
        lastNameField.text = "Jacobson"
        firstNameField.delegate = self
        lastNameField.delegate = self
    }
        override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addBirthdayPressed(sender: AnyObject) {
        let eventStore = EKEventStore()
        
        let startDate = birthdayPicker.date
        let endDate = startDate.dateByAddingTimeInterval(60*60*24)
        
        if (EKEventStore.authorizationStatusForEntityType(.Event) != EKAuthorizationStatus.Authorized) {
            eventStore.requestAccessToEntityType(.Event, completion: {
                granted, error in
                self.createEvent(eventStore, title: "Birthday!", startDate: startDate, endDate: endDate)
            })
        } else {
            createEvent(eventStore, title: "Birthday!", startDate: startDate, endDate: endDate)
        }

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
    
    func createEvent(eventStore: EKEventStore, title: String, startDate: NSDate, endDate: NSDate) {
        let event = EKEvent(eventStore: eventStore)
        
        event.title = title
        event.startDate = startDate
        event.endDate = endDate
        event.calendar = eventStore.defaultCalendarForNewEvents
        do {
            try eventStore.saveEvent(event, span: .ThisEvent)
            savedEventId = event.eventIdentifier
            let alertController = UIAlertController(title: nil, message: "Birthday added!!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Yay", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        } catch {
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
