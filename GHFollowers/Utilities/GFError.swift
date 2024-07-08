//
//  GFError.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 14/01/24.
//

enum GFError: String, Error {
  
  case invalidUserName = "This username created an invalid request. Please try again."
  case unableToComplete = "Unable to complete request, please check your internet connection."
  case invalidResponse = "Invalid response from the server. Please try again."
  case invalidData = "The data received from the server was invalid. Please try again."
  case unableToFavorite = "There was an error favoriting this user. Please try again."
  case alreadyInFavorites = "You've already favorited this user."
}
