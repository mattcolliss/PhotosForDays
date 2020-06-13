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

    @Published var photos = [Photo]()
    var morePhotosAvailable = true
    var fecthingPhotos = false

    private var nextPage = 1
    private var totalPages = 1
    private var date: Date

    init(date: Date) {
        self.date = date
    }

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
