//
//  ViewController.swift
//  SwiftyContact
//
//  Created by Mike Henry on 10/27/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit
import CoreData
import Contacts
import ContactsUI

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CNContactPickerDelegate, CNContactViewControllerDelegate {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedObjectContext :NSManagedObjectContext! = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var personsArray = [Persons]()
    var sectionsArray = [String]()
    var contactStore = CNContactStore()
    @IBOutlet weak var personsTableView :UITableView!
    
    
    
    func createSectionArray() -> [String] {
        var categorySet = Set<String>()
        for contact in personsArray {
            let lastnameFirstChar = String(contact.personLastName!.characters.first!)
            categorySet.insert(lastnameFirstChar)
        }
        return Array(categorySet)
    }
    
    func filterLastNameByCategory(category: String) -> [Persons] {
        let filteredPersons = personsArray.filter({
            String($0.personLastName!.characters.first!) == category
        })
        return filteredPersons
    }
    
    
    //MARK: Interactivity Methods
    
    @IBAction func showContactList(sender: UIBarButtonItem) {
        print("Contacts button pressed")
        let contactListVC = CNContactPickerViewController()
        contactListVC.delegate = self
        presentViewController(contactListVC, animated: true, completion: nil)
    }
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {
        let entityDescription :NSEntityDescription = NSEntityDescription.entityForName("Persons", inManagedObjectContext: managedObjectContext)!
        let currentPerson :Persons! = Persons(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
        
        print("First Name:\(contact.givenName) Last Name:\(contact.familyName)")
        currentPerson.personFirstName = contact.givenName
        currentPerson.personLastName = contact.familyName
        
        for phone in contact.phoneNumbers as [CNLabeledValue] {
            print("Phone: " + (phone.value as! CNPhoneNumber).stringValue)
            currentPerson.personPhone = (phone.value as! CNPhoneNumber).stringValue
        }
        
        for email in contact.emailAddresses as [CNLabeledValue] {
            print("Email: " + (email.value as! String))
            currentPerson.personEmail = email.value as? String
        }
        
        for street in contact.postalAddresses as [CNLabeledValue] {
            print("Street: " + (street.value as! CNPostalAddress).street)
            currentPerson.personStreet = (street.value as! CNPostalAddress).street
        }
        
        for city in contact.postalAddresses as [CNLabeledValue] {
            print("City: " + (city.value as! CNPostalAddress).city)
            currentPerson.personCity = (city.value as! CNPostalAddress).city
        }
        
        for state in contact.postalAddresses as [CNLabeledValue] {
            print("State: " + (state.value as! CNPostalAddress).state)
            currentPerson.personState = (state.value as! CNPostalAddress).state
        }
        
        for zip in contact.postalAddresses as [CNLabeledValue] {
            print("Zip: " + (zip.value as! CNPostalAddress).postalCode)
            currentPerson.personZip = (zip.value as! CNPostalAddress).postalCode
        }
        appDelegate.saveContext()
    }
    
    
    
    //MARK: Table View Methods
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        print("Sections: \(sectionsArray.count)")
        return sectionsArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterLastNameByCategory(sectionsArray[section]).count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let lastName = filterLastNameByCategory(sectionsArray[indexPath.section])[indexPath.row].personLastName
        let firstName = filterLastNameByCategory(sectionsArray[indexPath.section])[indexPath.row].personFirstName
        let rating = filterLastNameByCategory(sectionsArray[indexPath.section])[indexPath.row].personRating
        cell.textLabel!.text = "\(firstName!) \(lastName!)"
        cell.detailTextLabel!.text = "Rating: \(rating!)"
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsArray[section]
    }
    
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Count: \(filterLastNameByCategory(sectionsArray[section]).count)"
    }
    
    // swipe to delete
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            print("Row to delete:\(indexPath.row)")
            let personToDelete = personsArray[indexPath.row]
            managedObjectContext .deleteObject(personToDelete)
            appDelegate.saveContext()
            personsArray = fetchPersons()!
            personsTableView.reloadData()
        }
    }
    
    
    //MARK: - Contact Methods
    
    func requestAccessToContactType(type: CNEntityType) {
        contactStore.requestAccessForEntityType(type) { (accessGranted: Bool, error: NSError?) -> Void in
            if accessGranted {
                print("Granted")
            } else {
                print("Not granted")
            }
        }
    }
    
    func checkContactAuthorizationStatus(type: CNEntityType) {
        let status = CNContactStore.authorizationStatusForEntityType(type)
        switch status {
        case .NotDetermined:
            print("Not determined")
            requestAccessToContactType(type)
        case .Authorized:
            print("Authorized")
        case .Restricted, .Denied:
            print("Restricted/Denied")
        }
    }
    
    
    //MARK: Core Data Methods
    
//    func tempAddRecords() {
//        let entityDescription :NSEntityDescription = NSEntityDescription.entityForName("Persons", inManagedObjectContext: managedObjectContext)!
//        let currentPerson :Persons! = Persons(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
//        currentPerson.personFirstName = "John"
//        currentPerson.personLastName = "Smith"
//        currentPerson.personStreet = "123 Main Street"
//        currentPerson.personCity = "Washington"
//        currentPerson.personState = "DC"
//        currentPerson.personZip = "22202"
//        currentPerson.personPhone = "843-234-6532"
//        currentPerson.personEmail = "email@gmail.com"
//        appDelegate.saveContext()
//    }
    
    func fetchPersons() -> [Persons]? {
        let fetchRequest :NSFetchRequest = NSFetchRequest(entityName: "Persons")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "personFirstName", ascending: true)]
        do {
            let tempArray = try managedObjectContext.executeFetchRequest(fetchRequest) as! [Persons]
            return tempArray
        } catch {
            return nil
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destController = segue.destinationViewController as! DetailViewController
        if segue.identifier == "segueEdit" {
            let indexPath = personsTableView.indexPathForSelectedRow!
            let selectedPerson = personsArray[indexPath.row]
            destController.selectedPerson = selectedPerson
            personsTableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
        else if segue.identifier == "segueAdd" {
            destController.selectedPerson = nil
        }
    }
    
    
    //MARK: Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
//        tempAddRecords()
        personsArray = fetchPersons()!
//        let firstPerson = personsArray.first
//        print("Number of Persons:\(personsArray.count) First Record:\(firstPerson?.personFirstName)")
        checkContactAuthorizationStatus(CNEntityType.Contacts)
        sectionsArray = createSectionArray()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        personsArray = fetchPersons()!
        personsTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

