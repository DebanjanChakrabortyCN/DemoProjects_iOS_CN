//
//  ConnectionManager+FetchNews.swift
//  TestAlamofire
//
//  Created by CN320 on 4/27/17.
//  Copyright © 2017 CN320. All rights reserved.
//

import Foundation

extension ConnectionManager {
    
    class func fetchNews(completion: @escaping (_ result: Any?, _ error : Error?) -> Void) ->Void{
        
        let apiKey : String = "07de3d4786f744fa895838f6d4b9240f"
        let urlString : String = "https://newsapi.org/v1/articles?source=google-news&sortBy=top&apiKey=" + apiKey
        
        
        self.fetchJson(urlString: urlString) { (data, er) in
            
            var fetchedData : Array<Any>?
            
            if (data != nil)
            {
                let retrivedData = data as? Dictionary<String,Any>
                
                fetchedData = retrivedData?["articles"] as? Array
            }
            
            completion(fetchedData,er)
        }
    }
}
