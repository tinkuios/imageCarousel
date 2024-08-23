//
//  DownloadImage.swift
//  SwiftExamApp
//
//  Created by Tinku Sardar on 23/08/24.
//

import Foundation
import UIKit

// MARK: - Download image-separate function

func loadImage(from urlString: String, into imageView: UIImageView) {
    // Ensure the URL is valid
    guard let url = URL(string: urlString) else {
        debugPrint("Invalid URL")
        return
    }
    
    // Create a data task to fetch the image data
    URLSession.shared.dataTask(with: url) { data, response, error in
        // Handle any errors
        if let error = error {
            debugPrint("Error fetching image: \(error)")
            return
        }
        
        // Ensure data is valid and create an image from it
        guard let data = data, let image = UIImage(data: data) else {
            debugPrint("Failed to create image from data")
            return
        }
        
        // Update the image view on the main thread
        DispatchQueue.main.async {
            imageView.image = image
        }
    }.resume()
}
