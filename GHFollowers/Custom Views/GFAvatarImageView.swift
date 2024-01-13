//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 11/01/24.
//

import UIKit

class GFAvatarImageView: UIImageView {
  
  let cache = NetworkManager.shared.cache
  let placeholderImage = UIImage(named: "avatar-placeholder")!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
    layer.cornerRadius = 10
    clipsToBounds = true
    image = placeholderImage
    translatesAutoresizingMaskIntoConstraints = false
  }
  
  func downloadAvatarImage(from urlString: String) {
    
    let cacheKey = NSString(string: urlString)
    
    if let image = cache.object(forKey: cacheKey) {
      self.image = image
      return
    }
    
    guard let url = URL(string: urlString) else { return }
    
    let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in //url call
      guard let self = self else { return }
      if error != nil { return } //no error? go forward. If we have an error, avatar image will be the placeholderImage
      guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return } //response ok and status 200? go forward
      guard let data = data else { return } //data is ok? go forward
      
      guard let image = UIImage(data: data) else { return } //pass data to the image
      cache.setObject(image, forKey: cacheKey) //store image into the cache
      
      DispatchQueue.main.async { //go to the main thread, set the image with the image we downloaded
        self.image = image
      }
    }
    task.resume()
  }
}
