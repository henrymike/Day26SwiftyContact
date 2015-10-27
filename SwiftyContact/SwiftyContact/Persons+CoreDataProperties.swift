//
//  Persons+CoreDataProperties.swift
//  SwiftyContact
//
//  Created by Mike Henry on 10/27/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Persons {

    @NSManaged var personFirstName: String?
    @NSManaged var personLastName: String?
    @NSManaged var personStreet: String?
    @NSManaged var personCity: String?
    @NSManaged var personState: String?
    @NSManaged var personZip: String?
    @NSManaged var personPhone: String?
    @NSManaged var personEmail: String?
    @NSManaged var dateEntered: NSDate?
    @NSManaged var dateUpdated: NSDate?
    @NSManaged var userID: String?

}
