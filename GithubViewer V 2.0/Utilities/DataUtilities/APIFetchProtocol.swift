//
//  APIFetchProtocol.swift
//  GithubViewer V 2.0
//
//  Created by Vishrut tewatia on 01/08/22.
//

import Foundation

protocol APIManager {
    func getUser(user: String, completionHandler: @escaping (_ status : Bool, _ result: UserModel?, _ error: String?) -> Void)
    func getUserRepo(user: String, completionHandler: @escaping (_ status : Bool, _ result: [UserRepoModel]?, _ error: String?) -> Void)
    func getContributors(user: String, completionHandler: @escaping (_ status : Bool, _ result: [ContributorsModel]?, _ error: String?) -> Void)
}

class APIFetcher : APIManager {
    
    func getUser(user: String, completionHandler: @escaping (Bool, UserModel?, String?) -> Void) {
        let url = "https://api.github.com/users/" + user
        
        APINetworkHandler.currentAPIContract(url){ data, response, error in
            guard let data = data, error == nil else{
                completionHandler(false, nil, String(describing: error))
                print("data cant be fetched")
                return
            }
            //json type hai, directly uthao
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
        let url = "https://api.github.com/users/" + user + "/repos"
        
        APINetworkHandler.currentAPIContract(url){ data, response, error in
            guard let data = data, error == nil else{
                completionHandler(false, nil, String(describing: error))
                print("data cant be fetched")
                return
            }
            //json type hai, directly uthao
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
//        BASE_URL/repos/{user}/{repo}/contributors
        let url = "https://api.github.com/repos/" + user + "/contributors"
        
        APINetworkHandler.currentAPIContract(url){ data, response, error in
            guard let data = data, error == nil else{
                completionHandler(false, nil, String(describing: error))
                print("data cant be fetched")
                return
            }
            //json type hai, directly uthao
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
//    func  (url: String, completionhandler: @escaping (Data)->Void){
//
//        let _ = URLSession.shared.dataTask(with: URL(string: url)!){data,response,error  in
//            guard let data = data, error == nil else{
//                return
//            }
//            completionhandler(data)
//        }.resume()
//    }



//                    else if (result?.message?.contains("rate") == true) {
//                    guard let pathUrl = Bundle.main.url(forResource: "userapibackup", withExtension: "json") else {return}
//
//                    let url = URL(fileURLWithPath: pathUrl.path)
//                    do{
//                        let jsonData = try Data(contentsOf: url)
//                        //                    do{
//                        let jsonData = try Data(contentsOf: url)
//                        result = try JSONDecoder().decode(UserModel.self, from: jsonData)
//                        completionHandler(true,result,nil)
//                    } catch {
//                        completionHandler(false, nil, String(describing: error))
//                        print("error: \(error)") //this error is obtained from JSONdecoder
//                    }
