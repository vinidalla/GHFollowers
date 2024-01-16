//
//  Date+Ext.swift
//  GHFollowers
//
//  Created by Vinícius Dalla Vechia on 16/01/24.
//

import Foundation

extension Date {
  func convertToMonthYearFormat() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM yyyy"
    return dateFormatter.string(from: self)
  }
}
