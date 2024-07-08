//
//  FavoritesListVCTests.swift
//  GHFollowersTests
//
//  Created by Vinícius Dalla Vechia on 07/07/24.
//

import XCTest

final class FavoritesListVCTests: XCTestCase {

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

}
