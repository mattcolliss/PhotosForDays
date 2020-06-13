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

    /// The date currently selected by the user - defaults to the current date
    @Published var selectedDate = Date()

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
