//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 13/01/24.
//

import UIKit

class UserInfoVC: UIViewController {
  
  let headerView: UIView = UIView()
  let itemViewOne: UIView = UIView()
  let itemViewTwo: UIView = UIView()
  let dateLabel: GFBodyLabel = GFBodyLabel(textAlignment: NSTextAlignment.center)
  var itemViews: [UIView] = []
  var username: String?
  
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
          self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
          self.add(childVC: GFRepoItemVC(user: user), to: self.itemViewOne)
          self.add(childVC: GFFollowerItemVC(user: user), to: self.itemViewTwo)
          self.dateLabel.text = "GitHub since \(user.createdAt.convertToDisplayFormat())"
        }
      case Result.failure(let error):
        self.presentGFAlertOnMainThread(title: "Something went wrong",
                                        message: error.rawValue,
                                        buttonTitle: "Ok")
      }
    }
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
