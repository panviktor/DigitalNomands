//
//  Date+Extension.swift
//  DigitalNomands
//
//  Created by Viktor on 19.01.2021.
//

import Foundation

extension Date {
  static func dateFromString(date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: date) ?? Date()
     }
}

extension Date {
    static func dateAndTimetoString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.string(from: date)
    }
}
