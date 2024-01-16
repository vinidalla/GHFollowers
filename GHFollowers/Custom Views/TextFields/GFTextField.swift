//
//  GFTextField.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 09/01/24.
//

import UIKit

class GFTextField: UITextField {

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
    translatesAutoresizingMaskIntoConstraints = false
    
    layer.cornerRadius = 10
    layer.borderWidth = 2
    layer.borderColor = UIColor.systemGray4.cgColor
    
    textColor = UIColor.label
    tintColor = UIColor.label
    textAlignment = NSTextAlignment.center
    font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title2)
    adjustsFontSizeToFitWidth = true
    minimumFontSize = 12
    
    backgroundColor = UIColor.tertiarySystemBackground
    autocorrectionType = UITextAutocorrectionType.no
    returnKeyType = UIReturnKeyType.go
    clearButtonMode = UITextField.ViewMode.whileEditing
    placeholder = GeneralStrings.enterUsername
  }
}
