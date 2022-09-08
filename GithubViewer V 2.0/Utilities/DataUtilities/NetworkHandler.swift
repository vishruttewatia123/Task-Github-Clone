//
//  NetworkHandler.swift
//  GithubViewer V 2.0
//
//  Created by Vishrut tewatia on 17/08/22.
//

import Foundation

class APINetworkHandler {
    
    static func currentAPIContract (_ url: String, _ completionhandler: @escaping (Data?, URLResponse?, Error?) ->  Void){
        let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            completionhandler(data,response,error)
        }
        task.resume()
    }
}
