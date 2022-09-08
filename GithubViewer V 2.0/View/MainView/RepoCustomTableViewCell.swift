//
//  RepoCustomTableViewCell.swift
//  TestLogin
//
//  Created by Vishrut tewatia on 21/07/22.
//

import UIKit

class RepoCustomTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // MARK: Outlets

    @IBOutlet weak var repoImage: UIImageView!
    @IBOutlet weak var reponame: UILabel!
    @IBOutlet weak var repolanguage: UILabel!
    @IBOutlet weak var repodescription: UILabel!
    @IBOutlet weak var repostargazers: UILabel!
    @IBOutlet weak var repotimeupdate: UILabel!
    @IBOutlet weak var repoforks: UILabel!
    @IBOutlet weak var topicscollectionview: UICollectionView!
    @IBOutlet weak var heightForTopicsView: NSLayoutConstraint!
    @IBOutlet weak var RepoView: UIView!
    
    var model: UserRepoModel?
    
    let dateChanger = TimeChanger()
    
    static let identifier = "RepoCustomTableViewCell"
    let defaultvalue = "Not given"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        topicscollectionview.register(TagCollectionViewCell.nib(), forCellWithReuseIdentifier: "TagCollectionViewCell")
        topicscollectionview.delegate = self
        topicscollectionview.dataSource = self
        
        // Configuring border for view
        RepoView.layer.cornerRadius = 15
        RepoView.layer.borderWidth = 1
        RepoView.layer.borderColor = UIColor.lightGray.cgColor
        
        //Configuring shadow for view
        RepoView.layer.shadowColor = UIColor.lightGray.cgColor
        RepoView.layer.shadowOpacity = 1
        RepoView.layer.shadowOffset = .zero
        RepoView.layer.shadowRadius = 4
        
        // Initialization code
    }
    
    // This provides horizontal padding by reframing the frame
    
//    override var frame: CGRect {
//        get {
//            return super.frame
//        }
//        set (newFrame) {
//            let inset: CGFloat = 15
//            var frame = newFrame
//            frame.origin.x += inset
//            frame.size.width -= 2 * inset
//            super.frame = frame
//        }
//    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
//    }
    
    static func nib() -> UINib {
        return UINib(nibName: "RepoCustomTableViewCell", bundle: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

        // Configure the view for the selected state
    }
    
    // MARK: Configuring Table View Cells
    
    func configurecell(with model: UserRepoModel?){
        self.model = model
        
        //--
        //topics: []
        //check for above^
        
        // Condition to hide the collection view if there is an empty array
        if(model?.topics?.count == 0){
            topicscollectionview.isHidden = true
            heightForTopicsView.constant = 0
        }else{
            topicscollectionview.isHidden = false
            heightForTopicsView.constant = 38
        }
        
        // Assigning attributes
        repoImage.roundimage()
        reponame.text = "\(model?.name ?? defaultvalue) 🌍"
        repolanguage.text = "🔵 \(model?.language ?? defaultvalue)"
        repodescription.text = model?.description ?? defaultvalue
        repostargazers.text = "⭐️ \(model?.stargazers_count ?? 0)"
        repotimeupdate.text = dateChanger.dateToTimeChanger(repoDate: (model?.updated_at ?? defaultvalue))
        repoforks.text = "\(model?.forks ?? 0)"
        
        topicscollectionview.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model?.topics?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = topicscollectionview.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier , for: indexPath) as! TagCollectionViewCell
        
        cell.configuretag(with: model?.topics?[indexPath.row] ?? defaultvalue)
        return cell
    }
    
    
}
