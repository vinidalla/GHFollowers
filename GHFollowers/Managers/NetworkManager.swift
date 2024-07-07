//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 11/01/24.
//

import UIKit

class NetworkManager {
  
  static let shared = NetworkManager()
  private let baseURL = "https://api.github.com/users/"
  let cache = NSCache<NSString, UIImage>()

  // MARK: - getFollowers
  
  func getFollowers(for username: String,
                    page: Int,
                    completionHandler: @escaping(Result<[Follower], GFError>) -> Void) {
    let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
    
    guard let url = URL(string: endpoint) else {
      completionHandler(Result.failure(GFError.invalidUserName))
      return
    }

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if let _ = error {
        completionHandler(Result.failure(GFError.unableToComplete))
        return
      }

      guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        completionHandler(Result.failure(GFError.invalidResponse))
        return
      }

      guard let data = data else {
        completionHandler(Result.failure(GFError.invalidData))
        return
      }
      
      do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = JSONDecoder.KeyDecodingStrategy.convertFromSnakeCase

        let followers = try decoder.decode([Follower].self, from: data)

        completionHandler(Result.success(followers))
      } catch {
        completionHandler(Result.failure(GFError.invalidData))
      }
    }
    
    task.resume()
  }
  
  // MARK: - getUserInfo
  
  func getUserInfo(for username: String, completionHandler: @escaping(Result<User, GFError>) -> Void) {
    let endpoint = baseURL + "\(username)"
    
    guard let url = URL(string: endpoint) else {
      completionHandler(Result.failure(GFError.invalidUserName))
      return
    }

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if let _ = error {
        completionHandler(Result.failure(GFError.unableToComplete))
        return
      }

      guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        completionHandler(Result.failure(GFError.invalidResponse))
        return
      }

      guard let data = data else {
        completionHandler(Result.failure(GFError.invalidData))
        return
      }
      
      do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = JSONDecoder.KeyDecodingStrategy.convertFromSnakeCase
        decoder.dateDecodingStrategy = JSONDecoder.DateDecodingStrategy.iso8601

        let user = try decoder.decode(User.self, from: data)

        completionHandler(Result.success(user))
      } catch {
        completionHandler(Result.failure(GFError.invalidData))
      }
    }
    
    task.resume() 
  }
  
  // MARK: - downloadAvatarImage and cache
  
  func downloadAvatarImage(from urlString: String, completionHandler: @escaping (UIImage?) -> Void) {
    let cacheKey = NSString(string: urlString)
    
    if let image = cache.object(forKey: cacheKey) {
      completionHandler(image)
      return
    }
    
    guard let url = URL(string: urlString) else {
      completionHandler(nil)
      return
    }
    
    let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
      guard let self = self,
            error == nil,
            let response = response as? HTTPURLResponse, response.statusCode == 200,
            let data = data,
            let image = UIImage(data: data) else {
        completionHandler(nil)
        return
      }
      
      self.cache.setObject(image, forKey: cacheKey)
      completionHandler(image)
    }
    task.resume()
  }
}
