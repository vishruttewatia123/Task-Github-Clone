//
//  MainViewCollectionViewCell.swift
//  GithubViewer V 2.0
//
//  Created by Vishrut tewatia on 02/08/22.
//

import UIKit

class MainViewCollectionViewCell: UICollectionViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var fetchedData: UILabel!
    @IBOutlet weak var heading: UILabel!
    
    
    static let identifier = "MainViewCollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: Configuring Collection View Data
    
    func configureCollectionView (with text: String?, with count: Int?){
        fetchedData.text = "\(UpdateCount.roundedWithAbbreviations(count ?? 0))"
        heading.text = text ?? " "
    }

    static func nib() -> UINib {
        return UINib(nibName: "MainViewCollectionViewCell", bundle: nil)
    }

}
