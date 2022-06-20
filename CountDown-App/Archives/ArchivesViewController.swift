//
//  ArchivesViewController.swift
//  CountDown-App
//
//  Created by Amin  Bagheri  on 2022-06-19.
//

import UIKit
import CoreData

class ArchivesViewController: UIViewController {

    
    @IBOutlet var editButton: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    
    var pastEvents: [Event] = []
    var events: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    var editButtonPressed: Bool = false

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

extension ArchivesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        events = CoreDataManager.shared.fetchEvents()
        for event in events {
            if event.isFinished && !pastEvents.contains(event) == true {
                pastEvents.append(event)
            }
        }
        print("PAST EVENTS: ",pastEvents)
        return pastEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = pastEvents[indexPath.row].name
        let date = pastEvents[indexPath.row].endDate
        cell.detailTextLabel?.text =
        date?.getFormattedDate(format: "EEEE, MMM d, yyyy")
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataManager.shared.deleteEvents(pastEvents[indexPath.row])
            
            pastEvents.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}
