//
//  UIHelper.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 13/01/24.
//

import UIKit

enum UIHelper {
  
  static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
    let width = view.bounds.width
    let availableWidth = width - (Spacing.size12 * 2) - (Spacing.size10 * 2)
    let itemWidth = availableWidth / 3
    
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.sectionInset = UIEdgeInsets(top: Spacing.size12,
                                           left: Spacing.size12,
                                           bottom: Spacing.size12,
                                           right: Spacing.size12)
    flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
    
    return flowLayout
  }
}
