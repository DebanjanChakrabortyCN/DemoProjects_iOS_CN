//
//  UserInfo.swift
//  TestAlamofire
//
//  Created by CN320 on 5/3/17.
//  Copyright © 2017 CN320. All rights reserved.
//

import Foundation

class LoginUserInfo : NSObject {
    
    private var isUserNameSet : Bool = false
    private var isPasswordSet : Bool = false
    private var isEmailSet : Bool = false
    
    var username : String? = nil { // The purpose of writing didSet is to initialise the corresponding   Bool so that during validation, we get bypass unnecessary validations
        didSet{
            self.isUserNameSet = (self.username != nil)
        }
    }
    var password : String? = nil {
        didSet{
            self.isPasswordSet = (self.password != nil)
        }
    }
    var email : String? = nil{
        didSet{
            self.isEmailSet = (self.email != nil)
        }
    }
    
    //MARK: - INIT_METHODS
    private override init() {
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(userName : String? , passWord : String?) {
        self.init()
        
        self.setUserName(username: username) /* To invoke the didSet method of the property, one has to write a custom function (such as setUserName in this case)
            
                direct initialisation doesnot call didSet method */
        
        self.setPassword(password: password)
    }
    
    convenience init(userName : String? , passWord : String?, email: String?) {
        self.init()
        
        self.setUserName(username: userName)
        
        self.setPassword(password: passWord)
        
        self.setEmail(email: email)
       
    }
    //MARK:- CUSTOM_SETTERS
    func setUserName(username: String?) {
        self.username = username
    }
    
    func setPassword(password : String?)
    {
        self.password = password
    }
    
    func setEmail(email : String?)
    {
        self.email = email
    }
    
    //MARK: - VALIDATE_METHODS
    func validate()->Bool{
        
        // This ensures that an empty LoginUserInfo object will give you false in validation in the very first step
        
        
        guard ((self.isEmailSet == true || self.isUserNameSet == true) && self.isPasswordSet == true) else{
            return  false
        }
        
        if(self.isEmailSet)
        {
            guard self.email?.checkValidEmail() == true else {
                return false
            }
        }
        
        if(self.isUserNameSet)
        {
            guard self.validateUserName() == true else {
                return false
            }
        }
        
        
        if(self.isPasswordSet)
        {
            guard self.validatePassword() == true else {
                return false
            }
        }
        
        return true
    }
    
    private func validatePassword() -> Bool
    {
        return (self.password != nil && (self.password?.getFullyTrimmedStringLength())! > 0 && self.password?.shouldNotContainAnyWhiteSpaces() == true)
    }
    
    private func validateUserName() -> Bool{
        return self.username != nil && self.username?.getFullyTrimmedStringLength() != 0
    }
    
}
