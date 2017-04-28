//
//  ConnectionManager+CancelTask.swift
//  TestAlamofire
//
//  Created by CN320 on 4/27/17.
//  Copyright © 2017 CN320. All rights reserved.
//

import Foundation
import Alamofire

extension ConnectionManager {
    
    class func cancelTask(task : Request?)
    {
        guard task != nil else { return }
        
        let sessionTask :  URLSessionTask? = task?.task
        
        sessionTask?.cancel()
        
    }
    
    class func cancelAllTasks()->Void{
        
        self.session().getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach { $0.cancel() }
            uploadTasks.forEach { $0.cancel() }
            downloadTasks.forEach { $0.cancel() }
        }
    }
}
