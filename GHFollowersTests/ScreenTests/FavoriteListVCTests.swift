//
//  FavoriteListVCTests.swift
//  GHFollowersTests
//
//  Created by Vinícius Dalla Vechia on 07/07/24.
//

import XCTest
@testable import GHFollowers

final class FavoriteListVCTests: XCTestCase {
  
  let mockFavorites = [Follower(login: "user1",
                                avatarUrl: "avatarUrl1"),
                       Follower(login: "user2",
                                avatarUrl: "avatarUrl2")]
  var sut: FavoriteListVC!
  
  override func setUp() {
    super.setUp()
    sut = FavoriteListVC()
    sut.loadViewIfNeeded()
    
  }
  
  override func tearDown() {
    super.tearDown()
    sut = nil
  }
  
  func testViewControllerWhenViewDidLoadTitleShouldBeFavorites() {
    sut.viewDidLoad()
    XCTAssertEqual(sut.title, GeneralStrings.favorites)
  }
  
  func testGetFavoritesWhenRetrievingFavoritesShouldUpdateUI() {
      sut.updateUI(with: mockFavorites)
      XCTAssertEqual(sut.favorites.count, mockFavorites.count)
  }
  
  func testTableViewWhenNumberOfRowsInSectionShouldReturnCorrectCount() {
      sut.updateUI(with: mockFavorites)
      let rows = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
      XCTAssertEqual(rows, mockFavorites.count)
  }
}
