//
//  Date+Extension.swift
//  Bookwork
//
//  Created by Thomas Kellough on 11/20/20.
//

import Foundation

extension Date {
    func toShortDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        return formatter.string(from: self)
    }
}
