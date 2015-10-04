//
//  EventViewController.swift
//  ClubHub
//
//  Created by Kenny Law on 10/3/15.
//  Copyright © 2015 Kenny Law. All rights reserved.
//

import UIKit

class EventViewController: UIViewController, UITextFieldDelegate,
UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var clubNameTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    
    var event : OrgEvent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // handle's text field's user input through delegate callbacks
        nameTextField.delegate = self
        
        if let event = event {
            navigationItem.title = event.name
            nameTextField.text = event.name
            photoImageView.image = event.photo
            clubNameTextField.text = event.orgName
            dateTextField.text = event.date
            locationTextField.text = event.location
            descriptionTextField.text = event.info
            categoryTextField.text = event.category
        }
        
        // enable save button only if the text field has a valid event name
        checkValidEventName()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // dismiss picker if user canceled
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // info dictionary contains multiple representations of the iamge and this uses the original
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // set photoImageView to display the selected image
        photoImageView.image = selectedImage
        
        // dismiss the picker
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Navigation
    @IBAction func cancel(sender: UIBarButtonItem) {
        // depending on style of presentation (modal or push presentation), view needs to be dismissed in 2 diff ways
        let isPresentingInAddEventMode = presentingViewController is UINavigationController
        if isPresentingInAddEventMode {
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    // configure view controller before it's presented
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let name = nameTextField.text ?? ""
            let photo = photoImageView.image
            let orgName = clubNameTextField.text ?? ""
            let date = dateTextField.text ?? ""
            let location = locationTextField.text ?? ""
            let info = descriptionTextField.text ?? ""
            let category = categoryTextField.text ?? ""
            
            event = OrgEvent(name: name, photo: photo, orgName: orgName, date: date, location: location, info: info, category: category)
        }
    }
    
    // MARK: Actions
    //    @IBAction func setDefaultLabelText(sender: UIButton) {
    //        eventNameLabel.text = "Default Text"
    //    }
    
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        // hides keyboard
        nameTextField.resignFirstResponder()
        
        // view controller to pick media from photo library
        let imagePickerController = UIImagePickerController()
        
        // only photos to be picked, not taken
        imagePickerController.sourceType = .PhotoLibrary
        
        // view controller is notified when user picks an image
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // hide keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidEventName()
        navigationItem.title = textField.text
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        saveButton.enabled = false
    }
    
    func checkValidEventName() {
        // disable save field if text field is empty
        let text = nameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
}

