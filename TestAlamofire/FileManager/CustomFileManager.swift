//
//  FileManager.swift
//  TestAlamofire
//
//  Created by CN320 on 4/27/17.
//  Copyright © 2017 CN320. All rights reserved.
//

import Foundation

class CustomFileManager{
    
    
    private class func createDir(dirName: String)->URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let dataPath = documentsDirectory.appendingPathComponent(dirName)
        
        do {
            try FileManager.default.createDirectory(atPath: dataPath.absoluteString, withIntermediateDirectories: false, attributes: nil)
        } catch let error as NSError {
            print("Error creating directory: \(error.localizedDescription)")
        }
        
        return dataPath
    }
    
    static func downloadImageFolderPath()->URL {
    
        return CustomFileManager.createDir(dirName: "Downloaded_Image_Folder")
    }
}
