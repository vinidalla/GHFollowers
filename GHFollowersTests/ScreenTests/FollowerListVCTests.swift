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
  
  override func setUp() {
    super.setUp()
    sut = FollowerListVC(username: "testuser")
    sut.loadViewIfNeeded()
  }
  
  override func tearDown() {
    super.tearDown()
    sut = nil
  }
  
  func testInitializationUserNameAndTitleEnteredCorrectly() {
    XCTAssertEqual(sut.username, "testuser")
    XCTAssertEqual(sut.title, "testuser")
  }
  
  func testIfCollectionViewAndDataSourceNotNil() {
    XCTAssertNotNil(sut.collectionView)
    XCTAssertNotNil(sut.dataSource)
  }
}
