//
//  EventViewControllerDelegate+DataSource.swift
//  CountDown-App
//
//  Created by Amin  Bagheri  on 2022-06-15.
//

import Foundation
import UIKit

extension EventViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return unfinishedEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.identifier, for: indexPath) as! EventTableViewCell
        
        cell.setUp(event: unfinishedEvents[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let controller = storyboard?.instantiateViewController(withIdentifier: "CountdownViewController") as! CountdownViewController
        controller.navigationItem.largeTitleDisplayMode = .never
        controller.event = unfinishedEvents[indexPath.row]
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        
//        let tempMovedObject = events[sourceIndexPath.item]
//        
//        
//        events.remove(at: sourceIndexPath.item)
//        events.insert(tempMovedObject, at: destinationIndexPath.item)
//        
//        for event in events {
//            CoreDataManager.shared.deleteEvents(event)
//            
//            let event = CoreDataManager.shared.recreateEvent(event: event)
//            
//            events.append(event)
//        }
//        
//        CoreDataManager.shared.save()
//    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataManager.shared.deleteEvents(unfinishedEvents[indexPath.row])
            
            unfinishedEvents.remove(at: indexPath.row)
            tableView.reloadData()
            
        }
    }
    
}
