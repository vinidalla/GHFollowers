//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 10/01/24.
//

import UIKit

//created this extension to call every time we need to show the alert GFAlertVC on the main thread
extension UIViewController {
  func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
    DispatchQueue.main.async {
      let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
      alertVC.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
      alertVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
      self.present(alertVC, animated: true)
    }
  }
}
