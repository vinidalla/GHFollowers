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
  func getFollowers(for username: String, page: Int, completionHandler: @escaping([Follower]?, String?) -> Void) {
    let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
    
    //certification that the request worked, otherwise return the description bellow. The nil represents no followers return back
    guard let url = URL(string: endpoint) else {
      completionHandler(nil, "This username created an invalid request. Please try again.")
      return
    }
    //the api work fine, url is good and the URLSession return data, response and error
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if let _ = error { //handle no internet error
        completionHandler(nil, "Unable to complete request, please check your internet connection")
        return
      }
      //checking if the response is not nil and the statusCode is 200, which means everything is OK
      guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        completionHandler(nil, "Invalid response from the server. Please try again")
        return
      }
      //checking if the data is not nil
      guard let data = data else {
        completionHandler(nil, "The data received from the server was invalid. Please try again.")
        return
      }
      
      do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = JSONDecoder.KeyDecodingStrategy.convertFromSnakeCase //convert snake_case to camelCase
        //try to decode an array of followers from the data
        let followers = try decoder.decode([Follower].self, from: data)
        //everything goes well so we have followers and error is nil
        completionHandler(followers, nil)
      } catch { //error handing
        completionHandler(nil, "The data received from the server was invalid. Please try again.")
      }
    }
    
    task.resume() //this starts the network call
  }
}
