//
//  Strings+CustomFunctions.swift
//  TestAlamofire
//
//  Created by CN320 on 4/27/17.
//  Copyright © 2017 CN320. All rights reserved.
//

import Foundation
extension String {
    
    func getFullyTrimmedString()->String{
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func getFullyTrimmedStringLength()->Int{
        return self.getFullyTrimmedString().characters.count
    }
    
    func checkURL() -> Bool {
        guard (self.getFullyTrimmedStringLength()) > 0 else{
            return  false
        }
        
        let urlRegEx = "^http(?:s)?://(?:w{3}\\.)?(?!w{3}\\.)(?:[\\p{L}a-zA-Z0-9\\-]+\\.){1,}(?:[\\p{L}a-zA-Z]{2,})/(?:\\S*)?$"
        let urlTest = NSPredicate(format: "SELF MATCHES %@", urlRegEx)
        
        return urlTest.evaluate(with: self)
    }
}
