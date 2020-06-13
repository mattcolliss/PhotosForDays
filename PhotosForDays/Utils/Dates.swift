//
//  Dates.swift
//  PhotosForDays
//
//  Created by Matthew Colliss on 13/06/2020.
//  Copyright © 2020 collissions. All rights reserved.
//

import Foundation

// MARK: - Dates Convenience
extension Date {

    /// Return a new date by adding an amount of days to self
    func addingDays(_ days: Int) -> Date {
        guard let date = Calendar.current.date(byAdding: .day, value: days, to: self) else {
            fatalError("Unalbe to calculate a new date, some has gone very wrong so trap")
        }
        return date
    }

    /// Return a new date by adding an amount of years to self
    func addingYears(_ years: Int) -> Date {
        guard let date = Calendar.current.date(byAdding: .year, value: years, to: self) else {
            fatalError("Unalbe to calculate a new date, some has gone very wrong so trap")
        }
        return date
    }

}

// MARK: - Date Formatters
extension DateFormatter {

    /// Fixed format for passing dates to the Flickr API
    static var apiRequestFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }

    /// Full format date is user's own locale
    static var fullDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()

    /// Medium format date is user's own locale
    static var mediumDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()

}
