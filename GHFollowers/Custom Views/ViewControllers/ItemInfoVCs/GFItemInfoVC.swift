//
//  GFItemInfoVC.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 14/01/24.
//

import UIKit

protocol ItemInfoVCDelegate: AnyObject {
  func didTapGitHubProfile(user: User)
  func didTapGetFollowers(user: User)
}

class GFItemInfoVC: UIViewController {
  
  let stackView: UIStackView = UIStackView()
  let itemInfoViewOne: GFItemInfoView = GFItemInfoView()
  let itemInfoViewTwo: GFItemInfoView = GFItemInfoView()
  let actionButton: GFButton = GFButton()
  
  var user: User?
  
  init(user: User) {
    super.init(nibName: nil, bundle: nil)
    self.user = user
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
    override func viewDidLoad() {
        super.viewDidLoad()
      configureBackgroundView()
      configureActionButton()
      configureStackView()
      layoutUI()
    }
  
  private func configureBackgroundView() {
    view.layer.cornerRadius = Spacing.size18
    view.backgroundColor = UIColor.secondarySystemBackground
  }
  
  private func configureStackView() {
    stackView.axis = NSLayoutConstraint.Axis.horizontal
    stackView.distribution = UIStackView.Distribution.equalSpacing
    
    stackView.addArrangedSubview(itemInfoViewOne)
    stackView.addArrangedSubview(itemInfoViewTwo)
  }
  
  private func configureActionButton() {
    actionButton.addTarget(self,
                           action: #selector(actionButtonTapped),
                           for: UIControl.Event.touchUpInside)
  }
  
  @objc func actionButtonTapped() {
    
  }
  
  private func layoutUI() {
    view.addSubview(stackView)
    view.addSubview(actionButton)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: Spacing.size20),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.size20),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.size20),
      stackView.heightAnchor.constraint(equalToConstant: 50),
      
      actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Spacing.size20),
      actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Spacing.size20),
      actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Spacing.size20),
      actionButton.heightAnchor.constraint(equalToConstant: 44)
    ])
  }
}
