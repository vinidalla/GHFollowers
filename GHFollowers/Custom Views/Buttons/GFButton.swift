//
//  GFButton.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 05/01/24.
//

import UIKit

class GFButton: UIButton {
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }

  convenience init(backgroundColor: UIColor, title: String) {
    self.init(frame: CGRect.zero)
    self.backgroundColor = backgroundColor
    self.setTitle(title, for: UIControl.State.normal)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
    layer.cornerRadius = 10
    setTitleColor(UIColor.white, for: UIControl.State.normal)
    titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
    translatesAutoresizingMaskIntoConstraints = false
  }
  
  func set(backgroundColor: UIColor, title: String) {
    self.backgroundColor =  backgroundColor
    setTitle(title, for: UIControl.State.normal)
  }
}
