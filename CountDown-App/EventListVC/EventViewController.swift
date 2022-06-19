//
//  EventViewController.swift
//  CountDown-App
//
//  Created by Amin  Bagheri  on 2022-06-15.
//

import UIKit
import UserNotifications

class EventViewController: UIViewController {

    
//    819936000
    
    var events: [Event] = []
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { permissionGranted, error in
            
        }
        
        events = CoreDataManager.shared.fetchEvents()
        
        
        
        tableView.register(UINib.init(nibName: EventTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: EventTableViewCell.identifier)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(events)
        events = CoreDataManager.shared.fetchEvents()
    }
    
    @IBAction func unwindToEventsVC(_ unwindSegue: UIStoryboardSegue) {
        let svc = unwindSegue.source as! AddCountdownViewController
        
        guard let image = svc.image, let name = svc.name, let date = svc.date else { return }
        let event = CoreDataManager.shared.createEvent(image: image, name: name, endDate: date)
        events.append(event)
        tableView.reloadData()
        
        let content = UNMutableNotificationContent()
        content.title = "Starting soon. "
        // Use data from the view controller which initiated the unwind segue
    }
    
    var editButtonPressed: Bool = false
    @IBOutlet var editButton: UIBarButtonItem!
    @IBAction func editButtonPressed(_ sender: Any) {
        editButtonPressed.toggle()
        if editButtonPressed {
            editButton.title = "Done"
        } else {
            editButton.title = "Edit"
        }
        self.tableView.isEditing = !self.tableView.isEditing
        
        
    }
    
    func deleteEventFromStorage(_ event: Event) {
        deleteEvent(with: event.id!)
        CoreDataManager.shared.deleteEvents(event)
        // Update the list
        
    }
    
    private func indexForEvent(id: UUID, in list: [Event]) -> IndexPath {
        let row = Int(list.firstIndex(where: { $0.id == id }) ?? 0)
        return IndexPath(row: row, section: 0)
    }
    
    func deleteEvent(with id: UUID) {
        let indexPath = indexForEvent(id: id, in: events)
        events.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        
    }
}



