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
  
  private init() {}
  //func that gets usernames, pagination and has a completionHandler for success or error
  func getFollowers(for username: String, page: Int, completionHandler: @escaping(Result<[Follower], GFError>) -> Void) {
    let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
    
    //certification that the request worked, otherwise return error
    guard let url = URL(string: endpoint) else {
      completionHandler(Result.failure(GFError.invalidUserName))
      return
    }
    //URLSession return data, response and error
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if let _ = error { //handle no internet error
        completionHandler(Result.failure(GFError.unableToComplete))
        return
      }
      //checking if the response is not nil and the statusCode is 200, which means everything is OK
      guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        print(response)
        completionHandler(Result.failure(GFError.invalidResponse))
        return
      }
      //checking if the data is not nil
      guard let data = data else {
        completionHandler(Result.failure(GFError.invalidData))
        return
      }
      
      do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = JSONDecoder.KeyDecodingStrategy.convertFromSnakeCase //convert snake_case to camelCase
        //try to decode an array of followers from the data
        let followers = try decoder.decode([Follower].self, from: data)
        //everything goes well so we have followers and error is nil
        completionHandler(Result.success(followers))
      } catch { //error handing
        completionHandler(Result.failure(GFError.invalidData))
      }
    }
    
    task.resume() //this starts the network call
  }
  
  func getUserInfo(for username: String, completionHandler: @escaping(Result<User, GFError>) -> Void) {
    let endpoint = baseURL + "\(username)"
    
    //certification that the request worked, otherwise return error
    guard let url = URL(string: endpoint) else {
      completionHandler(Result.failure(GFError.invalidUserName))
      return
    }
    //URLSession return data, response and error
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if let _ = error { //handle no internet error
        completionHandler(Result.failure(GFError.unableToComplete))
        return
      }
      //checking if the response is not nil and the statusCode is 200, which means everything is OK
      guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        completionHandler(Result.failure(GFError.invalidResponse))
        return
      }
      //checking if the data is not nil
      guard let data = data else {
        completionHandler(Result.failure(GFError.invalidData))
        return
      }
      
      do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = JSONDecoder.KeyDecodingStrategy.convertFromSnakeCase //convert snake_case to camelCase
        decoder.dateDecodingStrategy = JSONDecoder.DateDecodingStrategy.iso8601
        //try to decode an array of followers from the data
        let user = try decoder.decode(User.self, from: data)
        //everything goes well so we have followers and error is nil
        completionHandler(Result.success(user))
      } catch { //error handing
        completionHandler(Result.failure(GFError.invalidData))
      }
    }
    
    task.resume() //this starts the network call
  }
  
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
