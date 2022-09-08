//
//  ContributorsViewModel.swift
//  GithubViewer V 2.0
//
//  Created by Vishrut tewatia on 03/08/22.
//

import Foundation

// MARK: Contributors View Model Protocol

protocol ContributorsViewModelDelegate: NSObject {
    func couldntFetchContributors()
    func reloadContributorsTableView()
}

let Default_Label2 = "Not provided"

// MARK: Contributors View Model Class

class ContributorsViewModel{
    let fetchAPI: APIManager // MARK: API protocol object
    weak var delegate: ContributorsViewModelDelegate?
    var repoName: String?
    
    var contributorsModel = [ContributorsModel](){
        didSet{
            delegate?.reloadContributorsTableView()
        }
    }
    
    // MARK: Init function
    
    init(fetchAPI: APIManager = APIFetcher()){
        self.fetchAPI = fetchAPI
//        self.repoName = reponame
//        getContributors()
    }
    
    // MARK: Function to fetch contributors data
    
    func getContributors(user: String){
        fetchAPI.getContributors(user: user, completionHandler: { status, result, error in
            guard status == true, error == nil else{
                self.delegate?.couldntFetchContributors()
                print(String(describing: error))
                return
            }
            guard let result = result else {
                return
            }
            self.contributorsModel = result
        })
    }
    
}
