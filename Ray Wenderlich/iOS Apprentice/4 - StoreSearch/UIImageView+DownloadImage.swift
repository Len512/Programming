//
//  UIImageView+DownloadImage.swift
//  StoreSearch
//
//  Created by Len512 on 16/06/2017.
//  Copyright © 2017 Len512. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImage(url: URL) -> URLSessionDownloadTask {
        let session = URLSession.shared
        // Create download task that saves the downloaded file to a temporary location on disk
        let downloadTask = session.downloadTask(with: url, completionHandler: { [weak self] url, response, error in
            // this url points to the local file
            if error == nil, let url = url, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                // if loading the file to data object is successful, put it into the UIImageView's image property
                DispatchQueue.main.async {
                    if let strongSelf = self {
                        strongSelf.image = image
                    }
                }
            }
        })
        // start the download task and return it to the caller, so it can be cancelled 
        downloadTask.resume()
        return downloadTask
    }
}
