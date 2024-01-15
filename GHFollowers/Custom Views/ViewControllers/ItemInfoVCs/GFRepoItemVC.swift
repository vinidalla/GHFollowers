//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 14/01/24.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
  override func viewDidLoad() {
    super.viewDidLoad()
    configureItems()
  }
  
  private func configureItems() {
    itemInfoViewOne.set(itemInfoType: ItemInfoType.repos, withCount: user?.publicRepos ?? 0)
    itemInfoViewTwo.set(itemInfoType: ItemInfoType.gists, withCount: user?.publicGists ?? 0)
    actionButton.set(backgroundColor: UIColor.systemPurple, title: "GitHub Profile")
  }
  
  override func actionButtonTapped() {
    guard let user = user else { return }
    delegate?.didTapGitHubProfile(user: user)
  }
}
