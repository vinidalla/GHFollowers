//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 13/01/24.
//

import UIKit

class UserInfoVC: UIViewController {
  
  var username: String?

    override func viewDidLoad() {
        super.viewDidLoad()
      view.backgroundColor = UIColor.systemBackground
      let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done,
                                       target: self,
                                       action: #selector(dismissVC))
      navigationItem.rightBarButtonItem = doneButton
      
      guard let username = username else { return }
      NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
        guard let self = self else { return }
        switch result {
        case Result.success(let user):
          print(user)
        case Result.failure(let error):
          self.presentGFAlertOnMainThread(title: "Something went wrong",
                                          message: error.rawValue,
                                          buttonTitle: "Ok")
        }
      }
    }
  
  @objc func dismissVC() {
    dismiss(animated: true)
  }
}
