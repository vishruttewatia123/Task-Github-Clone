//
//  TagCollectionViewCell.swift
//  TestLogin
//
//  Created by Vishrut tewatia on 01/08/22.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var topiclabel: UILabel!
    
    static let identifier = "TagCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: Configuring Topics Collection View
    func configuretag(with tag: String)
    {
        topiclabel.text = tag
    }

    static func nib() -> UINib {
        return UINib(nibName: "TagCollectionViewCell", bundle: nil)
    }

}
