//
//  BorderForCell.swift
//  GithubViewer V 2.0
//
//  Created by Vishrut tewatia on 08/08/22.
//

import Foundation
import UIKit

extension UITableViewCell{
    func CellBorder(){
        self.backgroundColor = UIColor.white
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 5
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}
