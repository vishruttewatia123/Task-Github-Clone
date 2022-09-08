//
//  UpdateStars.swift
//  GithubViewer V 2.0
//
//  Created by Vishrut tewatia on 04/08/22.
//

import Foundation

class UpdateCount{
    static func roundedWithAbbreviations(_ number: Int) -> String{
            let nf = NumberFormatter()
            nf.roundingMode = .down
            nf.maximumFractionDigits = 1
            
            let number = Double(number)
            let thousand = number / 1000
            let million = number / 1000000
            let billion = number / 1000000000
            
            if billion >= 1.0 {
                return nf.string(for: billion)! + "B"
            }
            else if million >= 1.0 {
                return nf.string(for: million)! + "M"
            }
            else if thousand >= 1.0 {
                return nf.string(for: thousand)! + "K"
            }
            else {
                return "\(Int(number))"
            }
        }
}
