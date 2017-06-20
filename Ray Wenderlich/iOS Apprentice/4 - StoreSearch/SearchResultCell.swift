//
//  SearchResultCell.swift
//  StoreSearch
//
//  Created by Eleni Chatzaki on 16/06/2017.
//  Copyright © 2017 Eleni. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var artworkImageView: UIImageView!
    
    var downloadTask: URLSessionDownloadTask?
    
    // MARK: - UITableCell
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // Change colour when tapping a row
        let selectedView = UIView(frame: CGRect.zero)
        selectedView.backgroundColor = UIColor(red: 20/255, green: 160/255, blue: 160/255, alpha: 0.5)
        selectedBackgroundView = selectedView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // Cancel pending cell image downloads when a cell is about to be reused
    override func prepareForReuse() {
        super.prepareForReuse()
        downloadTask?.cancel()
        downloadTask = nil
    }

    // MARK: - Configure contents of table view
    func configure(for searchResult: SearchResult) {
        nameLabel.text = searchResult.name
        
        if searchResult.artistName.isEmpty {
            artistNameLabel.text = NSLocalizedString("Unknown", comment: "Artist name unknown")
        } else {
            artistNameLabel.text = String(format: NSLocalizedString("ARTIST_NAME_LABEL_FORMAT", comment: "Format for artist name label"), searchResult.artistName, searchResult.kindForDisplay())
        }
        
        artworkImageView.image = UIImage(named: "Placeholder")
        if let smallURL = URL(string: searchResult.artworkSmallURL) {
            downloadTask = artworkImageView.loadImage(url: smallURL)
        }
    }
}
