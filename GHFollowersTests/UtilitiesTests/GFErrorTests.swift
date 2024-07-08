//
//  GFErrorTests.swift
//  GHFollowersTests
//
//  Created by Vinícius Dalla Vechia on 08/07/24.
//

import XCTest
@testable import GHFollowers

final class GFErrorTests: XCTestCase {
  
  func testGFErrorRawValues() {
    XCTAssertEqual(GFError.invalidUserName.rawValue, "This username created an invalid request. Please try again.")
    XCTAssertEqual(GFError.unableToComplete.rawValue, "Unable to complete request, please check your internet connection.")
    XCTAssertEqual(GFError.invalidResponse.rawValue, "Invalid response from the server. Please try again.")
    XCTAssertEqual(GFError.invalidData.rawValue, "The data received from the server was invalid. Please try again.")
    XCTAssertEqual(GFError.unableToFavorite.rawValue, "There was an error favoriting this user. Please try again.")
    XCTAssertEqual(GFError.alreadyInFavorites.rawValue, "You've already favorited this user.")
  }
}
