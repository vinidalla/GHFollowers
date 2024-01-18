//
//  GFBodyLabel.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 10/01/24.
//

import UIKit

class GFBodyLabel: UILabel {

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  convenience init(textAlignment: NSTextAlignment) {
    self.init(frame: CGRect.zero)
    self.textAlignment = textAlignment
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
    textColor = UIColor.secondaryLabel
    font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
    adjustsFontSizeToFitWidth = true
    adjustsFontForContentSizeCategory = true
    minimumScaleFactor = 0.75
    lineBreakMode = NSLineBreakMode.byTruncatingTail
    translatesAutoresizingMaskIntoConstraints = false
  }
}
