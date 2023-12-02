//
//  UIImageView+.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/4/23.
//

import Foundation
import UIKit

extension UIImageView {
    
    func downloaded(from url_path: String, contentMode mode: ContentMode = .scaleAspectFit, completion: @escaping (UIImage?) -> (Void)) {
        if(url_path.isEmpty) {
            DispatchQueue.main.async() { [weak self] in
                self?.image = UIImage(systemName: "questionmark.circle")
                completion(nil)
                return
            }
        }
        
        guard let url = URL(string: url_path) else { return }
        self.downloaded(from: url, contentMode: mode, completion: completion)
    }
    
    
    private func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit, completion: @escaping (UIImage?) -> (Void)) {
        self.image = nil
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.color = .white
        activityIndicator.center = self.center
        self.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            DispatchQueue.main.async() { [weak self] in
                activityIndicator.stopAnimating()
                self?.image = image
                completion(image)
            }
        }.resume()
    }
}
