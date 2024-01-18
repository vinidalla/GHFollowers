//
//  FavoriteCell.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 15/01/24.
//

import UIKit

class FavoriteCell: UITableViewCell {
  static let reuseID = "FavoriteCell"
  
  let avatarImageView = GFAvatarImageView(frame: CGRect.zero)
  let usernameLabel = GFTitleLabel(textAlignment: NSTextAlignment.left, fontSize: Spacing.size26)
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func set(favorite: Follower) {
    usernameLabel.text = favorite.login
    NetworkManager.shared.downloadAvatarImage(from: favorite.avatarUrl) { [weak self] image in
      guard let self = self else { return }
      DispatchQueue.main.async {
        self.avatarImageView.image = image
      }
    }
  }
  
  private func configure() {
    addSubview(avatarImageView)
    addSubview(usernameLabel)
    
    accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
    
    NSLayoutConstraint.activate([
      avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Spacing.size12),
      avatarImageView.heightAnchor.constraint(equalToConstant: Spacing.size60),
      avatarImageView.widthAnchor.constraint(equalToConstant: Spacing.size60),
      
      usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: Spacing.size24),
      usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Spacing.size12),
      usernameLabel.heightAnchor.constraint(equalToConstant: Spacing.size40)
    ])
  }
}
