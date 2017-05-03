//
//  TestAlamofireTests.swift
//  TestAlamofireTests
//
//  Created by CN320 on 4/19/17.
//  Copyright © 2017 CN320. All rights reserved.
//

import XCTest
@testable import TestAlamofire

class TestAlamofireTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        ConnectionManager.initialiseSession()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testDataTaskFunction(){
        
        var promise :XCTestExpectation? = expectation(description: "Data Received properly")
        var resultCheck: Any?
        var responseError: Error?
        
        self.measure {
            ConnectionManager.fetchNews{ (resultData, error) in
                
                resultCheck = resultData
                responseError = error
                
                if(resultCheck != nil && responseError == nil)
                {
                    promise?.fulfill()
                    promise = nil
                }
            }
        }
        
        
        self.waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNil(responseError,"There is an error \(String(describing: responseError))")
        
        XCTAssertNotNil(resultCheck, "There is no data received")
    }
    
    func testDownloadFile(){
        
        var promise :XCTestExpectation? = expectation(description: "Data Received properly")
        var resultCheck: Any?
        var responseError: Error?
        
        ConnectionManager.downloadFile(urlString: "https://i2.cdn.cnn.com/cnnnext/dam/assets/170426173540-100-days-that-changed-america-image-1-super-tease.jpg", fileName: nil, downloadFilePath: nil) { (resultData, err) in
            
            resultCheck = resultData
            responseError = err
            
            if(resultCheck != nil && responseError == nil)
            {
                promise?.fulfill()
                promise = nil
            }
            
        }
        
        self.waitForExpectations(timeout: 5, handler: nil)
        
        print(resultCheck as Any)
    }
    
    func testImageDownloadWithFileName()
    {
        var promise :XCTestExpectation? = expectation(description: "Data Received properly")
        var resultCheck: Any?
        var responseError: Error?
        
        ConnectionManager.downloadFile(urlString: "https://i2.cdn.cnn.com/cnnnext/dam/assets/170426173540-100-days-that-changed-america-image-1-super-tease.jpg", fileName: "customImage.jpg", downloadFilePath: nil) { (resultData, err) in
            
            resultCheck = resultData
            responseError = err
            
            if(resultCheck != nil && responseError == nil)
            {
                promise?.fulfill()
                promise = nil
            }
            
        }
        
        self.waitForExpectations(timeout: 5, handler: nil)
        
        print(resultCheck as Any)
    }
    
    func testDownloadImageWithImageNameAndDownloadPath(){
        var promise :XCTestExpectation? = expectation(description: "Data Received properly")
        var resultCheck: Any?
        var responseError: Error?
        
        ConnectionManager.downloadFile(urlString: "https://i2.cdn.cnn.com/cnnnext/dam/assets/170426173540-100-days-that-changed-america-image-1-super-tease.jpg", fileName: "customImage.jpg", downloadFilePath: "ImgFolder/SubFolder") { (resultData, err) in
            
            resultCheck = resultData
            responseError = err
            
            if(resultCheck != nil && responseError == nil)
            {
                promise?.fulfill()
                promise = nil
            }
            
        }
        
        self.waitForExpectations(timeout: 5, handler: nil)
        
        print(resultCheck as Any)
    }
    
    func testDownloadPDF(){
        var promise :XCTestExpectation? = expectation(description: "Data Received properly")
        var resultCheck: Any?
        var responseError: Error?
        
        ConnectionManager.downloadFile(urlString: "https://52wdeibt3ivmcapq.onion.link/data/fiction/Rushdie/Satanic-Verses.pdf", fileName: nil, downloadFilePath: nil) { (resultData, err) in
            
            resultCheck = resultData
            responseError = err
            
            if(resultCheck != nil && responseError == nil)
            {
                promise?.fulfill()
                promise = nil
            }
        }
        
        self.waitForExpectations(timeout: 50, handler: nil)
        
        XCTAssertNil(responseError,"There is an error \(String(describing: responseError))")
        
        XCTAssertNotNil(resultCheck, "There is no data received")
        
        print (resultCheck ?? "Kissu pelam na")
        
    }
    
}
