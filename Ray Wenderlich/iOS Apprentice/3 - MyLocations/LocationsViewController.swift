//
//  LocationsViewController.swift
//  MyLocations
//
//  Created by Len512 on 14/06/2017.
//  Copyright © 2017 Len512. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import CoreLocation
// The List of saved locations
class LocationsViewController: UITableViewController {
    
    var managedObjectContext: NSManagedObjectContext!
    
    // Use an NSFetchedResultsController to read the results as a delegate for this view controller
    // Through this delegate the vc is informed that objects have been changed, added or deleted and 
    // in response it should update the table
    lazy var fetchedResultsController: NSFetchedResultsController<Location> = {
        // Object describing which objects to fetch from the data store
        let fetchRequest = NSFetchRequest<Location>()
        let entity = Location.entity()
        fetchRequest.entity = entity
        // sort on the date attribute, in ascending order
        let sortDescriptor1 = NSSortDescriptor(key: "category", ascending: true)
        let sortDescriptor2 = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor1, sortDescriptor2]
        fetchRequest.fetchBatchSize = 20
        
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: self.managedObjectContext,
            sectionNameKeyPath: "category", // group results by category
            cacheName: "Locations")
        
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationCell", for: indexPath) as! LocationCell
        let location = fetchedResultsController.object(at: indexPath)
        cell.configure(for: location)
        return cell
    }
    // Allow the user to delete tagged locations
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let location = fetchedResultsController.object(at: indexPath)
            location.removePhotoFile()
            managedObjectContext.delete(location)
            do {
                try managedObjectContext.save()
            } catch {
                fatalCoreDataError(error)
            }
        }
    }
    // Allow grouping by category
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections!.count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.name.uppercased()
    }
    // MARK: - UITableViewDelegate method
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let labelRect = CGRect(x: 15, y: tableView.sectionHeaderHeight - 14, width: 300, height: 14)
        let label = UILabel(frame: labelRect)
        label.font = UIFont.boldSystemFont(ofSize: 11)
        label.text = tableView.dataSource!.tableView!(tableView, titleForHeaderInSection: section)
        label.textColor = UIColor(white: 1.0, alpha: 0.4)
        label.backgroundColor = UIColor.clear
        
        let separatorRect = CGRect(x: 15, y: tableView.sectionHeaderHeight - 0.5, width: tableView.bounds.size.width - 15, height: 0.5)
        let separator = UIView(frame: separatorRect)
        separator.backgroundColor = tableView.separatorColor
        
        let viewRect = CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.sectionHeaderHeight)
        let view = UIView(frame: viewRect)
        view.backgroundColor = UIColor(white: 0, alpha: 0.85)
        view.addSubview(label)
        view.addSubview(separator)
        return view
    }
    
    // MARK: - Fetch locations
    override func viewDidLoad() {
        super.viewDidLoad()
        performFetch()
        // Access the built-in Edit button to allow going into edit mode
        navigationItem.rightBarButtonItem = editButtonItem
        tableView.backgroundColor = UIColor.black
        tableView.separatorColor = UIColor(white: 1.0, alpha: 0.2)
        tableView.indicatorStyle = .white
        tableView.sectionHeaderHeight = 28
    }
    func performFetch() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalCoreDataError(error)
        }
    }
    // when this view controller is destroyed, set th delegate to nil, so we don't get 
    // notifications that were still pending
    deinit {
        fetchedResultsController.delegate = nil
    }
    
    // MARK: - Segue method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditLocation" {
            let navigationConroller = segue.destination as! UINavigationController
            let controller = navigationConroller.topViewController as! LocationDetailsViewController
            controller.managedObjectContext = managedObjectContext
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell){
                let location = fetchedResultsController.object(at: indexPath)
                controller.locationToEdit = location
            }
        }
    }
    
}
// Implementation of delegate methods for the NSFetchedResultsController
extension LocationsViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("*** controllerWillChangeContent")
        tableView.beginUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            print("*** NSFetchedResultsChangeInsert (object)")
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            print("*** NSFetchedResultsChangeDelete (object)")
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            print("*** NSFetchedResultsChangeUpdate (object)")
            if let cell = tableView.cellForRow(at: indexPath!) as? LocationCell {
                let location = controller.object(at: indexPath!) as! Location
                cell.configure(for: location)
            }
        case .move:
            print("*** NSFetchedResultsChangeMove (object)")
            tableView.deleteRows(at: [indexPath!], with: .fade)
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        }
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            print("*** NSFetchedResultsChangeInsert (section)")
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            print("*** NSFetchedResultsChabgeDelete (section)")
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .update:
            print("*** NSFetchedResultsChangeUpdate (section)")
        case .move:
            print("*** NSFetchedResultsChangeMove (section)")
        }
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        print("*** controllerDidChangeContent")
        tableView.endUpdates()
    }
}
