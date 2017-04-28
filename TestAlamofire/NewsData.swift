//
//  NewsData.swift
//  TestAlamofire
//
//  Created by CN320 on 4/19/17.
//  Copyright © 2017 CN320. All rights reserved.
//

import UIKit

class NewsData: NSObject {

    public var newsTitle : String?
    
    public var newsAuthor : String?
    
    public var newsDescription : String?
    
    public var newsPublishDate : Date?
    
    public var imageUrl : String?
    
    public var imageName : String?
    
    
    class func prepareNewsDataArray(rawDataArrray : Array<Any>?) -> Array<Any>?
    {
        
        guard rawDataArrray != nil else { return nil }
        
        guard rawDataArrray?.count != 0 else { return nil }
        
        var newsDataArray : NSMutableArray?
        
        for obj in rawDataArrray!
        {
            if obj is Dictionary<String, Any>
            {
                let newsData : NewsData = NewsData.init(dataDictionary: (obj as? Dictionary<String,Any>)!)
                
                if newsDataArray == nil
                {
                    newsDataArray = NSMutableArray.init()
                }
                
                newsDataArray?.add(newsData)
            }
            
        }
        
        return newsDataArray as? Array<Any>
    }
    
    
    
    private override init() {
        super.init()
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal convenience init(dataDictionary : Dictionary<String, Any>) {
        
        self.init()
        self.newsTitle = dataDictionary["title"] as? String
        self.newsAuthor = "Published by NewsGroup"
        
        let dataString = dataDictionary["author"] as? String
        
        if(dataString != nil && (dataString?.getFullyTrimmedStringLength())! > 0)
        {
            self.newsAuthor = dataString
        }
        
        
        self.newsDescription = dataDictionary["description"] as? String
        self.prepareFetchDate(publishedDate: dataDictionary["publishedAt"] as? String)
        
        self.imageUrl = dataDictionary["urlToImage"] as? String
        
    }
    
    private func prepareFetchDate(publishedDate : String?) -> Void
    {
        guard publishedDate != nil else { return }
        
        let stringLength = publishedDate!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).characters.count
        
        guard stringLength > 0 else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ssz" //Your date format
        self.newsPublishDate = dateFormatter.date(from: publishedDate!)
    }
}
