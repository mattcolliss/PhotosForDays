//
//  PhotosCollectionViewModel.swift
//  PhotosForDays
//
//  Created by Matthew Colliss on 12/06/2020.
//  Copyright © 2020 collissions. All rights reserved.
//

import Foundation
import Combine

class PhotosCollectionViewModel {

    /// The currently fetched list of photos for the selected date
    @Published var photos = [Photo]()

    /// Are there any more photos to fetch for the current date
    var morePhotosAvailable = true

    /// Are photos currently being fetched
    var fecthingPhotos = false

    /// The selected date formatted for display
    lazy var formattedDate: String = {
        return DateFormatter.mediumDateFormatter.string(from: self.date)
    }()

    private var nextPage = 1
    private var totalPages = 1
    private var date: Date

    init(date: Date) {
        self.date = date
    }

    /// Fetch  the next page of photos from the Flickr API
    func fetchPhotos() {

        guard morePhotosAvailable else {
            return
        }

        fecthingPhotos = true

        GetPhotosConfiguration(date: date, page: nextPage).start { [weak self] (result) in

            switch result {
            case let .success(getPhotosResponseWrapper):

                self?.fecthingPhotos = false
                self?.nextPage = getPhotosResponseWrapper.photos.page + 1
                self?.totalPages = getPhotosResponseWrapper.photos.pages
                self?.morePhotosAvailable = getPhotosResponseWrapper.photos.page < getPhotosResponseWrapper.photos.pages
                self?.photos.append(contentsOf: getPhotosResponseWrapper.photos.photo)

            case let .failure(error):
                //TOOD: handle error
                print("Got error")
                print(error)
            }

        }

    }

}
