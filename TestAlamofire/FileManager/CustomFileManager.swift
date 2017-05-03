//
//  FileManager.swift
//  TestAlamofire
//
//  Created by CN320 on 4/27/17.
//  Copyright © 2017 CN320. All rights reserved.
//

import Foundation

class CustomFileManager{
    
    private static let downloadDir = "Downloaded_Data_Folder"
    
    private class func createDir(dirName: String)->URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let dataPath = documentsDirectory.appendingPathComponent(dirName)
        
        let manager = FileManager.default
        
        if(!manager.fileExists(atPath:dataPath.absoluteString))
        {
            do {
                try manager.createDirectory(atPath: dataPath.absoluteString, withIntermediateDirectories: false, attributes: nil)
            } catch let error as NSError {
                print("Error creating directory: \(error.localizedDescription)")
            }
        }

        return dataPath
    }
    
    
    
    class func downloadDataFolderPath()->URL {
    
        return CustomFileManager.createDir(dirName: downloadDir)
    }
    
    class func downloadDataFolderPath(subDir: String?)->URL
    {
        if(subDir != nil && (subDir?.getFullyTrimmedStringLength())! > 0)
        {
            let folderPath = downloadDir + "/" + subDir!
            
            return CustomFileManager.createDir(dirName: folderPath)
        }
        else
        {
            return self.downloadDataFolderPath()
        }
    }
}
