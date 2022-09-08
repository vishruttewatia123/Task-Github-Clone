//
//  Loader.swift
//  GithubViewer V 2.0
//
//  Created by Vishrut tewatia on 04/08/22.
//

import Foundation
import UIKit

fileprivate var activityView: UIView?

extension UIViewController {
    func showSpinner() {
        activityView = UIView(frame: self.view.bounds)
        activityView?.backgroundColor = UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        activityIndicator.center = activityView!.center
        activityIndicator.startAnimating()
        activityView?.addSubview(activityIndicator)
        self.view.addSubview(activityView!)
    }
    
    func stopSpinner(){
        activityView?.removeFromSuperview()
        activityView = nil
    }
}
