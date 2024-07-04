//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 14/01/24.
//

import Foundation

import UIKit

protocol GFFollowerItemVCDelegate: AnyObject {
  func didTapGetFollowers(user: User)
}

class GFFollowerItemVC: GFItemInfoVC {
  
  weak var delegate: GFFollowerItemVCDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureItems()
  }
  
  private func configureItems() {
    itemInfoViewOne.set(itemInfoType: ItemInfoType.followers, withCount: user?.followers ?? 0)
    itemInfoViewTwo.set(itemInfoType: ItemInfoType.following, withCount: user?.following ?? 0)
    actionButton.set(color: UIColor.systemGreen,
                     title: GeneralStrings.gitHubFollowers,
                     systemImageName: SFSymbols.person3)
  }
  
  override func actionButtonTapped() {
    guard let user = user else { return }
    delegate?.didTapGetFollowers(user: user)
  }
}
