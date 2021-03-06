//
//  Search.swift
//  StoreSearch
//
//  Created by Len512 on 19/06/2017.
//  Copyright © 2017 Len512. All rights reserved.
//

import Foundation
import UIKit

// Make a closure to communicate with SearchViewController 
typealias SearchComplete = (Bool) -> Void

class Search {
    
    enum State {
        case notSearchedYet
        case loading
        case noResults
        case results([SearchResult])
    }
    
    // Capability to cancel a task
    private var dataTask: URLSessionDataTask? = nil
    
    enum Category: Int {
        case all = 0
        case music = 1
        case software = 2
        case ebooks = 3
        
        var entityName: String {
            switch self {
            case .all: return ""
            case .music: return "musicTrack"
            case .software: return "software"
            case .ebooks: return "ebook"
            }
        }
    }
    
    // Keep track of Search's current state
    private(set) var state: State = .notSearchedYet
    
    func performSearch(for text: String, category: Category, completion: @escaping SearchComplete) {
        if !text.isEmpty {
            dataTask?.cancel()
            // Make the animated spinner visible in the app's status bar
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
            state = .loading
            
            let url = iTunesURL(searchText: text, category: category)
            
            let session = URLSession.shared
            
            dataTask = session.dataTask(with: url, completionHandler: {
                data, response, error in
                
                //self.state = .notSearchedYet
                var newState = State.notSearchedYet
                var success = false
                
                if let error = error as? NSError, error.code == -999 {
                    DispatchQueue.main.async {
                        self.state = .notSearchedYet
                    }
                    return // Search was cancelled
                }
                if let httpResponse = response as? HTTPURLResponse,
                        httpResponse.statusCode == 200,
                        let jsonData = data,
                        let jsonDictionary = self.parse(json: jsonData) {
                    
                    var searchResults = self.parse(dictionary: jsonDictionary)
                    if searchResults.isEmpty {
                        //self.state = .noResults
                        newState = .noResults
                    } else {
                        searchResults.sort(by: <)
                        //self.state = .results(searchResults)
                        newState = .results(searchResults)
                    }
                    success = true
                }
                DispatchQueue.main.async {
                    self.state = newState
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    completion(success)
                }
            })
            dataTask?.resume()
        }
    }
    // MARK: - Getting HTTP data
    private func iTunesURL(searchText: String, category: Category) -> URL {
        
        let entityName = category.entityName
        
        let locale = Locale.autoupdatingCurrent
        let language = locale.identifier
        let countryCode = locale.regionCode ?? "en_US"
        
        let escapedSearchText = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let urlString = String(format: "https://itunes.apple.com/search?term=%@&limit=200&entity=%@", escapedSearchText, entityName)
        let url = URL(string: urlString)
        print("URL: \(url!)")
        return url!
    }
    // MARK: JSON parse methods
    private func parse(json data: Data) -> [String: Any]? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print("JSON Error: \(error)")
            return nil
        }
    }
    private func parse(dictionary: [String: Any]) -> [SearchResult]{
        // make sure the dictionary has a key named results that contains an array
        guard let array = dictionary["results"] as? [Any] else {
            print("Expected 'results' array")
            return []
        }
        var searchResults = [SearchResult]()
        
        // look at each of the array's elements in turn
        for resultDict in array {
            // Each element is another dictionary holding an array
            if let resultDict = resultDict as? [String: Any] {
                
                var searchResult: SearchResult?
                
                if let wrapperType = resultDict["wrapperType"] as? String {
                    switch wrapperType {
                    case "track":
                        searchResult = parse(track: resultDict)
                    case "audiobook":
                        searchResult = parse(audiobook: resultDict)
                    case "software":
                        searchResult = parse(software: resultDict)
                    default:
                        break
                    }
                } else if let kind = resultDict["kind"] as? String, kind == "ebook" {
                    searchResult = parse(ebook: resultDict)
                }
                if let result = searchResult {
                    searchResults.append(result)
                }
            }
        }
        return searchResults
    }
    private func parse(track dictionary: [String: Any]) -> SearchResult {
        let searchResult = SearchResult()
        
        searchResult.name = dictionary["trackName"] as! String
        searchResult.artistName = dictionary["artistName"] as! String
        searchResult.artworkSmallURL = dictionary["artworkUrl60"] as! String
        searchResult.artworkLargeURL = dictionary["artworkUrl100"] as! String
        searchResult.storeURL = dictionary["trackViewUrl"] as! String
        searchResult.kind = dictionary["kind"] as! String
        searchResult.currency = dictionary["currency"] as! String
        
        if let price = dictionary["trackPrice"] as? Double {
            searchResult.price = price
        }
        if let genre = dictionary["primaryGenreName"] as? String {
            searchResult.genre = genre
        }
        return searchResult
    }
    
    private func parse(audiobook dictionary: [String: Any]) -> SearchResult {
        let searchResult = SearchResult()
        searchResult.name = dictionary["collectionName"] as! String
        searchResult.artistName = dictionary["artistName"] as! String
        searchResult.artworkSmallURL = dictionary["artworkUrl60"] as! String
        searchResult.artworkLargeURL = dictionary["artworkUrl100"] as! String
        searchResult.storeURL = dictionary["collectionViewUrl"] as! String
        searchResult.kind = "audiobook"
        searchResult.currency = dictionary["currency"] as! String
        if let price = dictionary["collectionPrice"] as? Double {
            searchResult.price = price
        }
        if let genre = dictionary["primaryGenreName"] as? String {
            searchResult.genre = genre
        }
        return searchResult
    }
    
    private func parse(software dictionary: [String: Any]) -> SearchResult {
        let searchResult = SearchResult()
        searchResult.name = dictionary["trackName"] as! String
        searchResult.artistName = dictionary["artistName"] as! String
        searchResult.artworkSmallURL = dictionary["artworkUrl60"] as! String
        searchResult.artworkLargeURL = dictionary["artworkUrl100"] as! String
        searchResult.storeURL = dictionary["trackViewUrl"] as! String
        searchResult.kind = dictionary["kind"] as! String
        searchResult.currency = dictionary["currency"] as! String
        if let price = dictionary["price"] as? Double {
            searchResult.price = price
        }
        if let genre = dictionary["primaryGenreName"] as? String {
            searchResult.genre = genre
        }
        return searchResult
    }
    
    private func parse(ebook dictionary: [String: Any]) -> SearchResult {
        let searchResult = SearchResult()
        searchResult.name = dictionary["trackName"] as! String
        searchResult.artistName = dictionary["artistName"] as! String
        searchResult.artworkSmallURL = dictionary["artworkUrl60"] as! String
        searchResult.artworkLargeURL = dictionary["artworkUrl100"] as! String
        searchResult.storeURL = dictionary["trackViewUrl"] as! String
        searchResult.kind = dictionary["kind"] as! String
        searchResult.currency = dictionary["currency"] as! String
        if let price = dictionary["price"] as? Double {
            searchResult.price = price
        }
        if let genres: Any = dictionary["genres"] {
            searchResult.genre = (genres as! [String]).joined(separator: ", ")
        }
        return searchResult
    }

}
