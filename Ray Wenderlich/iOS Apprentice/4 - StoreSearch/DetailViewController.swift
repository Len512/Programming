//
//  DetailViewController.swift
//  StoreSearch
//
//  Created by Len512 on 16/06/2017.
//  Copyright © 2017 Len512. All rights reserved.
//

import UIKit
import MessageUI // enable sending messages

class DetailViewController: UIViewController {

    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var artworkImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var kindLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var priceButton: UIButton!
    
    var searchResult: SearchResult! {
        // provide a didSet observer to update the labels when the searchResult is changed
        didSet {
            if isViewLoaded {
                updateUI()
            }
        }
    }
    var downloadTask: URLSessionDownloadTask?
    
    // On an iPhone this view will be a pop-up, on an iPad not.
    var isPopUp = false
    
    enum AnimationStyle {
        case slide
        case fade
    }
    
    var dismissAnimationStyle = AnimationStyle.fade
    
    // MARK: - Action methods
    @IBAction func close() {
        dismissAnimationStyle = .slide
        dismiss(animated: true, completion: nil)
    }
    // Tapping the price button should take the user to the product's page on the iTunes store
    @IBAction func openInStore() {
        if let url = URL(string: searchResult.storeURL) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    // MARK: - Initialisation methods
    // This VC uses a custom presentation and sets the delegate
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    // MARK: - UIViewController methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Change the tint colour and make the pop-up view have rounded corners
        view.tintColor = UIColor(red: 20/255, green: 160/255, blue: 160/255, alpha: 1)
        view.backgroundColor = UIColor.clear
        popupView.layer.cornerRadius = 10
        // Create a new gesture recogniser that listens to taps anywhere in this view controller 
        // and calls the close method in response
        let gestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(close))
        gestureRecogniser.cancelsTouchesInView = false
        gestureRecogniser.delegate = self
        view.addGestureRecognizer(gestureRecogniser)
        
        if searchResult != nil {
            updateUI()
        }
        
        if isPopUp {
            // view in iPhone
            let gestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(close))
            
            gestureRecogniser.cancelsTouchesInView = false
            gestureRecogniser.delegate = self
            view.addGestureRecognizer(gestureRecogniser)
            
            view.backgroundColor = UIColor.clear
        } else {
            // view in iPad
            view.backgroundColor = UIColor(patternImage: UIImage(named: "LandscapeBackground")!)
            popupView.isHidden = true
            
            if let displayName = Bundle.main.localizedInfoDictionary?["CFBundleDisplayName"] as? String {
                title = displayName
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Putting data into Detail popup
    func updateUI() {
        nameLabel.text = searchResult.name
        if searchResult.artistName.isEmpty {
            artistNameLabel.text = NSLocalizedString("Unknown", comment: "Artist name unknown")
        } else {
            artistNameLabel.text = searchResult.artistName
        }
        kindLabel.text = searchResult.kindForDisplay()
        genreLabel.text = searchResult.genre
        
        // Show the price in the proper currency
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = searchResult.currency
        
        let priceText: String
        if searchResult.price == 0 {
            priceText = NSLocalizedString("Free", comment: "Price label: free")
        } else if let text = formatter.string(from: searchResult.price as NSNumber) {
            priceText = text
        } else {
            priceText = ""
        }
        priceButton.setTitle(priceText, for: .normal)
        
        // Load the artwork image
        if let largeURL = URL(string: searchResult.artworkLargeURL) {
            downloadTask = artworkImageView.loadImage(url: largeURL)
        }
        
        // Make the view visible on the iPad 
        popupView.isHidden = false
    }
    // when the object instance is deallocated, cancel any pending downloads
    deinit {
        print("deinit \(self)")
        downloadTask?.cancel()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        // Make the Detail VC the delegate for the menu popover in MenuViewController
        if segue.identifier == "ShowMenu" {
            let controller = segue.destination as! MenuViewController
            controller.delegate = self
        }
    }
    

}
extension DetailViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DimmingPresentationController(presentedViewController: presented, presenting: presenting)
    }
    // Use the Bounce animation controller when presenting the Detail popup
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BounceAnimationController()
    }
    // Use the SlideOut animation controller when closing the Detail popup
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch dismissAnimationStyle {
        case .slide:
            return SlideOutAnimationController()
        case .fade:
            return FadeOutAnimationController()
        }
    }
}
// Allow users to dismiss the pop-up by tapping anywhere outside it
extension DetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return (touch.view === self.view)
    }
}
extension DetailViewController: MenuViewControllerDelegate {
    func menuViewControllerSendSupportEmail(_ : MenuViewController) {
        dismiss(animated: true) {
            if MFMailComposeViewController.canSendMail() {
                let controller = MFMailComposeViewController()
                controller.mailComposeDelegate = self
                controller.setSubject(NSLocalizedString("Support Request", comment: "Email subject"))
                controller.setToRecipients(["your@email-address-here.com"])
                controller.modalPresentationStyle = .formSheet
                self.present(controller, animated: true, completion: nil)
            }
        }
    }
}
extension DetailViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
}
