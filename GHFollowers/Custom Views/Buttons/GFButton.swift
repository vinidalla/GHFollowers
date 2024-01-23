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

  convenience init(color: UIColor, title: String, systemImageName: String) {
    self.init(frame: CGRect.zero)
    set(color: color, title: title, systemImageName: systemImageName)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
    configuration = UIButton.Configuration.filled()
    configuration?.cornerStyle = UIButton.Configuration.CornerStyle.medium
    translatesAutoresizingMaskIntoConstraints = false
  }
  
  func set(color: UIColor, title: String, systemImageName: String) {
    configuration?.baseBackgroundColor = color
    configuration?.title = title
    
    configuration?.image = UIImage(systemName: systemImageName)
    configuration?.imagePadding = Spacing.size2
    configuration?.imagePlacement = NSDirectionalRectEdge.leading
  }
}
