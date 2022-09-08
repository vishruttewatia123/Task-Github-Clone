//
//  FetchImageFunction.swift
//  GithubViewer V 2.0
//
//  Created by Vishrut tewatia on 01/08/22.
//

import Foundation
import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else {return }
            DispatchQueue.main.async() { [weak self] in
                self?.activityIndicator.stopAnimating()
                self?.image = image
            }
        }.resume()
       
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        self.activityIndicator.startAnimating()
        guard let url = URL(string: link) else {
            return }
        downloaded(from: url, contentMode: mode)
    }
    fileprivate var activityIndicator: UIActivityIndicatorView {
    get {

        if let indicator = self.subviews.first(where: { $0 is UIActivityIndicatorView }) as? UIActivityIndicatorView {
            return indicator
        }

        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.hidesWhenStopped = true
        self.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        let centerX = NSLayoutConstraint(item: self,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: activityIndicator,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0)

        let centerY = NSLayoutConstraint(item: self,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: activityIndicator,
                                         attribute: .centerY,
                                         multiplier: 1,
                                         constant: 0)

        self.addConstraints([centerX, centerY])
        return activityIndicator
      }
    }
}
