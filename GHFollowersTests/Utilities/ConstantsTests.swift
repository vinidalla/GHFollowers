//
//  ConstantsTests.swift
//  GHFollowersTests
//
//  Created by Vinícius Dalla Vechia on 08/07/24.
//

import XCTest
@testable import GHFollowers

final class ConstantsTests: XCTestCase {
  
  func testSFSymbolsValues() {
    XCTAssertEqual(SFSymbols.repos, "folder")
    XCTAssertEqual(SFSymbols.followers, "heart")
    XCTAssertEqual(SFSymbols.following, "person.2")
    XCTAssertEqual(SFSymbols.gists, "text.alignleft")
    XCTAssertEqual(SFSymbols.location, "mappin.and.ellipse")
    XCTAssertEqual(SFSymbols.checkMarkOk, "checkmark.circle")
    XCTAssertEqual(SFSymbols.person, "person")
    XCTAssertEqual(SFSymbols.person3, "person.3")
  }
  
  func testImagesValues() {
    XCTAssertNotNil(Images.ghLogo)
    XCTAssertNotNil(Images.placeholder)
    XCTAssertNotNil(Images.emptyStateLogo)
  }
  
  func testGeneralStringsValues() {
    XCTAssertEqual(GeneralStrings.followers, "Followers")
    XCTAssertEqual(GeneralStrings.following, "Following")
    XCTAssertEqual(GeneralStrings.getFollowersTitle, "Get Followers")
    XCTAssertEqual(GeneralStrings.noFollowers, "No followers")
    XCTAssertEqual(GeneralStrings.notAvailable, "Not available")
    XCTAssertEqual(GeneralStrings.noLocationAvailable, "No location available")
    XCTAssertEqual(GeneralStrings.noBioAvailable, "No bio available")
    XCTAssertEqual(GeneralStrings.userHasNoFollowers, "This user has no followers 😔")
    XCTAssertEqual(GeneralStrings.gitHubFollowers, "GitHub Followers")
    XCTAssertEqual(GeneralStrings.emptyUserName, "Empty Username")
    XCTAssertEqual(GeneralStrings.enterUsername, "Enter a username")
    XCTAssertEqual(GeneralStrings.searchForUsername, "Search for a username")
    XCTAssertEqual(GeneralStrings.pleaseEnterUserName, "Please enter a username. We need to know who to look for 😃.")
    XCTAssertEqual(GeneralStrings.somethingWentWrong, "Something went wrong")
    XCTAssertEqual(GeneralStrings.unableToCompleteRequest, "Unable to complete request")
    XCTAssertEqual(GeneralStrings.invalidUrl, "Invalid URL")
    XCTAssertEqual(GeneralStrings.invalidAttachedUrl, "The url attached to this user is invalid.")
    XCTAssertEqual(GeneralStrings.unableToRemove, "Unable to remove")
    XCTAssertEqual(GeneralStrings.search, "Search")
    XCTAssertEqual(GeneralStrings.favorites, "Favorites")
    XCTAssertEqual(GeneralStrings.noFavoritesAddOne, "No favorites? \nAdd one on the follower screen.")
    XCTAssertEqual(GeneralStrings.gitHubProfile, "GitHub Profile")
    XCTAssertEqual(GeneralStrings.publicRepos, "Public Repos")
    XCTAssertEqual(GeneralStrings.publicGists, "Public Gists")
    XCTAssertEqual(GeneralStrings.success, "Success!")
    XCTAssertEqual(GeneralStrings.successfullyFavoriteUser, "You have successfully favorited this user.")
    XCTAssertEqual(GeneralStrings.nice, "Nice!")
    XCTAssertEqual(GeneralStrings.ok, "Ok")
  }
}
