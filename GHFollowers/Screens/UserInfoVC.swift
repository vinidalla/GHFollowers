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
    }
  
  @objc func dismissVC() {
    dismiss(animated: true)
  }
}
