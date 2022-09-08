//
//  MockDataUtility.swift
//  GithubViewer V 2.0Tests
//
//  Created by Vishrut tewatia on 16/08/22.
//

import Foundation

class GetLocalJSON {
    
    static func getJsonData(fileName: String, completionHandler: @escaping (Data?, String?) -> Void){
        guard let JSONpath = Bundle.main.path(forResource: fileName, ofType: "json") else{
            completionHandler(nil, "No file with name \(fileName).json")
            return
        }
        
        do{
            let url = URL(fileURLWithPath: JSONpath)
            let jsonData = try Data(contentsOf: url)
            completionHandler(jsonData, nil)
        }
        catch{
            completionHandler(nil, String(describing: error.localizedDescription))
        }
    }
}
