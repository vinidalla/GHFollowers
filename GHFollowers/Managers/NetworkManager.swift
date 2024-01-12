//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 11/01/24.
//

import Foundation

class NetworkManager {
  static let shared = NetworkManager()
  let baseURL = "https://api.github.com/users/"
  
  private init() {}
  //func that gets usernames, pagination and has a completionHandler for success or error
  func getFollowers(for username: String, page: Int, completionHandler: @escaping(Result<[Follower], GFError>) -> Void) {
    let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
    
    //certification that the request worked, otherwise return error
    guard let url = URL(string: endpoint) else {
      completionHandler(.failure(GFError.invalidUserName))
      return
    }
    //URLSession return data, response and error
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if let _ = error { //handle no internet error
        completionHandler(.failure(GFError.unableToComplete))
        return
      }
      //checking if the response is not nil and the statusCode is 200, which means everything is OK
      guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        completionHandler(.failure(GFError.invalidResponse))
        return
      }
      //checking if the data is not nil
      guard let data = data else {
        completionHandler(.failure(GFError.invalidData))
        return
      }
      
      do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = JSONDecoder.KeyDecodingStrategy.convertFromSnakeCase //convert snake_case to camelCase
        //try to decode an array of followers from the data
        let followers = try decoder.decode([Follower].self, from: data)
        //everything goes well so we have followers and error is nil
        completionHandler(.success(followers))
      } catch { //error handing
        completionHandler(.failure(GFError.invalidData))
      }
    }
    
    task.resume() //this starts the network call
  }
}
