//
//  LoginViewModel.swift
//  GithubViewer V 2.0
//
//  Created by Vishrut tewatia on 02/08/22.
//

import Foundation

// MARK: Login View Model Protocol

protocol LoginViewModelDelegate: NSObject{
    func goToMainScreenController()
    func goToNotFoundController()
    func dataCantBeFetched()
}

// MARK: Login View Model Class

class LoginViewModel {
    var userModel: UserModel? // MARK: User model object
    let fetchAPI: APIManager // MARK: API protocol object
    weak var delegate: LoginViewModelDelegate? //memory leak ni hogi through weak
    
    // MARK: Init Function
    
    init(fetchAPI: APIManager = APIFetcher()){
        self.fetchAPI = fetchAPI
    }
    
    // MARK: Function to fetch user
    
    func getUser(user: String){
        fetchAPI.getUser(user: user, completionHandler: { status, result, error in
            if status == true {
                self.userModel = result
                self.delegate?.goToMainScreenController()
            }else if (result != nil){
                self.userModel = result
                self.delegate?.goToNotFoundController()
            } else{
                self.delegate?.dataCantBeFetched()
            }
        })
    }
    
}
