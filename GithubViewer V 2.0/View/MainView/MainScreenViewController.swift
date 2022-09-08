//
//  MainScreenViewController.swift
//  GithubViewer V 2.0
//
//  Created by Vishrut tewatia on 02/08/22.
//

import UIKit

class MainScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MainUserViewModelDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
   
    // MARK: Outlets
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var fetchedImage: UIImageView!
    @IBOutlet weak var fetchedName: UILabel!
    @IBOutlet weak var fetchedUsername: UILabel!
    @IBOutlet weak var fetchedBio: UILabel!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var infoCollectionView: UICollectionView!
    @IBOutlet weak var segmentedView: UIView!
    
    // MARK: Main User View Model Object
    
    var mainUserViewModel = MainUserViewModel()
    
//    // MARK: Dependency Injection for Main Screen Controller
//
//    static func initiateMainScreenController(username: String) -> MainScreenViewController{
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let mainvc = storyboard.instantiateViewController(withIdentifier: "mainvc") as! MainScreenViewController
//        mainvc.mainUserViewModel = MainUserViewModel(username: username)
//        return mainvc
//    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.showSpinner()
        
        // MARK: API call
        mainUserViewModel.getUser(user: mainUserViewModel.userName ?? "")
        mainUserViewModel.getUserRepo(user: mainUserViewModel.userName ?? "")
        
        // Table view objects and cell registered
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(RepoCustomTableViewCell.nib(), forCellReuseIdentifier: RepoCustomTableViewCell.identifier)
        
        // Adding the header view to tableview header
        mainTableView.tableHeaderView = headerView
        
        // Collection view objects and cell registered
        infoCollectionView.delegate = self
        infoCollectionView.dataSource = self
        infoCollectionView.register(MainViewCollectionViewCell.nib(), forCellWithReuseIdentifier: "MainViewCollectionViewCell")
        
        // Main user view model delegate
        mainUserViewModel.delegate = self
        
//         Function to remove padding from sections
        if #available(iOS 15.0, *){
            mainTableView.sectionHeaderTopPadding = 0
        }
        else{
            UITableView.appearance().sectionHeaderTopPadding = CGFloat(0)
        }

    }
    
    // To fix collection view orientation in landspace mode
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
            
            DispatchQueue.main.async {
                self.infoCollectionView.reloadData()
            }
        }
    
//    func callLoader() {
//        DispatchQueue.main.async {
//            self.showSpinner()
//        }
//    }
    
    // MARK: User View Model Protocols
    
    // Updating header UI
    
    func updateMainScreenUI() {
        
        DispatchQueue.main.async { [weak self] in
            self?.fetchedImage.downloaded(from: (self?.mainUserViewModel.userModel?.avatar_url)!)
            self?.fetchedImage.roundimage()
            self?.fetchedName.text = self?.mainUserViewModel.userModel?.name ?? Default_Label1
            self?.fetchedUsername.text = "@\(self?.mainUserViewModel.userModel?.login ?? Default_Label1)"
            self?.fetchedBio.text = self?.mainUserViewModel.userModel?.bio ?? Default_Label1
            self?.stopSpinner()
        }
    }
    
    // User cant be fetched
    
    func userCantBeFetched() {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "An Error Occured", message: "Couldn't fetch User data.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            self?.stopSpinner()
            self?.present(alert, animated: true)
        }
    }
    
    // User Repo cant be fetched
    func repoDataCantBeFetched() {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "An Error Occured", message: "Couldn't fetch User Repository data.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            self?.stopSpinner()
            self?.present(alert, animated: true)
        }
    }
    
    
    // Reloading tableview and collection view data
    
    func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.infoCollectionView.reloadData()
            self?.mainTableView.reloadData()
//            self?.stopSpinner()
        }
    }
    
    
    // MARK: Collection view functions
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = infoCollectionView.dequeueReusableCell(withReuseIdentifier: MainViewCollectionViewCell.identifier, for: indexPath) as? MainViewCollectionViewCell
        
            if let userCount = mainUserViewModel.userCount?[indexPath.row] {
                let userData = mainUserViewModel.userData[indexPath.row]
                cell?.configureCollectionView(with: userData, with: userCount)
            }
        
        return cell ?? MainViewCollectionViewCell()
    }
    
    // Race condition solved by taking userCount instead of userData
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainUserViewModel.userCount?.count ?? 0
    }
    
    // For distributing the collection view cells
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    //        let width = collectionView.frame.size.width
    //        return CGSize(width: (width), height: (width/3))
            
        let cellCount = mainUserViewModel.userData.count 
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let cellSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right + (flowLayout.minimumInteritemSpacing * CGFloat((cellCount) - 1))
            
        let cellSize = (( collectionView.bounds.width) - cellSpace) / CGFloat(cellCount)
            print(collectionView.bounds.width, collectionView.frame.width, collectionView.bounds.size.width)
            
            return CGSize(width: cellSize, height: collectionView.bounds.height)
    }
    
    // MARK: Table view functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 120))
        if(section == 0){
            return infoCollectionView
        }
        return segmentedView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0){
            return 100
        }
        return 55
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 0
        } else {
            return mainUserViewModel.userRepoModel?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: RepoCustomTableViewCell.identifier, for: indexPath) as! RepoCustomTableViewCell
        cell.configurecell(with: (mainUserViewModel.userRepoModel?[indexPath.row]))
//        cell.CellBorder()
        return cell
    }
    
    // Manually adding vertical padding to row cell
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
//    {
//        let verticalPadding: CGFloat = 8
//        let maskLayer = CALayer()
//        maskLayer.cornerRadius = 10    //if you want round edges
//        maskLayer.backgroundColor = UIColor.black.cgColor
//        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
//        cell.layer.mask = maskLayer
//    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "contributorsvc") as! ContributorsViewController
        controller.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "home"), style: .plain, target: self, action: #selector(gotohome))
        controller.title = "Contributors"
        controller.contributorsViewModel.repoName = self.mainUserViewModel.userRepoModel?[indexPath.row].full_name
        self.navigationController?.pushViewController(controller, animated: true)
        mainTableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Segments Changed
    
    @IBAction func segmentChanged(_ sender: Any){
        DispatchQueue.main.async { [weak self] in
            self?.mainTableView.reloadData()
        }
    }
    
    // Function to go to home screen
    
    @objc func gotohome(){
//        self.navigationController?.popToRootViewController(animated: true)
        self.navigationController?.popToViewController(of: MainScreenViewController.self, animated: true)
    }

}
