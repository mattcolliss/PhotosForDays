//
//  SelectDateViewModel.swift
//  PhotosForDays
//
//  Created by Matthew Colliss on 11/06/2020.
//  Copyright © 2020 collissions. All rights reserved.
//

import Foundation
import Combine

class SelectDateViewModel {

    /// View controller title
    let title = localizedString(key: "SelectDate.Title")

    /// Hint text
    let hintText = localizedString(key: "SelectDate.Hint")

    /// The latest date that can be selected by the user -  the day before the current date, as the Flickr expects a date in the past
    let maximumDate = Date().addingDays(-1)

    /// The ealiest date that can be selected by the user - the Flickr API seems to go back to about 2004, so using the last 15 years to be safe
    let minimumDate = Date().addingYears(-15)

    /// The date currently selected by the user - defaults to the day before the current date, as the Flickr expects a date in the past
    @Published var selectedDate = Date().addingDays(-1)

    /// Subject publisher for the selectedDate formatted for display
    var formattedSelectedDateSubject: AnyPublisher<String?, Never> {
        return $selectedDate
            .map({ date in
                return DateFormatter.fullDateFormatter.string(from: date)
            })
            .map({ formattedDate in
                let format = localizedString(key: "SelectDate.SelectedDate")
                return String.localizedStringWithFormat(format, formattedDate)
            })
            .eraseToAnyPublisher()
    }

    /// Start button title
    let startButtonTitle = localizedString(key: "SelectDate.StartButtonTitle").uppercased()

    /// The user selected a new date
    func dateSelected(_ date: Date) {
        selectedDate = date
    }

}
