//
//  EventViewController.swift
//  CountDown-App
//
//  Created by Amin  Bagheri  on 2022-06-15.
//

import UIKit
import UserNotifications

class EventViewController: UIViewController {

    var timer = Timer()
//    819936000
    
    var events: [Event] = []
    var unfinishedEvents: [Event] = []
    
    
    @IBOutlet var tableView: UITableView!
    
    let center = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        unfinishedEvents = events
        
        
        center.requestAuthorization(options: [.alert, .sound]) { permissionGranted, error in
            
        }
        
        events = CoreDataManager.shared.fetchEvents()
        
        
        
        tableView.register(UINib.init(nibName: EventTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: EventTableViewCell.identifier)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    func checkForFinishedTasks() {
        
            for event in events {
                print("The event you're looking for: ", event)
                print("The end date of that event: ", event.endDate)
                guard event.endDate != nil else {
                    CoreDataManager.shared.deleteEvents(event)
                    return
                }
                if Date.now > event.endDate! {
                    event.isFinished = true
                    CoreDataManager.shared.save()
                    tableView.reloadData()
                    if unfinishedEvents.contains(event) {
                        let index = unfinishedEvents.firstIndex(of: event)
                        unfinishedEvents.remove(at: index!)
                        CoreDataManager.shared.save()
                        tableView.reloadData()
                    }
                    
                    
                } else {
                    if !unfinishedEvents.contains(event) {
                        print("Added \(event.name!) to unfinished events")
                        unfinishedEvents.append(event)
                        tableView.reloadData()
                    }
                    
                }
            }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] _ in
            self?.checkForFinishedTasks()
        })
      
        events = CoreDataManager.shared.fetchEvents()
    }
    
    @IBAction func unwindToEventsVC(_ unwindSegue: UIStoryboardSegue) {
        let svc = unwindSegue.source as! AddCountdownViewController
        
        guard let image = svc.image, let name = svc.name, let date = svc.date else { return }
        let event = CoreDataManager.shared.createEvent(image: image, name: name, endDate: date)
        events.append(event)
        tableView.reloadData()
        
        //ask for authorization
        
        // create content
        let content = UNMutableNotificationContent()
        content.title = name
        content.body = "Starting soon..."
        
        // create notification trigger
        let notificationDate = date.withRemovedMinutes(minutes: 10)
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: notificationDate)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        // create notification request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        // register request with notification center
        center.add(request) { error in
            if let error = error {
                print("Error: ", error.localizedDescription)
            } else {
                print("notification set up successfully for \(event)")
            }
        }
        
        
    }
    
    var editButtonPressed: Bool = false {
        didSet {
            print("Table View is editing: ",editButtonPressed)            
        }
    }
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
}



