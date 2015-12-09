//
//  SettingsEditProfileViewController.swift
//  Book
//
//  Created by Asad Khaliq on 12/3/15.
//  Copyright © 2015 Asad Khaliq. All rights reserved.
//

import UIKit

class SettingsEditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    private var userDefaults = NSUserDefaults.standardUserDefaults()


    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    
    let imagePicker = UIImagePickerController()
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        profileImage.layer.masksToBounds = false
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        usernameField.delegate = self
        firstNameField.delegate = self
        lastNameField.delegate = self


    }
    
    override func viewDidAppear(animated: Bool) {
        if (userDefaults.stringForKey("firstname") != nil) {
            firstNameField.text? = userDefaults.stringForKey("firstname")!
        }
        if (userDefaults.stringForKey("lastname") != nil) {
            lastNameField.text? = userDefaults.stringForKey("lastname")!
        }
        if (userDefaults.objectForKey("profileimage") != nil) {
            let imageData = userDefaults.objectForKey("profileimage") as! NSData
            let image : UIImage = UIImage(data: imageData)!
            profileImage.image = image
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func changeProfileImageButton(sender: UIButton) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func takeProfileImageButton(sender: UIButton) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo: [String: AnyObject]) {
        if let pickedImage = didFinishPickingMediaWithInfo[UIImagePickerControllerEditedImage] as? UIImage {
            profileImage.contentMode = .ScaleAspectFit
            profileImage.image = pickedImage
            let dataImage : NSData = UIImagePNGRepresentation(pickedImage)!
            userDefaults.setObject(dataImage, forKey: "profileimage")

        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func doneButtonClicked(sender: AnyObject) {
        userDefaults.setObject(usernameField.text, forKey: "username")
        userDefaults.setObject(firstNameField.text, forKey: "firstname")
        userDefaults.setObject(lastNameField.text, forKey: "lastname")
        self.navigationController?.popViewControllerAnimated(true)
        
        

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
