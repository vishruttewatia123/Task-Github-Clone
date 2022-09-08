//
//  GithubViewer_V_2_0Tests.swift
//  GithubViewer V 2.0Tests
//
//  Created by Vishrut tewatia on 01/08/22.
//

import XCTest
@testable import GithubViewer_V_2_0

class UtilitiesTest: XCTestCase {
    
    var dateUtility: TimeChanger?
    
    override func setUp() {
        super.setUp()
        let dateFormatter = DateFormatter() // ye ni lete to usko format hi ni pta chalta
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let date = dateFormatter.date(from: "2022-08-17T07:25:11Z")
        dateUtility = TimeChanger(date: date ?? Date())
    }
    
    override func tearDown() {
        dateUtility = nil
    }

    func testAbbreviationsUtility() {
        
        let result1 = UpdateCount.roundedWithAbbreviations(10000)
        XCTAssertEqual(result1, "10K")
        
        let result2 = UpdateCount.roundedWithAbbreviations(5500000)
        XCTAssertEqual(result2, "5.5M")
        
        let result3 = UpdateCount.roundedWithAbbreviations(15000000000)
        XCTAssertEqual(result3, "15B")
    }
    
    func testUpdateDateUtility() {
        
        
        
        let result1 = dateUtility?.dateToTimeChanger(repoDate: "2022-08-12T14:32:36Z")
        XCTAssertEqual(result1, "last updated 4 days ago")
        
        let result2 = dateUtility?.dateToTimeChanger(repoDate: "2022-08-08T14:32:15Z")
        XCTAssertEqual(result2, "last updated a week ago")
        
        let result3 = dateUtility?.dateToTimeChanger(repoDate: "2022-03-03T12:32:36Z")
        XCTAssertEqual(result3, "last updated 5 months ago")
        
        let result4 = dateUtility?.dateToTimeChanger(repoDate: "2020-08-03T10:12:36Z")
        XCTAssertEqual(result4, "last updated 2 years ago")
        
        let result5 = dateUtility?.dateToTimeChanger(repoDate: "2022-08-17T04:34:15Z")
        XCTAssertEqual(result5, "last updated 2 hours ago")
                
        let result6 = dateUtility?.dateToTimeChanger(repoDate: "2022-08-17T07:20:00Z")
        XCTAssertEqual(result6, "last updated 5 minutes ago")
        
        let result7 = dateUtility?.dateToTimeChanger(repoDate: "2022-08-17T07:25:09Z")
        XCTAssertEqual(result7, "last updated 2 seconds ago")
    }

}
