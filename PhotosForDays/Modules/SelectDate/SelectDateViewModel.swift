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

    /// The latest date that can be selected by the user -  the day before the current date, as the Flickr expects a date in the past
    let maximumDate = Date().addingDays(-1)

    /// The date currently selected by the user - defaults to the day before the current date, as the Flickr expects a date in the past
    @Published var selectedDate = Date().addingDays(-1)

    /// Subject publisher for the selectedDate formatted for display
    lazy var formattedSelectedDateSubject: AnyPublisher<String?, Never> = {
        return $selectedDate
            .map({ date in
                return DateFormatter.fullDateFormatter.string(from: date)
            })
            .eraseToAnyPublisher()
    }()

    /// The user selected a new date
    func dateSelected(_ date: Date) {
        selectedDate = date
    }

}
