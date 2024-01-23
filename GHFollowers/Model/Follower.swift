//
//  Follower.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 10/01/24.
//

import Foundation

struct Follower: Codable, Hashable {
  var login: String
  var avatarUrl: String
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(login)
  }
}
