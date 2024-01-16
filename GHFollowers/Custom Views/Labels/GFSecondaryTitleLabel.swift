//
//  GFSecondaryTitleLabel.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 14/01/24.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  convenience init(fontSize: CGFloat) {
    self.init(frame: CGRect.zero)
    font = UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.medium)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
    textColor = UIColor.secondaryLabel
    adjustsFontSizeToFitWidth = true
    minimumScaleFactor = 0.90
    lineBreakMode = NSLineBreakMode.byTruncatingTail
    translatesAutoresizingMaskIntoConstraints = false
  }
}
