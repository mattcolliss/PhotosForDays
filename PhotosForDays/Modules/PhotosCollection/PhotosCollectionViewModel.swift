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

    private var date: Date

    var photos = [Photo]()
    private var nextPage = 1
    private var totalPages = 1
    var morePhotosAvailable = true

    init(date: Date) {
        self.date = date
    }

    func fetchPhotos() {

        guard morePhotosAvailable else {
            return
        }

        GetPhotosConfiguration(date: date, page: nextPage).start { [weak self] (result) in

            switch result {
            case let .success(getPhotosResponseWrapper):

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
