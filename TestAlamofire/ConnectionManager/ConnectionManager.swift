//
//  ConnectionManager.swift
//  TestAlamofire
//
//  Created by CN320 on 4/19/17.
//  Copyright © 2017 CN320. All rights reserved.
//

import UIKit
import Alamofire

class ConnectionManager: NSObject {
    
    private override init() {
        
    }

    
    class func fetchJson(urlString : String? , completion: @escaping (_ result: Any?, _ error : Error?) -> Void)
    {
        
        guard self.validateURL(urlString: urlString) else {
            completion(nil, NSError(domain: "Invalid url String", code: 0, userInfo: nil))
            
            return
        }
        
        // Add further url verification codes here
        
        let _ =  self.fetchDataRequest(urlString : urlString!, methodType:.get , parameters:nil,headerInfo:nil,shouldStartImmediately:true){ (data, er) in
            
            completion(data,er)
        }
    }
    
    //MARK:- JSON_DATA_TASK url
    class func fetchDataRequest(urlString : String,
                                methodType : HTTPMethod?,
                                parameters:Dictionary<String,Any>?,
                                headerInfo:HTTPHeaders?,
                                shouldStartImmediately : Bool,
                                completion: @escaping (_ result: Any?, _ error : Error?) -> Void) -> DataRequest?
    {
        
        let mType:HTTPMethod = methodType ?? .get
        
        let dataReq : DataRequest = Alamofire.request(urlString,
                                        method: mType,
                                        parameters: parameters,
                                        encoding: JSONEncoding.default,
                                        headers: headerInfo)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                
                switch response.result {
                case .success:
                    
                    if let JSON = response.result.value {
                        
                        let jsonResult : Dictionary = JSON as! Dictionary<String, AnyObject>
                        completion(jsonResult, nil)
                    }
                    
                case .failure(let error):
                    completion(nil, error)
                }
        }
        
        if(shouldStartImmediately)
        {
            dataReq.resume()
        }
        
        return dataReq
        
    }
    
    //MARK:- FILE_DOWNLOAD_TASK
   
    
    
    // MARK:- SESSIONS
    internal class func session()->URLSession{
        
        return Alamofire.SessionManager.default.session
    }
    
    class func initialiseSession()->Void{
        Alamofire.SessionManager.default.startRequestsImmediately = false
    }
    
    //MARK:- Extras
    class func validateURL(urlString : String?) -> Bool
    {
        // Add further url verification codes here
        
        guard urlString != nil && (urlString?.checkURL())! else {
            
            return false
        }
        return true
    }
}

