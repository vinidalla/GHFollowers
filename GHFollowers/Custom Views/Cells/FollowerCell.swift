//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 11/01/24.
//

import UIKit

class FollowerCell: UICollectionViewCell {
  
  static let reuseID = "FollowerCell"
  
  let avatarImageView = GFAvatarImageView(frame: CGRect.zero)
  let usernameLabel = GFTitleLabel(textAlignment: NSTextAlignment.center, fontSize: Spacing.size16)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func set(follower: Follower) {
    avatarImageView.downloadAvatarImageHelper(fromURL: follower.avatarUrl)
    usernameLabel.text = follower.login
  }
  
  private func configure() {
    addSubview(avatarImageView)
    addSubview(usernameLabel)
    
    NSLayoutConstraint.activate([
      avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.size8),
      avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.size8),
      avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.size8),
      avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
      
      usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: Spacing.size12),
      usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.size8),
      usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.size8),
      usernameLabel.heightAnchor.constraint(equalToConstant: Spacing.size20)
    ])
  }
}
