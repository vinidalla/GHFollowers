//
//  GFButton.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 05/01/24.
//

import UIKit

class GFButton: UIButton {
  override init(frame: CGRect) { //override means that this subclass of UIButton will override the init of UIButton class
    super.init(frame: frame) //super means that all that apple creates in UIButton will happens first, then this will happen
    configure()
  }
  
  required init?(coder: NSCoder) { //this required is for storyBoard project cases, not for this project
    fatalError("init(coder:) has not been implemented")
  }
  
  init(backgroundColor: UIColor, title: String) { //when we initialize our GFButton this init show up
    super.init(frame: CGRect.zero)
    self.backgroundColor = backgroundColor
    self.setTitle(title, for: UIControl.State.normal)
    configure()
  }
  
  private func configure() {
    layer.cornerRadius = 10
    setTitleColor(UIColor.white, for: UIControl.State.normal)
    titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
    translatesAutoresizingMaskIntoConstraints = false //you need this to use autolayout
  }
  
  func set(backgroundColor: UIColor, title: String) {
    self.backgroundColor =  backgroundColor
    setTitle(title, for: UIControl.State.normal)
  }
}
