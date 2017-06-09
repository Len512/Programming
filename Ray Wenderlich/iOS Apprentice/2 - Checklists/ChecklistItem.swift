//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Len512 on 07/06/2017.
//  Copyright © 2017 Len512. All rights reserved.
//

import Foundation
import UserNotifications

class ChecklistItem: NSObject, NSCoding {
    var text = ""
    var checked = false
    // notification identifiers
    var dueDate = Date()
    var shouldRemind = false
    var itemID: Int
    
    // MARK: - Initialisation methods
    override init(){
        itemID = DataModel.nextChecklistItemID()
        super.init()
    }
    // Implementation of NSCoding protocol methods
    required init?(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObject(forKey: "Text") as! String
        checked = aDecoder.decodeBool(forKey: "Checked")
        dueDate = aDecoder.decodeObject(forKey: "DueDate") as! Date
        shouldRemind = aDecoder.decodeBool(forKey: "ShouldRemind")
        itemID = aDecoder.decodeInteger(forKey: "ItemID")
        super.init()
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "Text")
        aCoder.encode(checked, forKey: "Checked")
        aCoder.encode(dueDate, forKey: "DueDate")
        aCoder.encode(shouldRemind, forKey: "ShouldRemind")
        aCoder.encode(itemID, forKey: "ItemID")
    }
    func toggleChecked() {
        checked = !checked
    }
    
    // MARK: - Notifications methods
    func scheduleNotification() {
        removeNotification()
        if shouldRemind && dueDate > Date(){
            // Put the item's text into the notification message
            let content = UNMutableNotificationContent()
            content.title = "Reminder:"
            content.body = text
            content.sound = UNNotificationSound.default()
            
            // Extract month, day, hour, minute from dueDate
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents([.month, .day, .hour, .minute], from: dueDate)
            
            // Show notification at specified date
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            
            // Convert itemID to string and use this to identify the notification
            let request = UNNotificationRequest(identifier: "\(itemID)", content: content, trigger: trigger)
            
            // add the new notification to the UNUserNotificationCenter
            let centre = UNUserNotificationCenter.current()
            centre.add(request)
            
            print("Scheduled notification \(request) for itemID \(itemID)")
        }
    }
    func removeNotification() {
        let centre = UNUserNotificationCenter.current()
        centre.removePendingNotificationRequests(withIdentifiers: ["\(itemID)"])
    }
    // Notify object it is about to be deleted
    deinit {
        removeNotification()
    }
}
