//
//  Date+Helpers.swift.swift
//  MiniMockServerExample
//
//  Created by Ngoc LE on 2/28/19.
//  Copyright © 2019 Coder Life. All rights reserved.
//

import Foundation

extension String {
    /// Convert a String to Date object based on the format
    ///
    /// - Parameters:
    ///     - format: ISO8601 Date Format
    /// - Returns: the date in Date object
    func convertToDate(format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = Calendar.current.timeZone
        return dateFormatter.date(from: self)
    }
}
