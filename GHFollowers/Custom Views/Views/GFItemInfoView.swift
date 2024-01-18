//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 14/01/24.
//

import UIKit

enum ItemInfoType {
  case repos, gists, followers, following
}

class GFItemInfoView: UIView {
  
  let symbolImageView: UIImageView = UIImageView()
  let titleLabel = GFTitleLabel(textAlignment: NSTextAlignment.left, fontSize: Spacing.size14)
  let countLabel = GFTitleLabel(textAlignment: NSTextAlignment.center, fontSize: Spacing.size14)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
    addSubview(symbolImageView)
    addSubview(titleLabel)
    addSubview(countLabel)
    
    symbolImageView.translatesAutoresizingMaskIntoConstraints = false
    symbolImageView.contentMode = UIView.ContentMode.scaleAspectFill
    symbolImageView.tintColor = UIColor.label
    
    NSLayoutConstraint.activate([
      symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
      symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      symbolImageView.widthAnchor.constraint(equalToConstant: Spacing.size20),
      symbolImageView.heightAnchor.constraint(equalToConstant: Spacing.size20),
      
      titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: Spacing.size12),
      titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      titleLabel.heightAnchor.constraint(equalToConstant: Spacing.size18),
      
      countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: Spacing.size4),
      countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      countLabel.heightAnchor.constraint(equalToConstant: Spacing.size18)
    ])
  }
  
  func set(itemInfoType: ItemInfoType, withCount count: Int) {
    switch itemInfoType {
    case ItemInfoType.repos:
      symbolImageView.image = UIImage(systemName: SFSymbols.repos)
      titleLabel.text = GeneralStrings.publicRepos
    case ItemInfoType.gists:
      symbolImageView.image = UIImage(systemName: SFSymbols.gists)
      titleLabel.text = GeneralStrings.publicGists
    case ItemInfoType.followers:
      symbolImageView.image = UIImage(systemName: SFSymbols.followers)
      titleLabel.text = GeneralStrings.followers
    case ItemInfoType.following:
      symbolImageView.image = UIImage(systemName: SFSymbols.following)
      titleLabel.text = GeneralStrings.following
    }
    countLabel.text = String(count)
  }

}
