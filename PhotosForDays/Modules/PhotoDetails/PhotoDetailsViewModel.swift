//
//  PhotoDetailsViewModel.swift
//  PhotosForDays
//
//  Created by Matthew Colliss on 13/06/2020.
//  Copyright © 2020 collissions. All rights reserved.
//

import Foundation
import UIKit

class PhotoDetailsViewModel {

    /// The URL to fetch seleted photo
    var photoUrl: URL? {
        photo.url
    }

    /// A formatted title to display for the photo
    var photoTitle: String {
        return photo.title.isEmpty ? "Untitled" : photo.title
    }

    /// The current scale type used to dusply the photo
    @Published var photoScaleMode: UIView.ContentMode = .scaleAspectFit

    private var photo: Photo

    init(photo: Photo) {
        self.photo = photo
    }

    /// Toggle between aspect fit and apsect fill scale types
    func togglePhotoScaleMode() {
        if photoScaleMode == .scaleAspectFit {
            photoScaleMode = .scaleAspectFill
        } else {
            photoScaleMode = .scaleAspectFit
        }
    }

}
