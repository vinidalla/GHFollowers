//
//  GFAlertVC.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 10/01/24.
//

import UIKit

class GFAlertVC: UIViewController {
  
  let containerView = GFAlertContainerView()
  let titleLabel = GFTitleLabel(textAlignment: NSTextAlignment.center, fontSize: Spacing.size20)
  let messageLabel = GFBodyLabel(textAlignment: NSTextAlignment.center)
  let actionButton = GFButton(color: UIColor.systemPink, title: GeneralStrings.ok, systemImageName: SFSymbols.checkMarkOk)
  
  var alertTitle: String?
  var message: String?
  var buttonTitle: String?
  
  init(title: String, message: String, buttonTitle: String) {
    super.init(nibName: nil, bundle: nil)
    self.alertTitle = title
    self.message = message
    self.buttonTitle = buttonTitle
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
    configureContainerView()
    configureTitleLabel()
    configureActionButton()
    configureMessageLabel()
  }
  
  func configureContainerView() {
    view.addSubview(containerView)
    
    NSLayoutConstraint.activate([
      containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      containerView.widthAnchor.constraint(equalToConstant: 280),
      containerView.heightAnchor.constraint(equalToConstant: 220)
    ])
  }
  
  func configureTitleLabel() {
    containerView.addSubview(titleLabel)
    titleLabel.text = alertTitle ?? GeneralStrings.somethingWentWrong
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Spacing.size20),
      titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Spacing.size20),
      titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Spacing.size20),
      titleLabel.heightAnchor.constraint(equalToConstant: 28)
    ])
  }
  
  func configureActionButton() {
    containerView.addSubview(actionButton)
    actionButton.setTitle(buttonTitle ?? GeneralStrings.ok, for: UIControl.State.normal)
    actionButton.addTarget(self, action: #selector(dismissVC), for: UIControl.Event.touchUpInside)
    
    NSLayoutConstraint.activate([
      actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Spacing.size20),
      actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Spacing.size20),
      actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Spacing.size20),
      actionButton.heightAnchor.constraint(equalToConstant: 44)
    ])
  }
  
  func configureMessageLabel() {
    containerView.addSubview(messageLabel)
    messageLabel.text = message ?? GeneralStrings.unableToCompleteRequest
    messageLabel.numberOfLines = 4
    
    NSLayoutConstraint.activate([
      messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Spacing.size8),
      messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Spacing.size20),
      messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Spacing.size20),
      messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -Spacing.size12)
    ])
  }
  
  @objc func dismissVC() {
    dismiss(animated: true)
  }
}
