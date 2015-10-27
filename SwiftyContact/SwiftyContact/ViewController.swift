//
//  ViewController.swift
//  SwiftyContact
//
//  Created by Mike Henry on 10/27/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedObjectContext :NSManagedObjectContext! = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var personsArray = [Persons]()
    
    
    //MARK: Table View Methods
    
    
    //MARK: Core Data Methods
    
    func tempAddRecords() {
        let entityDescription :NSEntityDescription = NSEntityDescription.entityForName("Persons", inManagedObjectContext: managedObjectContext)!
        let currentPerson :Persons! = Persons(entity: entityDescription, insertIntoManagedObjectContext: managedObjectContext)
        currentPerson.personFirstName = "John"
        currentPerson.personLastName = "Smith"
        currentPerson.personStreet = "123 Main Street"
        currentPerson.personCity = "Washington"
        currentPerson.personState = "DC"
        currentPerson.personZip = "22202"
        currentPerson.personPhone = "843-234-6532"
        currentPerson.personEmail = "email@gmail.com"
        appDelegate.saveContext()
    }
    
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
    
    
    //MARK: Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
//        tempAddRecords()
        personsArray = fetchPersons()!
        let firstPerson = personsArray.first
        print("Number of Persons:\(personsArray.count) First Record:\(firstPerson?.personFirstName)")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

