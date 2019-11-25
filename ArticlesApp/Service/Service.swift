//
//  Service.swift
//  CollectionViewDemo3
//
//  Created by camilo andres ibarra yepes on 22/11/19.
//  Copyright © 2019 camilo andres ibarra yepes. All rights reserved.
//

import Foundation
import SwiftyJSON


class Service: NSObject {
    
    static let shared = Service()
    
    
    var loadPageSize = 100
    
    func fetchArticles(completion: @escaping ([Article]?, Error?) -> ()) {
        
        
        if Reachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
            
            let urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=ef97bc06e84041398839ca417f49d1c8&pageSize=\(loadPageSize)"
            
            guard let url = URL(string: urlString) else { return }
            URLSession.shared.dataTask(with: url) { (data, resp, err) in
                if let err = err {
                    completion(nil, err)
                    print("Failed to fetch articles:", err)
                    return
                }
                
                // check response
                guard let data = data else { return }
                
                do {
                    let resP = try JSONSerialization.jsonObject(with: data, options: .init()) as? [String: AnyObject]
                    let articlesResponse = resP?["articles"]
                    let jsonData = try JSONSerialization.data(withJSONObject: articlesResponse as Any, options: .prettyPrinted)
                    let articles = try JSONDecoder().decode([Article].self, from: jsonData)
                    
                    print("articlesType", type(of: articles))
                    
                    DispatchQueue.main.async {
                        completion(articles, nil)
                    }
                    
                    
                } catch(let error) {
                    print("err", error)
                    
                }
                
                }.resume()
            
        } else {
            print("Internet connection FAILED")

            let dataSaved = UserDefaults.standard.data(forKey: "articles")
            
            if(dataSaved != nil){
                print("dataSaved", dataSaved!)
                
                do{
                    let articlesSaved = try JSONDecoder().decode([Article].self, from: dataSaved!)
                    print("articlesSaved", articlesSaved)
                    print("articlesSaved", type(of: articlesSaved))
                    
                    DispatchQueue.main.async {
                        completion(articlesSaved, nil)
                    }
                    
                }catch { print("error 1", error )}

            }else{
                DispatchQueue.main.async {
                    completion(nil, nil)
                }
            }
            
        }
        
        
    }
}
