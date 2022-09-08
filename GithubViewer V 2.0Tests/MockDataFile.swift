//
//  MockDataFile.swift
//  GithubViewer V 2.0Tests
//
//  Created by Vishrut tewatia on 10/08/22.
//

import Foundation
@testable import GithubViewer_V_2_0 // Since API manager protocol is in github module, we have to import it

// MARK: Mock data class

class MockAllData: APIManager {

//     MARK: Common function to get JSON data
    
//    func getJsonData(fileName: String, completionHandler: @escaping (Data?, String?) -> Void){
//        guard let JSONpath = Bundle.main.path(forResource: fileName, ofType: "json") else{
//            completionHandler(nil, "No file with name \(fileName).json")
//            return
//        }
//
//        do{
//            let url = URL(fileURLWithPath: JSONpath)
//            let jsonData = try Data(contentsOf: url)
//            completionHandler(jsonData, nil)
//        }
//        catch{
//            completionHandler(nil, String(describing: error.localizedDescription))
//        }
//    }
    
    func getUser(user: String, completionHandler: @escaping (Bool, UserModel?, String?) -> Void) {
        GetLocalJSON.getJsonData(fileName: user) { data, error in
            guard let data = data else{
                completionHandler(false, nil, String(describing: error))
                return
            }
    
            var result: UserModel?
            
            do{
                result = try JSONDecoder().decode(UserModel.self, from: data)
                if(result?.message == nil){
                    completionHandler(true, result, nil)
                } else {
                    completionHandler(false,result, nil)
                }
            } catch {
                completionHandler (false, nil, String(describing: error))
            }
        }
    }
    
    func getUserRepo(user: String, completionHandler: @escaping (Bool, [UserRepoModel]?, String?) -> Void) {
        GetLocalJSON.getJsonData(fileName: user) { data, error in
            guard let data = data else{
                completionHandler(false, nil, String(describing: error))
                return
            }
            var result: [UserRepoModel]?
            
            do{
                result = try JSONDecoder().decode([UserRepoModel].self, from: data)
                completionHandler(true, result, nil)
            } catch{
                completionHandler(false, nil, String(describing: error))
            }
        }
    }
    
    func getContributors(user: String, completionHandler: @escaping (Bool, [ContributorsModel]?, String?) -> Void) {
        GetLocalJSON.getJsonData(fileName: user) { data, error in
            guard let data = data else{
                completionHandler(false, nil, String(describing: error))
                return
            }

            var result: [ContributorsModel]?
            
            do{
                result = try JSONDecoder().decode([ContributorsModel].self, from: data)
                completionHandler(true, result, nil)
            } catch{
                completionHandler(false, nil, String(describing: error))
            }
        }
    }
    
    
}
