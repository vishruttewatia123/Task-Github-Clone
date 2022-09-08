//
//  UserModel.swift
//  GithubViewer V 2.0
//
//  Created by Vishrut tewatia on 01/08/22.
//

import Foundation

// MARK: User Model

struct UserModel: Decodable{
    var name: String?
    var login : String?
    var id : Int?
    var avatar_url : String?
    var bio: String?
    var followers: Int?
    var public_repos: Int?
    var following: Int?
    var message: String?
}
