//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 11/01/24.
//

import UIKit

class GFAvatarImageView: UIImageView {
  
  let cache = NetworkManager.shared.cache
  let placeholderImage = Images.placeholder
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
    layer.cornerRadius = Spacing.size10
    clipsToBounds = true
    image = placeholderImage
    translatesAutoresizingMaskIntoConstraints = false
  }
  
  func downloadAvatarImageHelper(fromURL url: String) {
    NetworkManager.shared.downloadAvatarImage(from: url) { [weak self] image in
      guard let self = self else { return }
      DispatchQueue.main.async {
        self.image = image
      }
    }
  }
}
