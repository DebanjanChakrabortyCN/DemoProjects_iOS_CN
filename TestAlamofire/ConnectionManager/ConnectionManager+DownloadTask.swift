//
//  ConnectionManager+DownloadTask.swift
//  TestAlamofire
//
//  Created by CN320 on 5/2/17.
//  Copyright © 2017 CN320. All rights reserved.
//

import Foundation
import Alamofire

extension ConnectionManager {
    
    class func downloadFile(urlString : String? ,fileName: String?, downloadFilePath:String?, completion: @escaping (_ result: Any?, _ error : Error?) -> Void)
    {
        
        
        guard self.validateURL(urlString: urlString) else {
            completion(nil, NSError(domain: "Invalid url String", code: 0, userInfo: nil))
            
            return
        }
        
        
        let _ = self.getDownloadTask(urlString : urlString! ,
                                     fileName: fileName,
                                     downloadFilePath:downloadFilePath,
                                     methodType : .get,
                                     parameters:nil,
                                     headerInfo:nil,
                                     shouldStartImmediately : true,
                                     progress: nil){ (data, er) in
                                        
                                        completion(data,er)
        }
    }
    
    class func getDownloadTask(urlString : String ,
                               fileName: String?,
                               downloadFilePath:String?,
                               methodType : HTTPMethod?,
                               parameters:Dictionary<String,Any>?,
                               headerInfo:HTTPHeaders?,
                               shouldStartImmediately : Bool,
                               progress: ((_ downloadProgress : Progress?)->Void)? ,
                               completion: @escaping (_ result: Any?, _ error : Error?) -> Void) ->DownloadRequest?
    {
        
        let destination = ConnectionManager.getDestination(urlString : urlString,
                                                           fileName : fileName,
                                                           downloadFilePath :downloadFilePath)
        
        var downloadRequest : DownloadRequest?
        let mType:HTTPMethod = methodType ?? .get
        
        downloadRequest = Alamofire.download(
            urlString,
            method: mType,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: nil,
            to: destination)
            .downloadProgress(closure: { (progress) in
                
                // Progress Completion block
                
                DispatchQueue.main.async {
                    print (progress.totalUnitCount)
                    
                    print (progress.completedUnitCount)
                }
                
                
            }).response(completionHandler: { (DefaultDownloadResponse) in
                
                completion(DefaultDownloadResponse.destinationURL,DefaultDownloadResponse.error)
            })
        
        if(shouldStartImmediately)
        {
            downloadRequest?.resume()
        }
        
        return downloadRequest
    }
    
    class func getDestination(urlString : String ,
                              fileName: String?,
                              downloadFilePath:String?) -> DownloadRequest.DownloadFileDestination
    {
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            
            let pathComponent : String
            
            var downloadPath : URL?
            
            if(fileName == nil || fileName?.getFullyTrimmedStringLength() == 0)
            {
                let date = NSDate()
                
                let filePathExtension = (urlString as NSString).pathExtension
                
                var timeIntervalString = String(format:"%f", date.timeIntervalSince1970)
                
                timeIntervalString = timeIntervalString.replacingOccurrences(of: ".", with: "")
                
                pathComponent = "File_Downloaded_T" + timeIntervalString + "." + filePathExtension
            }
            else
            {
                pathComponent = fileName!
            }
            
            if(downloadFilePath == nil || downloadFilePath?.getFullyTrimmedStringLength() == 0)
            {
                downloadPath = CustomFileManager.downloadDataFolderPath()
            }
            else
            {
                downloadPath = CustomFileManager.downloadDataFolderPath(subDir: downloadFilePath!)
            }
            
            
            let filePathURL = downloadPath?.appendingPathComponent(pathComponent)
            
            return (filePathURL!, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        return destination
    }
}
