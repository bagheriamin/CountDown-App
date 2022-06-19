//
//  Model.swift
//  CountDown-App
//
//  Created by Amin  Bagheri  on 2022-06-18.
//

import Foundation

//
//  CoreDataManager.swift
//  MyNotes
//
//  Created by Amin  Bagheri  on 2022-06-18.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager(modelName: "CountDown-App")
    
    var persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { (description, error) in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            completion?()

        }
    }
    
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print("An error has occured", error.localizedDescription)
            }
        }
    }
}

// Helper Functions
extension CoreDataManager {
    func imageAsData(image: UIImage) -> Data? {
        guard let data = image.pngData() else { return nil }
        return data
    }
    
    func dataAsImage(data: Data) -> UIImage? {
        guard let image = UIImage(data: data) else { return nil }
        return image
    }
    
    func createEvent(image: UIImage, name: String, endDate: Date) -> Event {
        
        let event = Event(context: viewContext)
        event.image = imageAsData(image: image)
        event.name = name
        event.id = UUID()
        event.endDate = endDate
        event.startDate = Date()
        save()
        return event
        
    }
    
    func fetchEvents(filter: String? = nil) -> [Event] {
        let request: NSFetchRequest<Event> = Event.fetchRequest()
        
        return (try? viewContext.fetch(request)) ?? []
    }
    
    func deleteEvents(_ event: Event) {
        viewContext.delete(event)
        save()
    }
    

}
