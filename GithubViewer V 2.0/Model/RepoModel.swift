//
//  RepoModel.swift
//  GithubViewer V 2.0
//
//  Created by Vishrut tewatia on 01/08/22.
//

import Foundation

// MARK: User Repositories Model

struct UserRepoModel: Decodable {
    let name: String?
    let visibility: String?
    let description: String?
    let language: String?
    let forks: Int?
    let stargazers_count: Int?
    let updated_at: String?
    let topics: [String]?
    let full_name: String?
//    let message: String?
}
