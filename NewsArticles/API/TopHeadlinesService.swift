    //
    //  TopHeadlinesService.swift
    //

import Foundation

class TopHeadlinesService: NSObject {
    static let shared = TopHeadlinesService()
    private let api = NetworkHelper()
    
    func getTopHeadlines(handleNetworkError: ((NetworkError)->Void)?, success: @escaping (ArticlesResponse) -> Void) {
        let method = "/api/v4/top-headlines"
        
        var params = [String:String]()
        params["token"] = NetworkHelper.token
        params["lang"] = "uk"
        DispatchQueue.global(qos: .background).async {
            self.api.get(method: method, params: params, headers: nil) { res in
                do {
                    let results = try JSONDecoder().decode(ArticlesResponse.self, from: res as! Data)
                    DispatchQueue.main.async {
                        success(results)
                    }
                    
                } catch {
                    print(error)
                }
            }    error: {
                print("getTopHeadlines error")
            }
        }
    }
    
    func getSearchResults (_ params:[String:String] = [:], handleNetworkError: ((NetworkError)->Void)?, success: @escaping (ArticlesResponse) -> Void) {
        let method = "/api/v4/search"
        
        var params = params
        params["token"] = NetworkHelper.token
        params["lang"] = "uk"
        DispatchQueue.global(qos: .background).async {
            
            self.api.get(method: method, params: params, headers: nil) { res in
                do {
                    let results = try JSONDecoder().decode(ArticlesResponse.self, from: res as! Data)
                    DispatchQueue.main.async {
                        
                        success(results)
                    }
                } catch {
                    print(error)
                }
            }    error: {
                print("getTopHeadlines error")
            }
        }
    }
}
