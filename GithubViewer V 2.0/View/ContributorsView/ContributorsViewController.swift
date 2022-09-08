//
//  ContributorsViewController.swift
//  GithubViewer V 2.0
//
//  Created by Vishrut tewatia on 03/08/22.
//

import UIKit

class ContributorsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ContributorsViewModelDelegate {
   
    // MARK: Outlets
    
    @IBOutlet weak var contributorTableView: UITableView!
    
    var contributorsViewModel = ContributorsViewModel()
    
//    // MARK: Dependency Injection for Contributors View Controller
//
//    static func initiateContributorsController(reponame: String) -> ContributorsViewController{
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let contributorsvc = storyboard.instantiateViewController(withIdentifier: "contributorsvc") as! ContributorsViewController
//        contributorsvc.contributorsViewModel = ContributorsViewModel(reponame: reponame)
//        return contributorsvc
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Activity Tracker
        self.showSpinner()
        
        // MARK: Fetching Contriubtors API
        contributorsViewModel.getContributors(user: contributorsViewModel.repoName ?? "")
        
        // Contributor Model Delegate
        contributorsViewModel.delegate = self
        
        // Table View objects and cell registered
        contributorTableView.delegate = self
        contributorTableView.dataSource = self
        contributorTableView.register(ContributorsTableViewCell.nib(), forCellReuseIdentifier: "ContributorsTableViewCell")

        // Do any additional setup after loading the view.
    }
    
    // MARK: Contributors View Model Protocol
    
    // couldnt fetch contributors
    
    func couldntFetchContributors() {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "An Error Occured", message: "Couldn't fetch Contributors data.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            self?.stopSpinner()
            self?.present(alert, animated: true)
        }
    }
    
    // reload contributors
    func reloadContributorsTableView() {
        DispatchQueue.main.async {
            self.contributorTableView.reloadData()
            self.stopSpinner()
        }
    }
                  
    // MARK: Table View Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contributorsViewModel.contributorsModel.count 
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contributorTableView.dequeueReusableCell(withIdentifier: ContributorsTableViewCell.identifier, for: indexPath) as! ContributorsTableViewCell
        cell.configureContributors(with: contributorsViewModel.contributorsModel[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "mainvc") as! MainScreenViewController
        controller.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "home"), style: .plain, target: self, action: #selector(gotohome))
        controller.mainUserViewModel.userName = self.contributorsViewModel.contributorsModel[indexPath.row].login
        controller.title = contributorsViewModel.contributorsModel[indexPath.row].login
        navigationController?.pushViewController(controller, animated: true)
        contributorTableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func gotohome(){
//        self.navigationController?.popToRootViewController(animated: true)
        self.navigationController?.popToViewController(of: MainScreenViewController.self, animated: true)
    }

}
