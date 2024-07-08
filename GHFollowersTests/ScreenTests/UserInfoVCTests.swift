//
//  UserInfoVCTests.swift
//  GHFollowersTests
//
//  Created by Vinícius Dalla Vechia on 07/07/24.
//

import XCTest
@testable import GHFollowers

final class UserInfoVCTests: XCTestCase {
  
  var sut: UserInfoVC!
  
  override func setUp() {
    super.setUp()
    sut = UserInfoVC()
    sut.loadViewIfNeeded()
    
  }
  
  override func tearDown() {
    super.tearDown()
    sut = nil
  }
}
