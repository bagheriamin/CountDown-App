//
//  Event+CoreDataProperties.swift
//  CountDown-App
//
//  Created by Amin  Bagheri  on 2022-06-18.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var endDate: Date?
    @NSManaged public var image: Data?

}

extension Event : Identifiable {

}
