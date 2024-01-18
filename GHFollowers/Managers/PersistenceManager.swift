//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 15/01/24.
//

import Foundation

enum PersistenceActionType {
  case add, remove
}

enum PersistenceManager {
  static private let defaults = UserDefaults.standard
  
  enum Keys {
    static let favorites = "favorites"
  }
  
  static func updateWith(favorite: Follower,
                         actionType: PersistenceActionType,
                         completionHandler: @escaping (GFError?) -> Void) {
    retrieveFavorites { result in
      switch result {
      case Result.success(var favorites):
        
        switch actionType {
        case PersistenceActionType.add:
          guard !favorites.contains(favorite) else {
            completionHandler(GFError.alreadyInFavorites)
            return
          }
          favorites.append(favorite)
          
        case PersistenceActionType.remove:
          favorites.removeAll { $0.login == favorite.login}
        }
        
        completionHandler(save(favorites: favorites))
        
      case Result.failure(let error):
        completionHandler(error)
      }
    }
  }
  
  static func retrieveFavorites(completionHandler: @escaping(Result<[Follower], GFError>) -> Void) {
    guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
      completionHandler(Result.success([]))
      return
    }
    
    do {
      let decoder = JSONDecoder()
      let favorites = try decoder.decode([Follower].self, from: favoritesData)
      completionHandler(Result.success(favorites))
    } catch {
      completionHandler(Result.failure(GFError.unableToFavorite))
    }
  }
  
  static func save(favorites: [Follower]) -> GFError? {
    do {
      let encoder = JSONEncoder()
      let encodedFavorites = try encoder.encode(favorites)
      defaults.set(encodedFavorites, forKey: Keys.favorites)
      return nil
    } catch {
      return GFError.unableToFavorite
    }
  }
}
