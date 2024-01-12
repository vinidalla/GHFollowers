//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 11/01/24.
//

import Foundation
//GFError conforms to Error protocol, so we can use in the Result of our call
enum GFError: String, Error {
  case invalidUserName = "This username created an invalid request. Please try again."
  case unableToComplete = "Unable to complete request, please check your internet connection."
  case invalidResponse = "Invalid response from the server. Please try again."
  case invalidData = "The data received from the server was invalid. Please try again."
}
