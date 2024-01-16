//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 13/01/24.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
  func didTapGitHubProfile(user: User)
  func didTapGetFollowers(user: User)
}

class UserInfoVC: UIViewController {
  
  let headerView: UIView = UIView()
  let itemViewOne: UIView = UIView()
  let itemViewTwo: UIView = UIView()
  let dateLabel: GFBodyLabel = GFBodyLabel(textAlignment: NSTextAlignment.center)
  
  var itemViews: [UIView] = []
  var username: String?
  weak var delegate: FollowerListVCDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
    getUserInfo()
    layoutUI()
  }
  
  func configureViewController() {
    view.backgroundColor = UIColor.systemBackground
    let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done,
                                     target: self,
                                     action: #selector(dismissVC))
    navigationItem.rightBarButtonItem = doneButton
  }
  
  func getUserInfo() {
    guard let username = username else { return }
    NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
      guard let self = self else { return }
      switch result {
      case Result.success(let user):
        DispatchQueue.main.async {
          self.configureUIElements(user: user)
        }
      case Result.failure(let error):
        self.presentGFAlertOnMainThread(title: GeneralStrings.somethingWentWrong,
                                        message: error.rawValue,
                                        buttonTitle: GeneralStrings.ok)
      }
    }
  }
  
  func configureUIElements(user: User) {
    let repoItemVC = GFRepoItemVC(user: user)
    repoItemVC.delegate = self
    
    let followerItemVC = GFFollowerItemVC(user: user)
    followerItemVC.delegate = self
    
    self.add(childVC: repoItemVC, to: self.itemViewOne)
    self.add(childVC: followerItemVC, to: self.itemViewTwo)
    self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
    self.dateLabel.text = "GitHub since \(user.createdAt.convertToMonthYearFormat())"
  }
  
  func layoutUI() {
    let padding: CGFloat = 20
    let itemHeight: CGFloat = 140
    
    itemViews = [headerView,
                 itemViewOne,
                 itemViewTwo,
                 dateLabel]
    for itemView in itemViews {
      view.addSubview(itemView)
      itemView.translatesAutoresizingMaskIntoConstraints = false
      
      NSLayoutConstraint.activate([
        itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
        itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
      ])
    }
    
    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      headerView.heightAnchor.constraint(equalToConstant: 180),
      
      itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
      itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
      
      itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
      itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
      
      dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
      dateLabel.heightAnchor.constraint(equalToConstant: 18)
    ])
  }
  
  func add(childVC: UIViewController, to containerView: UIView) {
    addChild(childVC)
    containerView.addSubview(childVC.view)
    childVC.view.frame = containerView.bounds
    childVC.didMove(toParent: self)
  }
  
  
  @objc func dismissVC() {
    dismiss(animated: true)
  }
}

extension UserInfoVC: UserInfoVCDelegate {
  func didTapGitHubProfile(user: User) {
    guard let url = URL(string: user.htmlUrl) else {
      presentGFAlertOnMainThread(title: GeneralStrings.invalidUrl,
                                 message: GeneralStrings.invalidAttachedUrl,
                                 buttonTitle: GeneralStrings.ok)
      return
    }
    presentSafariVC(url: url)
  }
  
  func didTapGetFollowers(user: User) {
    guard user.followers != 0 else {
      presentGFAlertOnMainThread(title: GeneralStrings.noFollowers,
                                 message: GeneralStrings.userHasNoFollwers,
                                 buttonTitle: GeneralStrings.ok)
      return
    }
    delegate?.didRequestFollowers(username: user.login)
    dismissVC()
  }
}
