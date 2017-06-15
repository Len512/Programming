//
//  LocationDetailsViewController.swift
//  MyLocations
//
//  Created by Len512 on 13/06/2017.
//  Copyright © 2017 Len512. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import CoreData

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter
}()
// The Tag/Edit Location Screen
class LocationDetailsViewController: UITableViewController {

    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addPhotoLabel: UILabel!
    
    var coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var placemark: CLPlacemark?
    
    var categoryName = "No Category"
    
    var managedObjectContext: NSManagedObjectContext!
    
    var date = Date()
    
    var image: UIImage?
    
    var observer: Any!
    
    // property observer to get the values from Location object into this view controller
    var locationToEdit: Location? {
        // this block will be executed whenever we put a new value into the variable
        didSet {
            if let location = locationToEdit {
                descriptionText = location.locationDescription
                categoryName = location.category
                date = location.date
                coordinate = CLLocationCoordinate2DMake(location.latitude, location.longitude)
                placemark = location.placemark
            }
        }
    }
    var descriptionText = ""
    
    // MARK: - Action Methods
    @IBAction func done() {
        let hudView = HudView.hud(inView: navigationController!.view, animated: true)
        
        // Create a location managed object 
        let location: Location
        
        if let temp = locationToEdit {
            hudView.text = "Updated"
            location = temp
        } else {
            hudView.text = "Tagged"
            location = Location(context: managedObjectContext)
            location.photoID = nil
        }
        
        location.locationDescription = descriptionTextView.text
        location.category = categoryName
        location.latitude = coordinate.latitude
        location.longitude = coordinate.longitude
        location.date = date
        location.placemark = placemark
        
        if let image = image {
            // if we add a photo to a location that does not yet have an ID
            if !location.hasPhoto {
                location.photoID = Location.nextPhotoID() as NSNumber
            }
            // Convert to JPEG and return the blob data
            if let data = UIImageJPEGRepresentation(image, 0.5) {
                do {
                    try data.write(to: location.photoURL, options: .atomic)
                } catch {
                    print("Error writing file: \(error)")
                }
            }
        }
        
        // Close view after hud is finished showing
        do {
            try managedObjectContext.save()
            
            afterDelay(1) {
                self.dismiss(animated: true, completion: nil)
            }
        } catch {
            fatalCoreDataError(error)
        }
        
    }
    
    @IBAction func cancel() {
        dismiss(animated: true, completion: nil)
    }
    // To make an unwind segue, we need to define an action method that takes a segue as a parameter
    @IBAction func categoryPickerDidPickCategory(_ segue: UIStoryboardSegue) {
        let controller = segue.source as! CategoryPickerViewController
        categoryName = controller.selectedCategoryName
        categoryLabel.text = categoryName
    }
    
    // MARK: - Display on screen 
    override func viewDidLoad() {
        super.viewDidLoad()
        if let location = locationToEdit {
            title = "Edit Location"
            if location.hasPhoto {
                if let theImage = location.photoImage {
                    showImage(image: theImage)
                }
            }
        }
        
        descriptionTextView.text = descriptionText
        categoryLabel.text = categoryName
        
        latitudeLabel.text = String(format: "%.8f", coordinate.latitude)
        longitudeLabel.text = String(format: "%.8f", coordinate.longitude)
        
        if let placemark = placemark {
            addressLabel.text = string(from: placemark)
        } else {
            addressLabel.text = "No address found"
        }
        dateLabel.text = format(date: date)
        
        tableView.backgroundColor = UIColor.black
        tableView.separatorColor = UIColor(white: 1.0, alpha: 0.2)
        tableView.indicatorStyle = .white
        
        descriptionTextView.textColor = UIColor.white
        descriptionTextView.backgroundColor = UIColor.black
        
        addPhotoLabel.textColor = UIColor.white
        addPhotoLabel.highlightedTextColor = addPhotoLabel.textColor
        
        addressLabel.textColor = UIColor(white: 1.0, alpha: 0.4)
        addressLabel.highlightedTextColor = addressLabel.textColor
        
        // Make the keyboard disappear when tapping anywhere other than the description row
        // Perform action when user taps inside the view
        let gestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        gestureRecogniser.cancelsTouchesInView = false
        tableView.addGestureRecognizer(gestureRecogniser)
        
        listenForBackgroundNotification()
    }
    
    // MARK: - UITableViewDelegate
    
