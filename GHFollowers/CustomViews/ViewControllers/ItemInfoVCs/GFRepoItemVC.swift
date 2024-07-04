//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 14/01/24.
//

import UIKit

protocol GFRepoItemVCDelegate: AnyObject {
  func didTapGitHubProfile(user: User)
}

class GFRepoItemVC: GFItemInfoVC {
  
  weak var delegate: GFRepoItemVCDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureItems()
  }
  
  private func configureItems() {
    itemInfoViewOne.set(itemInfoType: ItemInfoType.repos, withCount: user?.publicRepos ?? 0)
    itemInfoViewTwo.set(itemInfoType: ItemInfoType.gists, withCount: user?.publicGists ?? 0)
    actionButton.set(color: UIColor.systemPurple,
                     title: GeneralStrings.gitHubProfile,
                     systemImageName: SFSymbols.person)
  }
  
  override func actionButtonTapped() {
    guard let user = user else { return }
    delegate?.didTapGitHubProfile(user: user)
  }
}
