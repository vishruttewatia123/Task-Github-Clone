//
//  UserRepoViewModel.swift
//  GithubViewer V 2.0
//
//  Created by Vishrut tewatia on 02/08/22.
//

import Foundation

// MARK: Main User View Model Protocol

protocol MainUserViewModelDelegate: NSObject {
    func updateMainScreenUI()
    func userCantBeFetched()
    func repoDataCantBeFetched()
    func reloadTableView()
//    func callLoader()
}

let Default_Label1 = "Not given"

// MARK: Main User View Model Class

class MainUserViewModel {
    let fetchAPI: APIManager // MARK: API protocol object
    weak var delegate: MainUserViewModelDelegate? 
    var userName: String?
    var userData = ["repositories", "followers", "following"]
    var userCount: [Int]? = [Int]()
    
    var userModel: UserModel? {
        didSet{
            
            //MARK: To set usercount when UserModel is created
            
            if userCount == nil {
                userCount = []
            }
            self.userCount?.append(self.userModel?.public_repos ?? 0)
            self.userCount?.append(self.userModel?.followers ?? 0)
            self.userCount?.append(self.userModel?.following ?? 0)
            self.delegate?.updateMainScreenUI()
            self.delegate?.reloadTableView()
        }
    }
    
    var userRepoModel: [UserRepoModel]? = [UserRepoModel](){
        didSet{
            delegate?.reloadTableView()
        }
    }
    
    // MARK: Init function
    
    init(fetchAPI: APIManager = APIFetcher()){
        self.fetchAPI = fetchAPI
//        self.userName = username
//        self.delegate?.callLoader()
//        getUser()
//        getUserRepo()
    }
    
    // MARK: Function to fetch user data
    
    func getUser(user: String){
        fetchAPI.getUser(user: user){ status, result, error in
            guard status == true else{
                self.delegate?.userCantBeFetched()
                print(String(describing: error))
                return
            }
            self.userModel = result
        }
    }
    
    // MARK: Function to fetch user repo data
    
    func getUserRepo(user: String){
        fetchAPI.getUserRepo(user: user, completionHandler: { status, result, error in
            guard status == true, error == nil else{
                self.delegate?.repoDataCantBeFetched()
                print(String(describing: error))
                return
            }
            guard let result = result else {
                return
            }
            self.userRepoModel = result
        })
    }
}
