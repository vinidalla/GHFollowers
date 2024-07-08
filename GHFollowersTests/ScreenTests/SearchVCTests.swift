//
//  SearchVCTests.swift
//  GHFollowersTests
//
//  Created by Vinícius Dalla Vechia on 07/07/24.
//

import XCTest
@testable import GHFollowers

final class SearchVCTests: XCTestCase {
  
  var sut: SearchVC!
  var navigationController: UINavigationController!
  
  override func setUp() {
    super.setUp()
    sut = SearchVC()
    sut.loadViewIfNeeded()
    navigationController = UINavigationController(rootViewController: sut)
  }
  
  override func tearDown() {
    super.tearDown()
    sut = nil
    navigationController = nil
  }
  
  func testViewDidLoadedElements() {
    XCTAssertNotNil(sut.logoImageView)
    XCTAssertNotNil(sut.usernameTextField)
    XCTAssertNotNil(sut.callToActionButton)
  }
  
  func testViewBackgroundColor() {
    XCTAssertEqual(sut.view.backgroundColor, UIColor.systemBackground)
  }
  
  func testIsUsernameEntered_WhenUsernameIsEmpty_ShouldReturnFalse() {
    sut.usernameTextField.text = ""
    XCTAssertFalse(sut.isUsernameEntered)
  }
  
  func testIsUsernameEntered_WhenUsernameIsNotEmpty_ShouldReturnTrue() {
    sut.usernameTextField.text = "someUsername"
    XCTAssertTrue(sut.isUsernameEntered)
  }
}
