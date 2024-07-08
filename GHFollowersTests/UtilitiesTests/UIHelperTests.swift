//
//  UIHelperTests.swift
//  GHFollowersTests
//
//  Created by Vinícius Dalla Vechia on 08/07/24.
//

import XCTest
@testable import GHFollowers

final class UIHelperTests: XCTestCase {
  
  func testCreateThreeColumnFlowLayout() {
    let view = UIView(frame: CGRect(x: 0, 
                                    y: 0,
                                    width: 360,
                                    height: 640))
    
    let flowLayout = UIHelper.createThreeColumnFlowLayout(in: view)
    
    let width = view.bounds.width
    let availableWidth = width - (Spacing.size12 * 2) - (Spacing.size10 * 2)
    let itemWidth = availableWidth / 3
    
    XCTAssertEqual(flowLayout.sectionInset.top, Spacing.size12)
    XCTAssertEqual(flowLayout.sectionInset.left, Spacing.size12)
    XCTAssertEqual(flowLayout.sectionInset.bottom, Spacing.size12)
    XCTAssertEqual(flowLayout.sectionInset.right, Spacing.size12)
    XCTAssertEqual(flowLayout.itemSize.width, itemWidth)
    XCTAssertEqual(flowLayout.itemSize.height, itemWidth + 40)
  }
}
