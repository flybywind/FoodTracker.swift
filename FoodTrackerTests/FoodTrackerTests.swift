//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by flybywind on 15/11/13.
//  Copyright © 2015年 flybywind. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMealInitialization() {
        let i = Meal(name: "hello", photo: nil, rating: 3)
        XCTAssertNotNil(i)
        let j = Meal(name: "", photo:nil, rating: 3)
        XCTAssertNil(j, "invalid meal should be nil!")
        
        let f = Meal(name: "hhh", photo: nil, rating: -2)
        XCTAssertNil(f)
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
