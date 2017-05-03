//
//  Strings+CustomFunctions.swift
//  TestAlamofire
//
//  Created by CN320 on 4/27/17.
//  Copyright © 2017 CN320. All rights reserved.
//

import Foundation
extension String {
    
    func getLength() -> Int{
        return self.characters.count;
    }
    
    func getFullyTrimmedString() -> String{
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func getFullyTrimmedStringLength() -> Int{
        return self.getFullyTrimmedString().getLength()
    }
    
    func shouldNotContainAnyWhiteSpaces() -> Bool{
        
        guard (self.getFullyTrimmedStringLength() == self.getLength()) else {
            return false
        }
        return true
    }
    
    func checkURL() -> Bool {
        guard (self.getFullyTrimmedStringLength()) > 0 else{
            return  false
        }
        
        let regexStr = "^http(?:s)?://(?:w{3}\\.)?(?!w{3}\\.)(?:[\\p{L}a-zA-Z0-9\\-]+\\.){1,}(?:[\\p{L}a-zA-Z]{2,})/(?:\\S*)?$"
        
        return self.regexTest(regexString: regexStr)
    }
    
    func checkValidEmail() -> Bool{
        
        guard (self.getFullyTrimmedStringLength()) > 0 else {
            return  false
        }
        
        let regex1 = "\\A[a-z0-9]+([-._][a-z0-9]+)*@([a-z0-9]+(-[a-z0-9]+)*\\.)+[a-z]{2,4}\\z"
        let regex2 = "^(?=.{1,64}@.{4,64}$)(?=.{6,100}$).*"
        
        
        let regexTest1 : Bool = self.regexTest(regexString: regex1)
        
        
        if (regexTest1)
        {
            let regexTest2 : Bool = self.regexTest(regexString: regex2)
            
            return regexTest2
        }
        else
        {
            return regexTest1
        }
    }
    
    func regexTest(regexString : String?)->Bool
    {
        let urlTest = NSPredicate(format: "SELF MATCHES %@", regexString!)
        
        return urlTest.evaluate(with: self)
    }
}
