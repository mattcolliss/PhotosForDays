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

    /// Date currently selected by the user - defaults to the current date
    @Published var selectedDate = Date()

    /// Subject for selectedDate in a iser friednly format
    lazy var formattedSelectedDateSubject: AnyPublisher<String?, Never> = {
        return $selectedDate
            .map({ date in
                return self.dateFormatter.string(from: date)
            })
            .eraseToAnyPublisher()
    }()

    /// The user selected a new date
    func dateSelected(_ date: Date) {
        selectedDate = date
    }

    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()

}