    // Inform the Table View that the Address label fits multiple lines of text
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (0,0):
            // height of the description cell
            return 88
        case (1, _):
            return imageView.isHidden ? 44 : 280
        case (2, 2):
            // height of the address cell
            addressLabel.frame.size = CGSize(width: view.bounds.size.width - 115, height: 10000)
            addressLabel.sizeToFit()
            addressLabel.frame.origin.x = view.bounds.size.width - addressLabel.frame.size.width - 15
            return addressLabel.frame.size.height + 20
        default:
            // height of the other cells
            return 44
        }
    }
    // Make the Description cell responsive even when the user taps outside the text view
    // Limit taps to the first two sections cells
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 0 || indexPath.section == 1 {
            return indexPath
        } else {
            return nil
        }
    }
    // Handle taps on the rows, respong to first row in first section only
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            descriptionTextView.becomeFirstResponder()
        } else if indexPath.section == 1 && indexPath.row == 0 {
            tableView.deselectRow(at: indexPath, animated: true)
            pickPhoto()
        }
    }
    // Change the colour of the cells and their labels (this method gets called right before a cell becomes visible
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.black
        if let textLabel = cell.textLabel {
            textLabel.textColor = UIColor.white
            textLabel.highlightedTextColor = textLabel.textColor
        }
        if let detailLabel = cell.detailTextLabel {
            detailLabel.textColor = UIColor(white: 1.0, alpha: 0.4)
            detailLabel.highlightedTextColor = detailLabel.textColor
        }
        let selectionView = UIView(frame: CGRect.zero)
        selectionView.backgroundColor = UIColor(white: 1.0, alpha: 0.2)
        cell.selectedBackgroundView = selectionView
        if indexPath.row == 2 {
            let addressLabel = cell.viewWithTag(100) as! UILabel
            addressLabel.textColor = UIColor.white
            addressLabel.highlightedTextColor = addressLabel.textColor
        }
    }
    // MARK: Segue prepare method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PickCategory" {
            let controller = segue.destination as! CategoryPickerViewController
            controller.selectedCategoryName = categoryName
        }
    }
    
    // MARK: - Helper methods
    func string(from placemark: CLPlacemark) -> String {
        var line = ""
        line.add(text: placemark.subThoroughfare)
        line.add(text: placemark.thoroughfare, seperatedBy: " ")
        line.add(text: placemark.locality, seperatedBy: ", ")
        line.add(text: placemark.administrativeArea, seperatedBy: ", ")
        line.add(text: placemark.postalCode, seperatedBy: " ")
        line.add(text: placemark.country, seperatedBy: ", ")
        return line
    }
    
    func format(date: Date) -> String {
        return dateFormatter.string(from:date)
    }
    func hideKeyboard(_ gestureRecogniser: UIGestureRecognizer) {
        let point = gestureRecogniser.location(in: tableView)
        let indexPath = tableView.indexPathForRow(at: point)
        
        if indexPath != nil && indexPath!.section == 0 && indexPath!.row == 0 {
            return
        }
        descriptionTextView.resignFirstResponder()
    }
    
    func showImage(image: UIImage) {
        imageView.image = image
        imageView.isHidden = false
        imageView.frame = CGRect(x: 10, y: 10, width: 260, height: 260)
        addPhotoLabel.isHidden = true
    }
    
    // MARK: - NotificationCenter Methods
    func listenForBackgroundNotification() {
        observer = NotificationCenter.default.addObserver(forName: Notification.Name.UIApplicationDidEnterBackground, object: nil, queue: OperationQueue.main) {
            // Tell the closure that self will be captured but as a weak reference, 
            // so the closure does not keep the controller alive
            [weak self] _ in
            // if there is an active image picker, dismiss it and hide the keyboard if the text view was active
            if let strongSelf = self {
                if strongSelf.presentedViewController != nil {
                strongSelf.dismiss(animated: false, completion: nil)
                }
            strongSelf.descriptionTextView.resignFirstResponder()
            }
        }
    }
    // Use this to tell the notification center to stop sending background notifications
    // when the Tag/Edit Location screen closes
    deinit {
        print("*** deinit \(self)")
        NotificationCenter.default.removeObserver(observer)
    }
}
// Photo-picking related functionality
extension LocationDetailsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func takePhotoWithCamera() {
        let imagePicker = MyImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.view.tintColor = view.tintColor
        present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        image = info[UIImagePickerControllerEditedImage] as? UIImage
        if let theImage = image {
            showImage(image: theImage)
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func choosePhotoFromLibrary() {
        let imagePicker = MyImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.view.tintColor = view.tintColor
        present(imagePicker, animated: true, completion: nil)
    }
    func pickPhoto() {
        // if UIImagePickerController.isSourceTypeAvailable(.camera) { 
        // the following fakes the availability of a camera for testing purposes
        if true || UIImagePickerController.isSourceTypeAvailable(.camera) {
            showPhotoMenu()
        } else {
            choosePhotoFromLibrary()
        }
    }
    func showPhotoMenu() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        let takePhotoAction = UIAlertAction(title: "Take Photo", style: .default, handler: {
            _ in self.takePhotoWithCamera()
        })
        alertController.addAction(takePhotoAction)
        let chooseFromLibraryAction = UIAlertAction(title: "Choose From Library", style: .default, handler: {
            _ in self.choosePhotoFromLibrary()
        })
        alertController.addAction(chooseFromLibraryAction)
        present(alertController, animated: true, completion: nil)
    }
}
