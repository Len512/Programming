//
//  Functions.swift
//  MyLocations
//
//  Created by Len512 on 14/06/2017.
//  Copyright © 2017 Len512. All rights reserved.
//

import Foundation
import Dispatch // Import the Grand Central Dispatch framework - GCD to handle asynchronous tasks
import UIKit

func afterDelay(_ seconds: Double, closure: @escaping() -> ()){
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: closure)
}

let applicationDocumentsDirectory: URL = {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}()

let MyManagedObjectContextSaveDidFailNotification = Notification.Name(rawValue: "MyManagedObjectContextSaveDidFailNotification")
func fatalCoreDataError(_ error: Error) {
    print("*** Fatal error: \(error)")
    NotificationCenter.default.post(name: MyManagedObjectContextSaveDidFailNotification, object: nil)
}
