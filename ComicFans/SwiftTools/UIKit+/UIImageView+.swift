//
//  UIImageView+.swift
//  ComicFans
//
//  Created by Andrew Masters on 11/4/23.
//

import Foundation
import UIKit

extension UIImageView {
    
    func downloaded(from url_path: String, contentMode mode: ContentMode = .scaleAspectFit) {
        if(url_path.isEmpty) {
            DispatchQueue.main.async() { [weak self] in
                self?.image = UIImage(systemName: "questionmark.circle")
                return
            }
        }
        
        guard let url = URL(string: url_path) else { return }
        self.downloaded(from: url, contentMode: mode)
    }
    
    
    private func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
}
