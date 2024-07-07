//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 10/01/24.
//

import UIKit
import SafariServices

var containerView: UIView = UIView()

extension UIViewController {
  
  func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
    DispatchQueue.main.async {
      let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
      alertVC.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
      alertVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
      self.present(alertVC, animated: true)
    }
  }
  
  func presentSafariVC(url: URL) {
    let safariVC = SFSafariViewController(url: url)
    safariVC.preferredControlTintColor = UIColor.systemGreen
    present(safariVC, animated: true)
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
      activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
      activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
    ])
    
    activityIndicator.startAnimating()
  }
  
  func dismissLoadingView() {
    DispatchQueue.main.async {
      containerView.removeFromSuperview()
    }
  }
  
  func showEmptyStateView(with message: String, in view: UIView) {
    let emptyStateView = GFEmptyStateView(message: message)
    emptyStateView.frame = view.bounds
    view.addSubview(emptyStateView)
  }
}
