//
//  Fetch User Test for Login.swift
//  GithubViewer V 2.0Tests
//
//  Created by Vishrut tewatia on 09/08/22.
//

import XCTest
@testable import GithubViewer_V_2_0

class FetchUserTestForLogin: XCTestCase {

    func testCorrectUsernameForLogin() {
        let user = "vipinhelloindia"
        let APIFetch = APIFetcher()
        let expectation = self.expectation(description: "Correct Username For Login ")
        
        APIFetch.getUser(user: user) { status, result, error in
            XCTAssertTrue(status)
            XCTAssertNotNil(result)
            XCTAssertNil(error)
            XCTAssertNil(result?.message)
            XCTAssertEqual(user, result?.login)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
    }
    
    func testIncorrectUsernameForLogin() {
        let user = "akdjkasjkkdal"
        let APIFetch = APIFetcher()
        let expectation = self.expectation(description: "Incorrect Username For Login")
        
        APIFetch.getUser(user: user) { status, result, error in
            XCTAssertFalse(status)
            XCTAssertNotNil(result)
            XCTAssertNil(error)
            XCTAssertEqual("Not Found", result?.message)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
    }
}

class FetchUserRepoforUser: XCTestCase {

    func testCorrectRepoForUser() {
        let user = "vipinhelloindia"
        let APIFetch = APIFetcher()
        let expectation = self.expectation(description: "Correct User Repo for the User ")
        
        APIFetch.getUserRepo(user: user) { status, result, error in
            XCTAssertTrue(status)
            XCTAssertNotNil(result)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
    }
    
    func testIncorrectUsernameForLogin() {
        let user = "akdjkasjkkdal"
        let APIFetch = APIFetcher()
        let expectation = self.expectation(description: "Incorrect User Repo for Incorrect Username")
        
        APIFetch.getUserRepo(user: user) { status, result, error in
            XCTAssertFalse(status)
            XCTAssertNil(result)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
    }
}

class FetchContributorsforRepo: XCTestCase {

    func testCorrectContributorsForRepo() {
        let fullname = "vipinhelloindia/ActionBarSherlock"
        let APIFetch = APIFetcher()
        let expectation = self.expectation(description: "Correct Contributors for repo ")
        
        APIFetch.getContributors(user: fullname) { status, result, error in
            XCTAssertTrue(status)
            XCTAssertNotNil(result)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
    }
    
    func testIncorrectContributorsForRepo() {
        let user = "abcd/name"
        let APIFetch = APIFetcher()
        let expectation = self.expectation(description: "Incorrect Contributors for repo")
        
        APIFetch.getContributors(user: user) { status, result, error in
            XCTAssertFalse(status)
            XCTAssertNil(result)
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
    }
}
