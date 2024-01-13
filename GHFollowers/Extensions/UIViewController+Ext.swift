//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 10/01/24.
//

import UIKit

fileprivate var containerView: UIView = UIView()

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
  
  func showLoadingView() {
    containerView = UIView(frame: view.bounds)
    view.addSubview(containerView)
    
    containerView.backgroundColor = UIColor.systemBackground
    containerView.alpha = 0
    
    UIView.animate(withDuration: 0.25) {
      containerView.alpha = 0.8
    }
    
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    containerView.addSubview(activityIndicator)
    
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
    
    activityIndicator.startAnimating()
  }
  
  func dismissLoadingView() {
    DispatchQueue.main.async {
      containerView.removeFromSuperview()
    }
  }
}
