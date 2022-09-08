//
//  UserViewModelTesting.swift
//  GithubViewer V 2.0Tests
//
//  Created by Vishrut tewatia on 10/08/22.
//

import XCTest
@testable import GithubViewer_V_2_0

class UserViewModelUserTesting: XCTestCase, MainUserViewModelDelegate {
    
    
    var mainUserViewModel: MainUserViewModel?
    var expectation: XCTestExpectation?

    override func setUp() {
        super.setUp()
        let fetchAPI = MockAllData()
        expectation = nil
        mainUserViewModel = MainUserViewModel(fetchAPI: fetchAPI)
        mainUserViewModel?.delegate = self
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        super.tearDown()
        mainUserViewModel = nil
    }
    
    func testSuccessfulUserCheck() {
        expectation = self.expectation(description: "Fetching correct User")
        mainUserViewModel?.getUser(user: "CorrectUsername")
        waitForExpectations(timeout: 5)
    }
    
    func testUnsuccesfulUserCheck() {
        expectation = self.expectation(description: "Fetching failed for user")
        mainUserViewModel?.getUser(user: "DataUnfetchable")
        waitForExpectations(timeout: 5)
    }
    
    func updateMainScreenUI() {
        XCTAssertNotNil(mainUserViewModel?.userModel)
        XCTAssertNotNil(mainUserViewModel?.userModel?.login)
        XCTAssertEqual(mainUserViewModel?.userCount, [67,11,43])
        expectation?.fulfill()
    }
    
    func userCantBeFetched() {
        XCTAssertNil(mainUserViewModel?.userModel)
        XCTAssertTrue(mainUserViewModel?.userCount?.count == 0)
        expectation?.fulfill()
    }
    
    func reloadTableView() {}
    
    func repoDataCantBeFetched() {}
    
}

class UserViewModelRepoTesting: XCTestCase, MainUserViewModelDelegate {
    
    
    var mainUserViewModel: MainUserViewModel?
    var expectation: XCTestExpectation?

    override func setUp() {
        super.setUp()
        let fetchAPI = MockAllData()
        expectation = nil
        mainUserViewModel = MainUserViewModel(fetchAPI: fetchAPI)
        mainUserViewModel?.delegate = self
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        super.tearDown()
        mainUserViewModel = nil
        expectation = nil
    }
    
    func testSuccessfulUserRepoCheck() {
        expectation = self.expectation(description: "Fetching correct User Repository")
        mainUserViewModel?.getUserRepo(user: "CorrectUserRepo")
        waitForExpectations(timeout: 5)
    }
    
    func testUnsuccesfulUserRepoCheck() {
        expectation = self.expectation(description: "Fetching failed for User Repository")
        mainUserViewModel?.getUserRepo(user: "UserRepoUnfetchable")
        waitForExpectations(timeout: 5)
    }
    
    func updateMainScreenUI() {}
    
    func userCantBeFetched() {}
    
    func reloadTableView() {
//        XCTAssertNotNil(mainUserViewModel?.userRepoModel)
        XCTAssertTrue((mainUserViewModel?.userRepoModel?.isEmpty) == false)
        expectation?.fulfill()
    }
    
    func repoDataCantBeFetched() {
//        XCTAssertNil(mainUserViewModel?.userRepoModel) - our model is initialised to [], so not needed
        XCTAssertTrue((mainUserViewModel?.userRepoModel?.isEmpty) == true)
        expectation?.fulfill()
    }
    
}
