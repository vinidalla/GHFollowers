//
//  Follower.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 10/01/24.
//

import Foundation
//Hashable protocol supports hash function that can filter proporties combine them and represent with an int value
struct Follower: Codable, Hashable {
  var login: String
  var avatarUrl: String
}
