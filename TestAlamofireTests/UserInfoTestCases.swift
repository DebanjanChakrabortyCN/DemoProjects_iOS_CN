//
//  UserInfoTestCases.swift
//  TestAlamofire
//
//  Created by CN320 on 5/3/17.
//  Copyright © 2017 CN320. All rights reserved.
//

import XCTest

class UserInfoTestCases: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testUserInfoWithNoData(){
        
        let dataObj : LoginUserInfo = LoginUserInfo.init(userName: nil, passWord: nil)
        
        let isCorrect = dataObj.validate()
        
        XCTAssertFalse(isCorrect,"This should be false")
        
    }
    
    func testUserForInvalidEmail(){
        
        let dataObj : LoginUserInfo = LoginUserInfo.init(userName: nil, passWord: "123456", email: "d@@dddddddd.co.in")
        
        var isCorrect = dataObj.validate()
        XCTAssertFalse(isCorrect,"This should be false")
        
        dataObj.email = "d@ d.co.in"
        isCorrect = dataObj.validate()
        XCTAssertFalse(isCorrect,"This should be false")
        
        
        dataObj.email = "   d@d.co.in"
        isCorrect = dataObj.validate()
        XCTAssertFalse(isCorrect, "This should be false")
        
        
        dataObj.email = "d@d .co.in"
        isCorrect = dataObj.validate()
        XCTAssertFalse(isCorrect, "This should be false")
        
        
        dataObj.email = "d@#$%^.co.in"
        isCorrect = dataObj.validate()
        XCTAssertFalse(isCorrect, "This should be false")
        
        
        dataObj.email = "d@#$%^55.co.in"
        isCorrect = dataObj.validate()
        XCTAssertFalse(isCorrect, "This should be false")
        
        
        dataObj.email = "d@#$%^55.com.au"
        isCorrect = dataObj.validate()
        XCTAssertFalse(isCorrect, "This should be false")
    }
    
}
