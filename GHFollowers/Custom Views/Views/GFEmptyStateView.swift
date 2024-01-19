//
//  GFEmptyStateView.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 13/01/24.
//

import UIKit

class GFEmptyStateView: UIView {
  
  let messageLabel = GFTitleLabel(textAlignment: NSTextAlignment.center, fontSize: Spacing.size28)
  let logoImageView = UIImageView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  convenience init(message: String) {
    self.init(frame: CGRect.zero)
    messageLabel.text = message
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
    addSubview(messageLabel)
    addSubview(logoImageView)
    
    messageLabel.numberOfLines = 3
    messageLabel.textColor = UIColor.secondaryLabel
    
    logoImageView.image = Images.emptyStateLogo
    logoImageView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -Spacing.size100),
      messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Spacing.size40),
      messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Spacing.size40),
      messageLabel.heightAnchor.constraint(equalToConstant: Spacing.size200),
      
      logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
      logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
      logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Spacing.size180),
      logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Spacing.size40)
    ])
  }
}
