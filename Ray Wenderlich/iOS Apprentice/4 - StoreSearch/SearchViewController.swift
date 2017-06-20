//
//  ViewController.swift
//  StoreSearch
//
//  Created by Len512 on 16/06/2017.
//  Copyright © 2017 Len512. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var landscapeViewController: LandscapeViewController?
    
    // A wat to pass the detail vc instance to the Search view for the iPad
    weak var splitViewDetail: DetailViewController?
    
    let search = Search()
    
    struct TableViewCellIdentifiers {
        static let searchResultCell = "SearchResultCell"
        static let nothingFoundCell = "NothingFoundCell"
        static let loadingCell = "LoadingCell"
    }
    // MARK: - Action Methods
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        performSearch()
    }
    // MARK: - Screen methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Change the content inset so that the Search bar does not obscure the table view
        // Add a 64-point margin on top (20 for status bar,  44 for search bar and 44 for the segmented control)
        tableView.contentInset = UIEdgeInsets(top: 108, left: 0, bottom: 0, right: 0)
        tableView.rowHeight = 80
        
        var cellNib = UINib(nibName: TableViewCellIdentifiers.searchResultCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.searchResultCell)
        
        cellNib = UINib(nibName: TableViewCellIdentifiers.nothingFoundCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.nothingFoundCell)
        
        cellNib = UINib(nibName: TableViewCellIdentifiers.loadingCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableViewCellIdentifiers.loadingCell)
        
        if UIDevice.current.userInterfaceIdiom != .pad {
            searchBar.becomeFirstResponder()
        }
        
        title = NSLocalizedString("Search", comment: "Split-view master button")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // this is invoked when the trait collection for the view controller changes
    // (horizontal and vertical size classes, display scale (Retina or not), 
    // user interface idiom (iPhone or iPad), preferred Dynamic type font size, etc)
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        
        let rect = UIScreen.main.bounds
        
        if (rect.width == 736 && rect.height == 414) || (rect.width == 414 && rect.height == 736) {
            if presentedViewController != nil {
                dismiss(animated: true, completion: nil)
            }
        } else if UIDevice.current.userInterfaceIdiom != .pad {
            switch newCollection.verticalSizeClass {
            case .compact:
                showLandscape(with: coordinator)
            case .regular, .unspecified:
                hideLandscape(with: coordinator)
            }
        }
    }
    
    // MARK: - HTTP Request methods
    
    func performStoreRequest(with url: URL) -> String? {
        do {
            return try String(contentsOf: url, encoding: .utf8)
        } catch {
            print("Download error: \(error)")
            return nil
        }
    }
    
    // MARK: - Error Handling
    func showNetworkError() {
        let alert = UIAlertController(
            title: NSLocalizedString("Whoops...", comment: "Error alert: title"),
            message: NSLocalizedString("There was an error reading from the iTunes Store. Please try again.", comment: "Error alert: message"),
            preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Landscape methods
    func showLandscape(with coordinator: UIViewControllerTransitionCoordinator) {
        guard landscapeViewController == nil else {
            return
        }
        landscapeViewController = storyboard!.instantiateViewController(withIdentifier: "LandscapeViewController") as? LandscapeViewController
        // Instead of presenting the new screen via present(animated, completion) or through a segue, 
        // add the new Landscape VC as a child of Search VC
        if let controller = landscapeViewController {
            // pass the search results array to the landscape vc
            controller.search = search
            controller.view.frame = view.bounds
            controller.view.alpha = 0
            
            view.addSubview(controller.view)
            addChildViewController(controller)
            // start see-through and then fade in until fully visible
            coordinator.animate(alongsideTransition: { _ in
                controller.view.alpha = 1
                // hide the keyboard when rotating the app
                self.searchBar.resignFirstResponder()
                // close the popup if it is open when rotating the app
                if self.presentedViewController != nil {
                    self.dismiss(animated: true, completion: nil)
                }
            }, completion: { _ in
                controller.didMove(toParentViewController: self)
            })
        }
    }
    func hideLandscape(with coordinator: UIViewControllerTransitionCoordinator) {
        // inverse the above so as to show portrait view
        if let controller = landscapeViewController {
            controller.willMove(toParentViewController: nil)
            
            coordinator.animate(alongsideTransition: { _ in
                controller.view.alpha = 0
            }, completion: { _ in
                controller.view.removeFromSuperview()
                controller.removeFromParentViewController()
                self.landscapeViewController = nil
                
                if self.presentedViewController != nil {
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
    // Change display mode to .primaryHidden to hide the master pane and restore to .automatic, 
    // otherwise the master pane stays hidden even in lanscape mode on the iPad
    func hideMasterPane() {
        UIView.animate(withDuration: 0.25, animations: {
            self.splitViewController!.preferredDisplayMode = .primaryHidden
        }, completion: { _ in
            self.splitViewController!.preferredDisplayMode = .automatic
        })
    }
    // MARK: - Segue methods
    // The detail popup is launched with a segue triggered from tableView(didSelectRowAt)
    // Pass the searchResults from the selected row into the popupView
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if case .results(let list) = search.state {
                let detailViewController = segue.destination as! DetailViewController
                let indexPath = sender as! IndexPath
                let searchResult = list[indexPath.row]
                detailViewController.searchResult = searchResult
                // show the detail popup on an iPhone
                detailViewController.isPopUp = true
            }
            
        }
    }

}
// Delegate for listening to the search bar
extension SearchViewController: UISearchBarDelegate {
    func performSearch() {
        if let category = Search.Category(rawValue: segmentedControl.selectedSegmentIndex) {
            search.performSearch(for: searchBar.text!, category: category, completion: {
                success in
                if !success {
                    self.showNetworkError()
                }
                self.tableView.reloadData()
                self.landscapeViewController?.searchResultsReceived()
            })
            tableView.reloadData()
            searchBar.resignFirstResponder()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        performSearch()
    }
    
    // Unify the search bar with the status bar
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch search.state {
        case .notSearchedYet:
            return 0
        case .loading:
            return 1
        case .noResults:
            return 1
        case .results(let list):
            return list.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch search.state {
        case .notSearchedYet:
            fatalError("Should never get here")
        case .loading:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.loadingCell, for: indexPath)
            let spinner = cell.viewWithTag(100) as! UIActivityIndicatorView
            spinner.startAnimating()
            return cell
        case .noResults:
            return tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.nothingFoundCell, for: indexPath)
        case .results(let list):
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifiers.searchResultCell, for: indexPath) as! SearchResultCell
            let searchResult = list[indexPath.row]
            cell.configure(for: searchResult)
            return cell
        }
    }
}
extension SearchViewController: UITableViewDelegate {
    // Deselect row with an animation
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.resignFirstResponder()
        // .compact means we are using an iPhone
        if view.window!.rootViewController!.traitCollection.horizontalSizeClass == .compact {
            tableView.deselectRow(at: indexPath, animated: true)
            performSegue(withIdentifier: "ShowDetail", sender: indexPath)
        } else {
            // on an iPad, assign the SearchResult object to the existing DetailViewController that lives in the detail pane
            if case .results(let list) = search.state {
                splitViewDetail?.searchResult = list[indexPath.row]
            }
            // .allVisible only applies in landscape, so if not in landscape, hide the master pane when a row gets tapped
            if splitViewController!.displayMode != .allVisible {
                hideMasterPane()
            }
        }
    }
    // Make only rows with actual results selectable
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        switch search.state {
        case .notSearchedYet, .loading, .noResults:
            return nil
        case .results:
            return indexPath
        }
    }
}
