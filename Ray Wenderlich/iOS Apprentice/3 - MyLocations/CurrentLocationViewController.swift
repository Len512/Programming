//
//  CurrentLocationViewController.swift
//  MyLocations
//
//  Created by Len512 on 09/06/2017.
//  Copyright © 2017 Len512. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData
import QuartzCore // Framework that provides Core Animation
import AudioToolbox

// The main Screen
class CurrentLocationViewController: UIViewController, CLLocationManagerDelegate, CAAnimationDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tagButton: UIButton!
    @IBOutlet weak var getButton: UIButton!
    @IBOutlet weak var latitudeTextLabel: UILabel!
    @IBOutlet weak var longitudeTextLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    // Show Target-logo while the Get Location hasn't been tapped
    var logoVisible = false
    
    lazy var logoButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(named: "Logo"), for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: #selector(getLocation), for: .touchUpInside)
        button.center.x = self.view.bounds.midX
        button.center.y = 220
        return button
    }()
    
    // Store the user's current location
    var location: CLLocation?
    
    // The object that will give us the GPS coordinates
    let locationManager = CLLocationManager()
    
    // Handling errors
    var updatingLocation = false
    var lastLocationError: Error?
    
    // Reverse geocoding variables (mirroring the above variables for the location manager)
    let geocoder = CLGeocoder()
    var placemark: CLPlacemark?
    var performingReverseGeocoding = false
    var lastGeocodingError: Error?
    
    // Add timer to define how long we should search for location
    var timer: Timer?

    // Property for the NSManagedObject context (core data model)
    var managedObjectContext: NSManagedObjectContext!
    
    var soundID: SystemSoundID = 0
    
    // MARK: - Screen view
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateLabels()
        configureGetButton()
        loadSoundEffect("Sound.caf")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Logo View
    // Hide the container view so that the logo button is put on screen
    func showLogoView() {
        if !logoVisible {
            logoVisible = true
            containerView.isHidden = true
            view.addSubview(logoButton)
        }
    }
    func hideLogoView() {
        
        if !logoVisible {
            return
        }
        logoVisible = false
        // The container view is placed outside the screen to the right and moved to the center
        containerView.isHidden = false
        containerView.center.x = view.bounds.size.width * 2
        containerView.center.y = 40 + containerView.bounds.size.height / 2
        
        let centerX = view.bounds.midX
        
        let panelMover = CABasicAnimation(keyPath: "position")
        panelMover.isRemovedOnCompletion = false
        panelMover.fillMode = kCAFillModeForwards
        panelMover.duration = 0.6
        panelMover.fromValue = NSValue(cgPoint: containerView.center)
        panelMover.toValue = NSValue(cgPoint: CGPoint(x: centerX, y: containerView.center.y))
        panelMover.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        panelMover.delegate = self
        containerView.layer.add(panelMover, forKey: "panelMover")
        
        // The logo image view slides out of the screen
        let logoMover = CABasicAnimation(keyPath: "position")
        logoMover.isRemovedOnCompletion = false
        logoMover.fillMode = kCAFillModeForwards
        logoMover.duration = 0.5
        logoMover.fromValue = NSValue(cgPoint: logoButton.center)
        logoMover.toValue = NSValue(cgPoint: CGPoint(x: -centerX, y: logoButton.center.y))
        logoMover.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        logoButton.layer.add(logoMover, forKey: "logoMover")
        // ... while rotating around its center, giving the impression it is rolling away
        let logoRotator = CABasicAnimation(keyPath: "transform.rotation.z")
        logoRotator.isRemovedOnCompletion = false
        logoRotator.fillMode = kCAFillModeForwards
        logoRotator.duration = 0.5
        logoRotator.fromValue = 0.0
        logoRotator.toValue = -2 * Double.pi
        logoRotator.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        logoButton.layer.add(logoRotator, forKey: "logoRotator")
    }
    // Clean up after animations and remove logo button
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        containerView.layer.removeAllAnimations()
        containerView.center.x = view.bounds.size.width / 2
        containerView.center.y = 40 + containerView.bounds.size.height / 2
        logoButton.layer.removeAllAnimations()
        logoButton.removeFromSuperview()
    }
    
    // MARK: - Action methods
    @IBAction func getLocation() {
        // Ask for permission to use the user's location first
        let authStatus = CLLocationManager.authorizationStatus()
        
        if authStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
        if authStatus == .denied || authStatus == .restricted {
            showLocationServicesDeniedAlert()
            return
        }
        if logoVisible {
            hideLogoView()
        }
        if updatingLocation {
            stopLocationManager()
        } else {
            location = nil
            lastLocationError = nil
            placemark = nil
            lastGeocodingError = nil
            startLocationManager()
        }
        updateLabels()
        configureGetButton()
    }
    func showLocationServicesDeniedAlert(){
        let alert = UIAlertController(title: "Location Services Disabled", message: "Please enable location services for this app in Settings.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("didFailWithError \(error)")
        if (error as NSError).code == CLError.locationUnknown.rawValue {
            return
        }
        lastLocationError = error
        stopLocationManager()
        updateLabels()
        configureGetButton()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations.last!
        print("didUpdateLocations \(newLocation)")
        // if this location was given too long ago, it is a cached result, so ignore it
        if newLocation.timestamp.timeIntervalSinceNow < -5 {
            return
        }
        // ignore locations with negative horizontal accuracy
        if newLocation.horizontalAccuracy < 0 {
            return
        }
        
        // Improve for devices that don't have GPS and rely on Wi-Fi to determine the location
        // Calculate distance between the last two readings
        var distance = CLLocationDistance(DBL_MAX)
        if let location = location {
            distance = newLocation.distance(from: location)
        }
        
        // Larger accuracy value means less accurate location result, 
        // so check if the previous reading is greater than the new reading
        // location = nil when it is the first reading
        if location == nil || location!.horizontalAccuracy > newLocation.horizontalAccuracy {
            // Clear out old error states after receiving a valid coordinate
            // and store the new location into the location variable
            lastLocationError = nil
            location = newLocation
            updateLabels()
            // Stop when the new location accuracy is better than the desired one
            if newLocation.horizontalAccuracy <= locationManager.desiredAccuracy {
                print("*** We're done!")
                stopLocationManager()
                configureGetButton()
                // Force a geocoding for final location
                if distance > 0 {
                    performingReverseGeocoding = false
                }
            }
            if !performingReverseGeocoding {
                print("*** Going to geocode")
                performingReverseGeocoding = true
                // CLGeocoder uses a closure instead of a delegate to tell us about the result
                geocoder.reverseGeocodeLocation(newLocation, completionHandler: {
                    placemarks, error in
                    print("*** Found placemarks: \(placemarks), error: \(error)")
                    self.lastLocationError = error
                    if error == nil, let p = placemarks, !p.isEmpty {
                        if self.placemark == nil {
                            print("FIRST TIME!")
                            self.playSoundEffect()
                        }
                        self.placemark = p.last!
                    } else {
                        self.placemark = nil
                    }
                    self.performingReverseGeocoding = false
                    self.updateLabels()
                })
            }
        } else if distance < 1 {
            let timeInterval = newLocation.timestamp.timeIntervalSince(location!.timestamp)
            if timeInterval > 10 {
                print("*** Force done!")
                stopLocationManager()
                updateLabels()
                configureGetButton()
            }
        }
    }
    // MARK: - Sound Effects
    func loadSoundEffect(_ name: String) {
        if let path = Bundle.main.path(forResource: name, ofType: nil) {
            let fileURL = URL(fileURLWithPath: path, isDirectory: false)
            let error = AudioServicesCreateSystemSoundID(fileURL as CFURL, &soundID)
            if error != kAudioServicesNoError {
                print("Error code \(error) loading sound at path: \(path)")
            }
        }
    }
    func unloadSoundEffect() {
        AudioServicesDisposeSystemSoundID(soundID)
        soundID = 0
    }
    func playSoundEffect() {
        AudioServicesPlaySystemSound(soundID)
    }
    
    // MARK: - Helper methods
    func updateLabels() {
        if let location = location {
            latitudeLabel.text = String(format: "%.8f", location.coordinate.latitude)
            longitudeLabel.text = String(format: "%.8f", location.coordinate.longitude)
            tagButton.isHidden = false
            messageLabel.text = ""
            if let placemark = placemark {
                addressLabel.text = string(from: placemark)
            } else if performingReverseGeocoding {
                addressLabel.text = "Searching for Address..."
            } else if lastGeocodingError != nil {
                addressLabel.text = "Error Finding Address"
            } else {
                addressLabel.text = "No Address Found"
            }
            latitudeTextLabel.isHidden = false
            longitudeTextLabel.isHidden = false
        } else {
            latitudeLabel.text = ""
            longitudeLabel.text = ""
            addressLabel.text = ""
            tagButton.isHidden = true
            
            let statusMessage: String
            if let error = lastLocationError as? NSError {
                if error.domain == kCLErrorDomain && error.code == CLError.denied.rawValue {
                    statusMessage = "Location Services Disabled"
                } else {
                    statusMessage = "Error Getting Location"
                }
            } else if !CLLocationManager.locationServicesEnabled() {
                statusMessage = "Location Services Disabled"
            } else if updatingLocation {
                statusMessage = "Searching..."
            } else {
                statusMessage = ""
                showLogoView()
            }
            messageLabel.text = statusMessage
            latitudeTextLabel.isHidden = true
            longitudeTextLabel.isHidden = true
        }
    }
    func startLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            updatingLocation = true
            timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(didTimeOut), userInfo: nil, repeats: false)
        }
    }
    
    func stopLocationManager(){
        if updatingLocation {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            updatingLocation = false
            if let timer = timer {
                timer.invalidate()
            }
        }
    }
    // If the app is updating the location, the button's title is Stop
    func configureGetButton() {
        let spinnerTag = 1000
        
        if updatingLocation {
            getButton.setTitle("Stop", for: .normal)
            // Position spinner below the message label and make it visible
            if view.viewWithTag(spinnerTag) == nil {
                let spinner = UIActivityIndicatorView(activityIndicatorStyle: .white)
                spinner.center = messageLabel.center
                spinner.center.y += spinner.bounds.size.height / 2 + 15
                spinner.startAnimating()
                spinner.tag = spinnerTag
                containerView.addSubview(spinner)
            }
        } else {
            getButton.setTitle("Get My Location", for: .normal)
            
            if let spinner = view.viewWithTag(spinnerTag) {
                spinner.removeFromSuperview()
            }
        }
    }
    func string(from placemark: CLPlacemark) -> String {
        var line1 = ""
        line1.add(text: placemark.subThoroughfare)
        line1.add(text: placemark.thoroughfare, seperatedBy: " ")
        
        var line2 = ""
        line2.add(text: placemark.locality)
        line2.add(text: placemark.administrativeArea, seperatedBy: " ")
        line2.add(text: placemark.postalCode, seperatedBy: " ")
        
        line1.add(text: line2, seperatedBy: "\n")
        return line1
    }
    // Called after one minute, stops the location manager and updates the screen
    func didTimeOut() {
        print("*** Time out")
        if location == nil {
            stopLocationManager()
            lastLocationError = NSError(domain: "MyLocationsErrorDomain", code: 1, userInfo: nil)
            updateLabels()
            configureGetButton()
        }
    }
    
    // MARK: - Segue methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TagLocation" {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! LocationDetailsViewController
            controller.coordinate = location!.coordinate
            controller.placemark = placemark
            // Pass on the context to the TagLocation Screen
            controller.managedObjectContext = managedObjectContext
        }
    }
}

