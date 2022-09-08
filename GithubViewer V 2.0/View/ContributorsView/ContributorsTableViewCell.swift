//
//  ContributorsTableViewCell.swift
//  TestLogin
//
//  Created by Vishrut tewatia on 01/08/22.
//

import UIKit

class ContributorsTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var contributorImage: UIImageView!
    @IBOutlet weak var contributorname: UILabel!
    @IBOutlet weak var contributorCount: UILabel!
    
    static let identifier = "ContributorsTableViewCell"
    
    var model: ContributorsModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ContributorsTableViewCell", bundle: nil)
    }
    
    // MARK: Configuring Contributors Model
    
    func configureContributors(with model: ContributorsModel?)
    {
        contributorImage.downloaded(from: (model?.avatar_url)!)
        contributorImage.roundimage()
        contributorname.text = model?.login
        contributorCount.text = "\(model?.contributions ?? 0)"
    }
    
}
