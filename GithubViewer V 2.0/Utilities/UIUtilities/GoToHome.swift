//
//  GoToHome.swift
//  GithubViewer V 2.0
//
//  Created by Vishrut tewatia on 04/08/22.
//

import Foundation
import UIKit

extension UINavigationController {
  func getViewController<T: UIViewController>(of type: T.Type) -> UIViewController? {
    return self.viewControllers.first(where: { $0 is T })
  }
  func popToViewController<T: UIViewController>(of type: T.Type, animated: Bool) {
    guard let viewController = self.getViewController(of: type) else { return }
    self.popToViewController(viewController, animated: animated)
  }
}
