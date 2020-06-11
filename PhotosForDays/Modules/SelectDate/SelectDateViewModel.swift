//
//  SelectDateViewModel.swift
//  PhotosForDays
//
//  Created by Matthew Colliss on 11/06/2020.
//  Copyright © 2020 collissions. All rights reserved.
//

import Foundation

class SelectDateViewModel {
    
    var selectedDate = Date()
    
    func dateSelected(_ date: Date) {
        selectedDate = date
        print(selectedDate);
    }
    
}
