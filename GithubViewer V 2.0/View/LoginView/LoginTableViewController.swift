//
//  LoginTableViewController.swift
//  GithubViewer V 2.0
//
//  Created by Vishrut tewatia on 01/08/22.
//

import UIKit

class LoginTableViewController: UITableViewController,LoginViewModelDelegate {
    
    // MARK: Outlets
    
    @IBOutlet weak var loginImage: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: Login View Model Object
    let loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginViewModel.delegate = self
    }
    
    // MARK: Login View Model Protocols
    
    // User is found
    
    func goToMainScreenController() {
        DispatchQueue.main.async { [weak self] in
//            let userMainVC = self.storyboard?.instantiateViewController(withIdentifier: "mainvc") as! MainScreenViewController
            
        // Calling main view dependency injection
            
            let controller = self?.storyboard?.instantiateViewController(withIdentifier: "mainvc") as! MainScreenViewController
            controller.title = self?.loginViewModel.userModel?.name
            controller.mainUserViewModel.userName = self?.loginViewModel.userModel?.login
//            userMainVC.mainUserViewModel.userModel = self.loginViewModel.userModel
//            userMainVC.mainUserViewModel.userCount.append(self.loginViewModel.userModel?.public_repos ?? 0)
//            userMainVC.mainUserViewModel.userCount.append(self.loginViewModel.userModel?.followers ?? 0)
//            userMainVC.mainUserViewModel.userCount.append(self.loginViewModel.userModel?.following ?? 0)
            self?.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    // User not found
    
    func goToNotFoundController() {
        DispatchQueue.main.async { [weak self] in
            
            let alert = UIAlertController(title: "An Error Occured!", message: "User not found.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            self?.present(alert, animated: true)
//            let userNotFoundVC = self?.storyboard?.instantiateViewController(withIdentifier: "notfoundvc") as! NotFoundViewController
//            userNotFoundVC.text = "User Not found"
//
//            self?.navigationController?.pushViewController(userNotFoundVC, animated: true)
        }
    }
    
    // Data can't be fetched
    
    func dataCantBeFetched() {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "An Error Occured", message: "Couldn't fetch data.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            self?.present(alert, animated: true)
//            let dataNotFetchedVC = self?.storyboard?.instantiateViewController(withIdentifier: "notfoundvc") as! NotFoundViewController
//            dataNotFetchedVC.text = "Cant fetch data"
//            self?.navigationController?.pushViewController(dataNotFetchedVC, animated: true)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // MARK: Login button tapped

    @IBAction func loginTapped(_ sender: Any){
        guard let username = usernameField.text, !username.isEmpty,!username.contains(" ") else {return}
        loginViewModel.getUser(user: username)
    }

}
