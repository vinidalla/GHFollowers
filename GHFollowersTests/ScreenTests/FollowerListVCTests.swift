//
//  FollowerListVCTests.swift
//  GHFollowersTests
//
//  Created by Vinícius Dalla Vechia on 07/07/24.
//

import XCTest
@testable import GHFollowers

final class FollowerListVCTests: XCTestCase {
  
  var sut: FollowerListVC!

  override func setUpWithError() throws {
    sut = FollowerListVC(username: "testuser")
    sut.loadViewIfNeeded()
  }

  override func tearDownWithError() throws {
    sut = nil
  }
  
  func testInitializationUserNameEntered() {
      XCTAssertEqual(sut.username, "testuser")
      XCTAssertEqual(sut.title, "testuser")
      XCTAssertNotNil(sut.collectionView)
      XCTAssertNotNil(sut.dataSource)
  }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
