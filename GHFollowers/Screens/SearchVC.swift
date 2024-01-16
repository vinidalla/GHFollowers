//
//  SearchVC.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 04/01/24.
//

import UIKit

class SearchVC: UIViewController {
  
  let logoImageView = UIImageView()
  let usernameTextField = GFTextField()
  let callToActionButton = GFButton(backgroundColor: UIColor.systemGreen,
                                    title: GeneralStrings.getFollowersTitle)
  
  var isUsernameEntered: Bool {
    if let text = usernameTextField.text {
      return !text.isEmpty
    }
    return false
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.systemBackground
    configureLogoImageView()
    configureTextField()
    configureCallToActionButton()
    createDismissKeyboardTapGesture()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: true)
    usernameTextField.text = String()
  }
  
  func createDismissKeyboardTapGesture() {
    let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
    view.addGestureRecognizer(tap)
  }
  
  @objc func pushFollowerListVC() {
    
    guard isUsernameEntered else {
      presentGFAlertOnMainThread(title: GeneralStrings.emptyUserName,
                                 message: GeneralStrings.pleaseEnterUserName,
                                 buttonTitle: GeneralStrings.ok)
      return
    }
    
    usernameTextField.resignFirstResponder()
    let followerListVC = FollowerListVC(username: usernameTextField.text ?? "")
    navigationController?.pushViewController(followerListVC, animated: true)
  }
  
  func configureLogoImageView() {
    view.addSubview(logoImageView)
    logoImageView.translatesAutoresizingMaskIntoConstraints = false
    logoImageView.image = Images.ghLogo
    
    NSLayoutConstraint.activate([
      logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 55),
      logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      logoImageView.heightAnchor.constraint(equalToConstant: 200),
      logoImageView.widthAnchor.constraint(equalToConstant: 200)
    ])
  }
  
  func configureTextField() {
    view.addSubview(usernameTextField)
    usernameTextField.delegate = self
    NSLayoutConstraint.activate([
      usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40),
      usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
      usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
      usernameTextField.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
  func configureCallToActionButton() {
    view.addSubview(callToActionButton)
    callToActionButton.addTarget(self,
                                 action: #selector(pushFollowerListVC),
                                 for: UIControl.Event.touchUpInside)
    
    NSLayoutConstraint.activate([
      callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
      callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
      callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
      callToActionButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
}

extension SearchVC: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    pushFollowerListVC()
    return true
  }
}
