//
//  PlaceholderDetailsViewModel.swift
//  PhotosForDays
//
//  Created by Matthew Colliss on 14/06/2020.
//  Copyright © 2020 collissions. All rights reserved.
//

import Foundation
import UIKit

class PlaceholderDetailsViewModel {

    var icon: UIImage? {
        return UIImage(systemName: "calendar")
    }

    var hintText: String {
        return localizedString(key: "PlaceholderDetails.Hint")
    }

}
