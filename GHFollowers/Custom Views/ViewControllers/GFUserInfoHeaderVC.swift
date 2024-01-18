//
//  GFUserInfoHeaderVC.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 14/01/24.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {
  
  let avatarImageView = GFAvatarImageView(frame: CGRect.zero)
  let usernameLabel = GFTitleLabel(textAlignment: NSTextAlignment.left, fontSize: 34)
  let nameLabel = GFSecondaryTitleLabel(fontSize: 18)
  let locationImageView = UIImageView()
  let locationLabel = GFSecondaryTitleLabel(fontSize: 18)
  let bioLabel = GFBodyLabel(textAlignment: NSTextAlignment.left)
  
  var user: User?
  
  init(user: User) {
    super.init(nibName: nil, bundle: nil)
    self.user = user
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
      addSubviews()
      layoutUI()
      configureUIElements()
    }
  
  func configureUIElements() {
    downloadAvatarImageHelper()
    usernameLabel.text = user?.login
    nameLabel.text = user?.name ?? GeneralStrings.notAvailable
    locationLabel.text = user?.location ?? GeneralStrings.noLocationAvailable
    bioLabel.text = user?.bio ?? GeneralStrings.noBioAvailable
    bioLabel.numberOfLines = 3
    
    locationImageView.image = UIImage(systemName: SFSymbols.location)
    locationImageView.tintColor = UIColor.secondaryLabel
  }
  
  func downloadAvatarImageHelper() {
    guard let user = user else { return }
    NetworkManager.shared.downloadAvatarImage(from: user.avatarUrl) { [weak self] image in
      guard let self = self else { return }
      DispatchQueue.main.async {
        self.avatarImageView.image = image
      }
    }
  }
  
  func addSubviews() {
    view.addSubview(avatarImageView)
    view.addSubview(usernameLabel)
    view.addSubview(nameLabel)
    view.addSubview(locationImageView)
    view.addSubview(locationLabel)
    view.addSubview(bioLabel)
  }
  
  func layoutUI() {
    locationImageView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: Spacing.size20),
      avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      avatarImageView.widthAnchor.constraint(equalToConstant: 90),
      avatarImageView.heightAnchor.constraint(equalToConstant: 90),
      
      usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
      usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: Spacing.size12),
      usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      usernameLabel.heightAnchor.constraint(equalToConstant: 38),
      
      nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: Spacing.size8),
      nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: Spacing.size12),
      nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      nameLabel.heightAnchor.constraint(equalToConstant: Spacing.size20),
      
      locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: Spacing.size12),
      locationImageView.widthAnchor.constraint(equalToConstant: Spacing.size20),
      locationImageView.heightAnchor.constraint(equalToConstant: Spacing.size20),
      locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
      
      locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
      locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
      locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      locationLabel.heightAnchor.constraint(equalToConstant: Spacing.size20),
      
      bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: Spacing.size12),
      bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
      bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      bioLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Spacing.size12),
      bioLabel.heightAnchor.constraint(equalToConstant: 90)
    ])
  }
}
