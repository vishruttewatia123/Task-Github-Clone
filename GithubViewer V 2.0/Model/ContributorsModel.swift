//
//  ContributorsModel.swift
//  GithubViewer V 2.0
//
//  Created by Vishrut tewatia on 01/08/22.
//

import Foundation

// MARK: Contriubutors Model

struct ContributorsModel: Decodable {
    let login: String
    let avatar_url: String?
    let contributions: Int?
//    let message: String?
}
