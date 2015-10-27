//
//  DetailViewController.swift
//  SwiftyContact
//
//  Created by Mike Henry on 10/27/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedObjectContext :NSManagedObjectContext! = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var selectedPerson :Persons?
    @IBOutlet weak var  firstNameTextField  :UITextField!
    @IBOutlet weak var  lastNameTextField   :UITextField!
    @IBOutlet weak var  streetTextField     :UITextField!
    @IBOutlet weak var  cityTextField       :UITextField!
    @IBOutlet weak var  stateTextField      :UITextField!
    @IBOutlet weak var  zipTextField        :UITextField!
    @IBOutlet weak var  phoneTextField      :UITextField!
    @IBOutlet weak var  emailTextField      :UITextField!
    
    
    //MARK: Interactivity Methods

    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
        if selectedPerson == nil {
            print("New")
            let entityDescription :NSEntityDescription! = NSEntityDescription.entityForName("Persons", inManagedObjectContext: managedObjectContext)
            let newPerson :Persons! = Persons(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
            selectedPerson = newPerson
        }
        selectedPerson?.personFirstName = firstNameTextField.text
        selectedPerson?.personLastName = lastNameTextField.text
        selectedPerson?.personStreet = streetTextField.text
        selectedPerson?.personCity = cityTextField.text
        selectedPerson?.personState = stateTextField.text
        selectedPerson?.personZip = zipTextField.text
        selectedPerson?.personPhone = phoneTextField.text
        selectedPerson?.personEmail = emailTextField.text
        saveAndPop()
    }
    
    @IBAction func deleteButtonPressed(sender: UIBarButtonItem) {
        managedObjectContext.deleteObject(selectedPerson!)
        saveAndPop()
    }
    
    func saveAndPop() {
        appDelegate.saveContext()
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    //MARK: Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        if selectedPerson != nil {
            print("Edit")
            firstNameTextField.text = selectedPerson?.personFirstName
            lastNameTextField.text = selectedPerson?.personLastName
            streetTextField.text = selectedPerson?.personStreet
            cityTextField.text = selectedPerson?.personCity
            stateTextField.text = selectedPerson?.personState
            zipTextField.text = selectedPerson?.personZip
            phoneTextField.text = selectedPerson?.personPhone
            emailTextField.text = selectedPerson?.personEmail
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    



}
