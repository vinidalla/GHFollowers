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
      
      NetworkManager.shared.getFollowers(for: username, page: 1) { followers, errorMessage in
        guard let followers = followers else { //checking error case if we dont have followers call our alert
          self.presentGFAlertOnMainThread(title: "Bad stuff happend", message: errorMessage!, buttonTitle: "Ok")
          return
        }
        
        print("Followers.cont = \(followers.count)")
        print(followers)
      }
    }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: true)
    navigationController?.navigationBar.tintColor = UIColor.systemGreen
  }
}
