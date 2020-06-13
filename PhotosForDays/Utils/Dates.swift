//
//  Dates.swift
//  PhotosForDays
//
//  Created by Matthew Colliss on 13/06/2020.
//  Copyright © 2020 collissions. All rights reserved.
//

import Foundation

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

}
