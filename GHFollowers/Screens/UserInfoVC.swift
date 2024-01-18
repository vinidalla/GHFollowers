//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 13/01/24.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
  func didRequestFollowers(username: String)
}

class UserInfoVC: UIViewController {
  
  let scrollView: UIScrollView = UIScrollView()
  let contentView: UIView = UIView()
  
  let headerView: UIView = UIView()
  let itemViewOne: UIView = UIView()
  let itemViewTwo: UIView = UIView()
  let dateLabel: GFBodyLabel = GFBodyLabel(textAlignment: NSTextAlignment.center)
  
  var itemViews: [UIView] = []
  var username: String?
  weak var delegate: UserInfoVCDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewController()
    configureScrollView()
    getUserInfo()
    layoutUI()
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
  
  func configureViewController() {
    view.backgroundColor = UIColor.systemBackground
    let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done,
                                     target: self,
                                     action: #selector(dismissVC))
    navigationItem.rightBarButtonItem = doneButton
  }
  
  func configureScrollView() {
    view.addSubview(scrollView)
    scrollView.addSubview(contentView)
    scrollView.pinToEdges(of: view)
    contentView.pinToEdges(of: scrollView)
    
    NSLayoutConstraint.activate([
      contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
      contentView.heightAnchor.constraint(equalToConstant: 600)
    ])
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
    let itemHeight: CGFloat = 140
    
    itemViews = [headerView,
                 itemViewOne,
                 itemViewTwo,
                 dateLabel]
    for itemView in itemViews {
      contentView.addSubview(itemView)
      itemView.translatesAutoresizingMaskIntoConstraints = false
      
      NSLayoutConstraint.activate([
        itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Spacing.size20),
        itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Spacing.size20)
      ])
    }
    
    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
      headerView.heightAnchor.constraint(equalToConstant: 180),
      
      itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Spacing.size20),
      itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
      
      itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: Spacing.size20),
      itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
      
      dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: Spacing.size20),
      dateLabel.heightAnchor.constraint(equalToConstant: Spacing.size50)
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

extension UserInfoVC: GFRepoItemVCDelegate {
  func didTapGitHubProfile(user: User) {
    guard let url = URL(string: user.htmlUrl) else {
      presentGFAlertOnMainThread(title: GeneralStrings.invalidUrl,
                                 message: GeneralStrings.invalidAttachedUrl,
                                 buttonTitle: GeneralStrings.ok)
      return
    }
    presentSafariVC(url: url)
  }
}

extension UserInfoVC: GFFollowerItemVCDelegate {
  func didTapGetFollowers(user: User) {
    guard user.followers != 0 else {
      presentGFAlertOnMainThread(title: GeneralStrings.noFollowers,
                                 message: GeneralStrings.userHasNoFollowers,
                                 buttonTitle: GeneralStrings.ok)
      return
    }
    delegate?.didRequestFollowers(username: user.login)
    dismissVC()
  }
}
