//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 14/01/24.
//

import Foundation

import UIKit

class GFFollowerItemVC: GFItemInfoVC {
  override func viewDidLoad() {
    super.viewDidLoad()
    configureItems()
  }
  
  private func configureItems() {
    itemInfoViewOne.set(itemInfoType: ItemInfoType.followers, withCount: user?.followers ?? 0)
    itemInfoViewTwo.set(itemInfoType: ItemInfoType.following, withCount: user?.following ?? 0)
    actionButton.set(backgroundColor: UIColor.systemGreen, title: "GitHub Followers")
  }
}
