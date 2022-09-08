//
//  ContributorsViewModelTesting.swift
//  GithubViewer V 2.0Tests
//
//  Created by Vishrut tewatia on 11/08/22.
//

import XCTest
@testable import GithubViewer_V_2_0

class ContributorsViewModelTesting: XCTestCase, ContributorsViewModelDelegate {
    
    var contributorsViewModel: ContributorsViewModel?
    var expectation: XCTestExpectation?

    override func setUp() {
        super.setUp()
        expectation = nil
        let fetchAPI = MockAllData()
        contributorsViewModel = ContributorsViewModel(fetchAPI: fetchAPI)
        contributorsViewModel?.delegate = self
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        super.tearDown()
        contributorsViewModel = nil
        expectation = nil
    }
    
    func testCorrectContributors() {
        expectation = self.expectation(description: "Fetching correct contributors list")
        contributorsViewModel?.getContributors(user: "CorrectContributors")
        waitForExpectations(timeout: 5)
    }
    
    func testIncorrectContributors() {
        expectation = self.expectation(description: "Fetching incorrect contributors list")
        contributorsViewModel?.getContributors(user: "IncorrectContributors")
        waitForExpectations(timeout: 5)
    }
    
    func reloadContributorsTableView() {
//        XCTAssertNotNil(contributorsViewModel?.contributorsModel)
        // or can use
        XCTAssertTrue(((contributorsViewModel?.contributorsModel.isEmpty) == false) ) // isEmpty is significantly faster because it doesn't traverse all of the elements to take a count and then check if it equals zero.. isEmpty just checks for the first item and knows if its empty or not.
        expectation?.fulfill()
    }

    func couldntFetchContributors() {
        XCTAssertTrue(((contributorsViewModel?.contributorsModel.isEmpty) == true) )
        expectation?.fulfill()
    }
    
}
