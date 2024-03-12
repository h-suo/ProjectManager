//
//  Calendar+.swift
//  ProjectManager
//
//  Created by Erick on 3/12/24.
//

import Foundation

extension Calendar {
  
  static func compareDate(_ lhs: Date, with rhs: Date = Date()) -> Bool? {
    let calendar = Calendar.current
    let lhsDateComponents = calendar.dateComponents([.year, .month, .day], from: lhs)
    let rhsDateComponents = calendar.dateComponents([.year, .month, .day], from: rhs)
    
    guard let lhsDate = calendar.date(from: lhsDateComponents),
          let rhsDate = calendar.date(from: rhsDateComponents)
    else { return nil }
    
    return lhsDate < rhsDate
  }
}
