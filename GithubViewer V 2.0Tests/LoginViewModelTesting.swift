//
//  LoginViewModelTesting.swift
//  GithubViewer V 2.0Tests
//
//  Created by Vishrut tewatia on 10/08/22.
//

import XCTest
@testable import GithubViewer_V_2_0

class LoginViewModelTesting: XCTestCase, LoginViewModelDelegate {

    var loginViewModel: LoginViewModel?
    var expectation: XCTestExpectation? // declaring the expectation
    
    override func setUp() {
        super.setUp()
        let fetchAPI = MockAllData() // MARK: Creating reference to mock data class
        expectation = nil
        loginViewModel = LoginViewModel(fetchAPI: fetchAPI) // MARK: Injecting the mock class to init of loginviewmodel
        loginViewModel?.delegate = self
        
    }
    
    override func tearDown() {
        super.tearDown()
        loginViewModel = nil
        expectation = nil
    }
    
    // MARK: Test for correct username
    
    func testUsernameIsCorrect() {
        expectation = self.expectation(description: "Fetching user with correct username")
        loginViewModel?.getUser(user: "CorrectUsername")
        waitForExpectations(timeout: 5)
    }
    
    // MARK: Test for incorrect username
    
    func testUsernameIsIncorrect() {
        expectation = self.expectation(description: "Fetching user with incorrect username")
        loginViewModel?.getUser(user: "UsernameNotFound")
        waitForExpectations(timeout: 5)
    }
    
    // MARK: Test for when data is umfetchable
    func testUserCantBeFetched() {
        expectation = self.expectation(description: "Fetching user with error in fetching")
        loginViewModel?.getUser(user: "DataUnfetchable")
        waitForExpectations(timeout: 5)
    }

    // MARK: Conforming to the protocols and writing test checks in it.
    
    func goToMainScreenController() {
        XCTAssertNotNil(loginViewModel?.userModel)
//        XCTAssertNotNil(loginViewModel?.userModel?.login)
        XCTAssertNil(loginViewModel?.userModel?.message)
        expectation?.fulfill()
    }
    
    func goToNotFoundController() {
        XCTAssertNotNil(loginViewModel?.userModel)
//        XCTAssertNil(loginViewModel?.userModel?.login)
        XCTAssertNotNil(loginViewModel?.userModel?.message)
        expectation?.fulfill()
    }
    
    func dataCantBeFetched() {
        XCTAssertNil(loginViewModel?.userModel)
        expectation?.fulfill()
    }

}
