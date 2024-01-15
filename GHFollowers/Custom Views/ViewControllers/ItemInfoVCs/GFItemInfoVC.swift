//
//  GFItemInfoVC.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 14/01/24.
//

import UIKit

class GFItemInfoVC: UIViewController {
  
  let stackView: UIStackView = UIStackView()
  let itemInfoViewOne: GFItemInfoView = GFItemInfoView()
  let itemInfoViewTwo: GFItemInfoView = GFItemInfoView()
  let actionButton: GFButton = GFButton()
  
  var user: User?
  weak var delegate: UserInfoVCDelegate?
  
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
    view.layer.cornerRadius = 18
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
    let padding: CGFloat = 20
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      stackView.heightAnchor.constraint(equalToConstant: 50),
      
      actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
      actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
      actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
      actionButton.heightAnchor.constraint(equalToConstant: 44)
    ])
  }
}
