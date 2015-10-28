//
//  Persons+CoreDataProperties.swift
//  SwiftyContact
//
//  Created by Mike Henry on 10/28/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Persons {

    @NSManaged var dateEntered: NSDate?
    @NSManaged var dateUpdated: NSDate?
    @NSManaged var personCity: String?
    @NSManaged var personEmail: String?
    @NSManaged var personFirstName: String?
    @NSManaged var personLastName: String?
    @NSManaged var personPhone: String?
    @NSManaged var personState: String?
    @NSManaged var personStreet: String?
    @NSManaged var personZip: String?
    @NSManaged var userID: String?
    @NSManaged var personRating: NSNumber?

}
