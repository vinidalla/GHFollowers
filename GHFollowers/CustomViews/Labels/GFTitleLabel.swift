//
//  GFTitleLabel.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 10/01/24.
//

import UIKit

class GFTitleLabel: UILabel {

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
    self.init(frame: CGRect.zero)
    self.textAlignment = textAlignment
    self.font = UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.bold)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
    textColor = UIColor.label
    adjustsFontSizeToFitWidth = true
    minimumScaleFactor = 0.90
    lineBreakMode = NSLineBreakMode.byTruncatingTail
    translatesAutoresizingMaskIntoConstraints = false
  }
}
