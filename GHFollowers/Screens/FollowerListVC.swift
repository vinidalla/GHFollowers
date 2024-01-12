//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 10/01/24.
//

import UIKit

class FollowerListVC: UIViewController {
  
  var username: String!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.systemBackground
    navigationController?.navigationBar.prefersLargeTitles = true
    
    NetworkManager.shared.getFollowers(for: username, page: 1) { result in
      
      switch result {
      case .success(let followers):
        print(followers)
      case .failure(let error):
        self.presentGFAlertOnMainThread(title: "Bad stuff happend",
                                        message: error.rawValue,
                                        buttonTitle: "Ok")
      }
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: true)
    navigationController?.navigationBar.tintColor = UIColor.systemGreen
  }
}
