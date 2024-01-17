//
//  Constants.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 14/01/24.
//

import UIKit

enum SFSymbols {
  static let location: String = "mappin.and.ellipse"
  static let repos: String = "folder"
  static let gists: String = "text.alignleft"
  static let followers: String = "heart"
  static let following: String = "person.2"
}

enum Images {
  static let ghLogo = UIImage(named: "gh-logo")
  static let placeholderImage = UIImage(named: "avatar-placeholder")
  static let emptyStateLogo = UIImage(named: "empty-state-logo")
}

enum GeneralStrings {
  static let getFollowersTitle: String = "Get Followers"
  static let emptyUserName: String = "Empty Username"
  static let pleaseEnterUserName: String = "Please enter a username. We need to know who to look for 😃."
  static let ok: String = "Ok"
  static let enterUsername: String = "Enter a username"
  static let somethingWentWrong: String = "Something went wrong"
  static let invalidUrl: String = "Invalid URL"
  static let invalidAttachedUrl: String = "The url attached to this user is invalid."
  static let noFollowers: String = "No followers"
  static let userHasNoFollowers: String = "This user has no followers 😔"
  static let search: String = "Search"
  static let favorites: String = "Favorites"
  static let gitHubProfile: String = "GitHub Profile"
  static let gitHubFollowers: String = "GitHub Followers"
  static let publicRepos: String = "Public Repos"
  static let publicGists: String = "Public Gists"
  static let followers: String = "Followers"
  static let following: String = "Following"
  static let unableToRemove: String = "Unable to remove"
  static let searchForUsername: String = "Search for a username"
  static let success: String = "Success!"
  static let successfullyFavoriteUser = "You have successfully favorited this user."
  static let nice: String = "Nice!"
}
