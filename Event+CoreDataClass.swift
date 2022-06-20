//
//  Event+CoreDataClass.swift
//  CountDown-App
//
//  Created by Amin  Bagheri  on 2022-06-19.
//
//

import Foundation
import CoreData
import UIKit

@objc(Event)
public class Event: NSManagedObject {
    func dataAsImage(data: Data) -> UIImage? {
        guard let image = UIImage(data: data) else { return nil }
        return image
    }
}
